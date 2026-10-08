<?php

namespace App\Http\Controllers\Dashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Category;
use App\Models\Reference;
use Illuminate\Support\Facades\DB;
use GuzzleHttp\Client;
use Carbon\Carbon;
use App\Models\User;
use App\Models\VisitorLog;
use App\Models\Agenda;
use App\Models\Kontak;
use App\Models\Faq;
use App\Models\Page;
use App\Models\Document;
use App\Models\Aduan;
use App\Models\Album;
use App\Services\SystemHealthService;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Str;

class DashboardController extends Controller
{
    public function __construct(protected SystemHealthService $health) {}

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        // Warga (role user, bukan petugas) mendapat dashboard pengaduan milik sendiri.
        if (
            $request->user()->hasRole('user') &&
            !$request->user()->hasAnyRole(['super-admin', 'admin', 'uptd'])
        ) {
            return $this->memberDashboard();
        }

        // Parse date range
        $startDate = $request->filled('start_date')
            ? Carbon::parse($request->start_date)->startOfDay()
            : now()->subDays(30)->startOfDay();
        $endDate = $request->filled('end_date')
            ? Carbon::parse($request->end_date)->endOfDay()
            : now()->endOfDay();

        $dateRangeLabel = $startDate->format('d M Y') . ' - ' . $endDate->format('d M Y');
        $daysDiff = (int) $startDate->diffInDays($endDate) + 1;

        // Visitor statistics for date range - cache 5 menit per range
        $cacheKeyBase = 'dashboard_' . $startDate->format('Ymd') . '_' . $endDate->format('Ymd');
        $visitorStats = Cache::remember($cacheKeyBase . '_visitor', 300, fn () => VisitorLog::getStatsForRange($startDate, $endDate));

        // Content statistics for date range - cache 1 menit per range
        $cacheKeyStats = 'dashboard_stats_' . $startDate->format('Ymd') . '_' . $endDate->format('Ymd');
        $contentStats = Cache::remember($cacheKeyStats, 60, fn () => [
            'totalAgendas' => Agenda::whereBetween('created_at', [$startDate, $endDate])->count(),
            'publishedAgendas' => Agenda::where('status', 'published')
                ->whereBetween('created_at', [$startDate, $endDate])->count(),
            'totalMessages' => Kontak::whereBetween('created_at', [$startDate, $endDate])->count(),
            'unreadMessages' => Kontak::where('status', 'open')
                ->whereBetween('created_at', [$startDate, $endDate])->count(),
            'totalFaq' => Faq::where('status', 'active')->count(),
            'totalPages' => Page::count(),
            'totalDocuments' => Document::count(),
            'totalOpdAktif' => User::role('opd')->count(),
            'totalGaleri' => Album::where('status', 'active')->count(),
        ]);

        extract($contentStats);


        // Tren agenda masuk per bulan (6 bulan terakhir) untuk grafik OPD
        $agendaTrenLabels = [];
        $agendaTrenData = [];
        $agendaPendingData = [];
        for ($i = 5; $i >= 0; $i--) {
            $bulan = now()->subMonths($i);
            $agendaTrenLabels[] = $bulan->translatedFormat('M Y');
            $agendaTrenData[] = Agenda::whereYear('created_at', $bulan->year)
                ->whereMonth('created_at', $bulan->month)
                ->count();
            $agendaPendingData[] = Agenda::where('status', 'pending')
                ->whereYear('created_at', $bulan->year)
                ->whereMonth('created_at', $bulan->month)
                ->count();
        }

        // Top 5 OPD pengirim agenda terbanyak + antrean pending terbaru
        $topOpd = User::role('opd')
            ->withCount(['agendas as total_agenda', 'agendas as pending_agenda' => fn ($q) => $q->where('status', 'pending')])
            ->orderByDesc('total_agenda')
            ->limit(5)
            ->get(['uuid', 'name', 'avatar']);

        // Agenda paling banyak dilihat
        $topViewedAgendas = Agenda::where('status', 'published')
            ->orderByDesc('views')
            ->limit(5)
            ->get(['uuid', 'slug', 'title', 'views', 'created_at']);

        // Agenda per kategori (untuk chart)
        $agendaKategori = Category::withCount('agendas')->orderByDesc('agendas_count')->get();
        $agendaKategoriLabels = $agendaKategori->pluck('name');
        $agendaKategoriData = $agendaKategori->pluck('agendas_count');

        // Komposisi konten (untuk chart donut)
        $komposisiKontenLabels = ['Halaman', 'Dokumen', 'FAQ', 'Agenda'];
        $komposisiKontenData = [Page::count(), Document::count(), Faq::count(), Agenda::count()];

        // Browser & kota asal pengunjung (untuk chart)
        $browserStats = VisitorLog::whereBetween('visited_at', [$startDate, $endDate])
            ->selectRaw('browser, count(*) as total')
            ->groupBy('browser')
            ->orderByDesc('total')
            ->limit(5)
            ->pluck('total', 'browser');
        $kotaStats = VisitorLog::whereBetween('visited_at', [$startDate, $endDate])
            ->whereNotNull('city')
            ->selectRaw('city, count(*) as total')
            ->groupBy('city')
            ->orderByDesc('total')
            ->limit(5)
            ->pluck('total', 'city');

        // OPD tidak isi agenda dalam 7 hari terakhir
        $opdTidakAktif = User::role('opd')
            ->whereDoesntHave('agendas', fn ($q) => $q->where('created_at', '>=', now()->subDays(7)))
            ->orderBy('name')
            ->get(['uuid', 'name', 'avatar'])
            ->map(function ($user) {
                $lastAgenda = $user->agendas()->latest('created_at')->first(['created_at']);
                return [
                    'name' => $user->name,
                    'avatar' => $user->avatar,
                    'last_agenda' => $lastAgenda ? $lastAgenda->created_at : null,
                ];
            });
        $pendingAgendas = Agenda::with('user')
            ->where('status', 'pending')
            ->latest('created_at')
            ->limit(5)
            ->get(['uuid', 'title', 'user_uuid', 'created_at']);

        // Antrean approval agenda (OPD: milik sendiri, admin: semua)
        $pendingCountQuery = Agenda::where('status', 'pending');
        if (! $request->user()->hasAnyRole(['super-admin', 'admin'])) {
            $pendingCountQuery->where('user_uuid', $request->user()->uuid);
        }
        $pendingCount = $pendingCountQuery->count();
        $prevStart = $startDate->copy()->subDays($daysDiff);
        $prevEnd = $startDate->copy()->subSecond();

        $visitorGrowth = $this->growth($visitorStats['total_visits'], VisitorLog::whereBetween('visited_at', [$prevStart, $prevEnd])->count());
        $uniqueGrowth = $this->growth($visitorStats['unique_visitors'], VisitorLog::whereBetween('visited_at', [$prevStart, $prevEnd])->distinct('ip_address')->count());
        $agendaGrowth = $this->growth($totalAgendas, Agenda::whereBetween('created_at', [$prevStart, $prevEnd])->count());
        $publishedGrowth = $this->growth($publishedAgendas, Agenda::where('status', 'published')->whereBetween('created_at', [$prevStart, $prevEnd])->count());
        $messageGrowth = $this->growth($totalMessages, Kontak::whereBetween('created_at', [$prevStart, $prevEnd])->count());

        // Ringkasan kesehatan sistem untuk widget dashboard (single source via SystemHealthService)
        $schedulerTerakhir = $this->health->getSchedulerLastRun();
        $schedulerOk = $this->health->isSchedulerOk($schedulerTerakhir);
        $storageOk = $this->health->isStorageOk();

        // Recent activities for date range
        $recentActivities = $this->getRecentActivities($startDate, $endDate);

        return view('pages.dashboard.index', compact(
            'visitorStats',
            'recentActivities',
            'totalAgendas',
            'publishedAgendas',
            'totalMessages',
            'unreadMessages',
            'totalFaq',
            'totalPages',
            'totalDocuments',
            'totalOpdAktif',
            'totalGaleri',
            'agendaTrenLabels',
            'agendaTrenData',
            'agendaPendingData',
            'topOpd',
            'pendingAgendas',
            'opdTidakAktif',
            'topViewedAgendas',
            'agendaKategoriLabels',
            'agendaKategoriData',
            'komposisiKontenLabels',
            'komposisiKontenData',
            'browserStats',
            'kotaStats',
            'pendingCount',
            'schedulerTerakhir',
            'schedulerOk',
            'storageOk',
            'dateRangeLabel',
            'startDate',
            'endDate',
            'daysDiff',
            'visitorGrowth',
            'uniqueGrowth',
            'agendaGrowth',
            'publishedGrowth',
            'messageGrowth'
        ));
    }

    protected function growth(int $current, int $previous): float
    {
        return $previous > 0 ? round(($current - $previous) / $previous * 100, 1) : 0;
    }

    /**
     * Dashboard warga: ringkasan & riwayat pengaduan milik sendiri.
     */
    protected function memberDashboard()
    {
        $user = Auth::user();

        $base = Aduan::where('user_uuid', $user->uuid);

        $statTotal = (clone $base)->count();
        $statMenunggu = (clone $base)->where('status', 'menunggu')->count();
        $statDiproses = (clone $base)->whereIn('status', ['diverifikasi', 'diproses'])->count();
        $statSelesai = (clone $base)->where('status', 'selesai')->count();
        $belumDinilai = (clone $base)->where('status', 'selesai')->whereNull('rating')->count();

        $recentAduan = (clone $base)
            ->with(['kecamatan', 'kelurahan'])
            ->orderByDesc('tanggal_pengaduan')
            ->limit(6)
            ->get();

        return view('pages.dashboard.index', compact(
            'statTotal',
            'statMenunggu',
            'statDiproses',
            'statSelesai',
            'belumDinilai',
            'recentAduan'
        ));
    }

    protected function getRecentActivities(Carbon $startDate, Carbon $endDate, int $limit = 5): array
    {
        $activities = [];

        // Recent agendas
        $recentAgendas = Agenda::whereBetween('created_at', [$startDate, $endDate])
            ->latest('created_at')
            ->limit(5)
            ->get(['uuid', 'slug', 'title', 'status', 'created_at']);

        foreach ($recentAgendas as $agenda) {
            $activities[] = [
                'type' => 'agenda',
                'icon' => 'bi-file-earmark-text',
                'color' => 'primary',
                'title' => 'Agenda ' . ($agenda->status === 'published' ? 'dipublikasikan' : 'dibuat'),
                'description' => $agenda->title,
                'time' => $agenda->created_at,
                'date' => $agenda->created_at->translatedFormat('d M Y'),
                'url' => route('agendas.show', $agenda->slug),
            ];
        }

        // Recent messages
        $recentMessages = Kontak::whereBetween('created_at', [$startDate, $endDate])
            ->latest('created_at')
            ->limit(3)
            ->get(['uuid', 'nama', 'isi', 'created_at']);

        foreach ($recentMessages as $message) {
            $activities[] = [
                'type' => 'message',
                'icon' => 'bi-envelope',
                'color' => 'success',
                'title' => 'Pesan baru dari ' . $message->nama,
                'description' => Str::limit($message->isi, 50),
                'time' => $message->created_at,
                'date' => $message->created_at->translatedFormat('d M Y'),
                'url' => route('layanan.kontak'),
            ];
        }

        // Sort by time and limit
        usort($activities, fn($a, $b) => $b['time'] <=> $a['time']);

        return array_slice($activities, 0, $limit);
    }

    public function deviceStats(Request $request)
    {
        $startDate = $request->filled('start_date')
            ? Carbon::parse($request->start_date)->startOfDay()
            : now()->subDays(30)->startOfDay();
        $endDate = $request->filled('end_date')
            ? Carbon::parse($request->end_date)->endOfDay()
            : now()->endOfDay();

        $deviceStats = VisitorLog::getDeviceStatsForRange($startDate, $endDate);

        return response()->json($deviceStats);
    }

    public function submitSumber(Request $request)
    {
        $request->validate([
            'no_hp' => [
                'required',
                'regex:/^[0-9]{8,15}$/',
                'unique:users,no_hp,' . Auth::user()->uuid . ',uuid',
            ],
            'sumber_informasi' => [
                'required',
                'string',
                'max:255',
            ],
        ], [
            'no_hp.required' => 'Nomor WhatsApp wajib diisi.',
            'no_hp.regex'    => 'Format nomor WhatsApp tidak valid.',
            'no_hp.unique'   => 'Nomor WhatsApp sudah terdaftar.',

            'sumber_informasi.required' => 'Sumber informasi wajib dipilih.',
            'sumber_informasi.string'   => 'Sumber informasi tidak valid.',
            'sumber_informasi.max'      => 'Sumber informasi terlalu panjang.',
        ]);

        $user = Auth::user();

        $no_hp = trim($request->no_hp);

        $user->update([
            'no_hp'             => $no_hp,
            'sumber_informasi'  => $request->sumber_informasi,
        ]);

        Auth::setUser($user->fresh());

        return redirect()
            ->route('dashboard.index')
            ->with(
                'success',
                'Data Anda telah berhasil disimpan. Terima kasih atas informasi yang telah diberikan.'
            );
    }
}
