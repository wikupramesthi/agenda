<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Concerns\HandlesTransactions;
use App\Http\Requests\Agenda\StoreAgendaRequest;
use App\Http\Requests\Agenda\UpdateAgendaRequest;
use App\Models\Agenda;
use App\Models\AgendaImage;
use App\Models\Category;
use App\Models\User;
use App\Notifications\AgendaApprovedNotification;
use App\Notifications\AgendaRejectedNotification;
use App\Notifications\AgendaSubmittedNotification;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use App\Services\HtmlSanitizer;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\View\View;

class AgendaController extends Controller
{
    
    use HandlesTransactions;
private const IMAGE_DISK = 'public';

    private const IMAGE_DIRECTORY = 'images';

    /**
     * Admin/super-admin boleh publish langsung & menyetujui agenda OPD.
     * Role lain (mis. opd) hanya boleh input -> status dikunci 'pending'.
     */
    private function isApprover(?\App\Models\User $user = null): bool
    {
        $user ??= auth()->user();

        return (bool) $user?->hasAnyRole(['super-admin', 'admin']);
    }

    /**
     * Display a listing of the agendas.
     */
    public function index(Request $request): View
    {
        $search = $request->get('search');
        $start_date = $request->get('start_date');
        $end_date = $request->get('end_date');
        $status = $request->get('status');
        $isApprover = $this->isApprover($request->user());

        $baseQuery = Agenda::query()
            // OPD hanya melihat & mengelola agenda miliknya sendiri
            ->when(! $isApprover, fn ($query) => $query->where('user_uuid', $request->user()->uuid))
            ->when($start_date, fn ($query) => $query->whereDate('created_at', '>=', $start_date))
            ->when($end_date, fn ($query) => $query->whereDate('created_at', '<=', $end_date))
            ->when($status, fn ($query) => $query->where('status', $status))
            ->when($request->filled('search'), function ($query) use ($request) {
                $search = $request->search;
                $query->where('title', 'like', "%{$search}%")
                    ->orWhere('slug', 'like', "%{$search}%");
            });

        // Statistik dihitung dari query yang SUDAH difilter (tanpa paginasi),
        // sehingga angka pada card selalu sesuai dengan data hasil filter.
        $stats = [
            'total'     => (clone $baseQuery)->count(),
            'published' => (clone $baseQuery)->where('status', 'published')->count(),
            'pending'   => (clone $baseQuery)->where('status', 'pending')->count(),
            'draft'     => (clone $baseQuery)->where('status', 'draft')->count(),
            'featured'  => (clone $baseQuery)->where('is_featured', true)->count(),
            'popular'   => (clone $baseQuery)->where('is_popular', true)->count(),
        ];

        $agendas = $baseQuery
            ->with(['user', 'category', 'images'])
            ->latest('created_at')
            ->paginate(10)->withQueryString();

        return view('pages.agendas.index', compact('agendas', 'stats', 'start_date', 'end_date', 'status', 'search', 'isApprover'));
    }

    /**
     * Show the form for creating a new agenda.
     */
    public function create(): View
    {
        $categories = Category::orderBy('slug')->get();

        return view('pages.agendas.create', compact('categories'));
    }

    /**
     * Store a newly created agenda.
     */
    public function store(StoreAgendaRequest $request): RedirectResponse
    {
        $validated = $request->validated();
        $storedFiles = [];

        DB::beginTransaction();

        try {
            $agenda = new Agenda();
            $agenda->user_uuid = $request->user()->uuid;
            $validated['content'] = HtmlSanitizer::clean($validated['content']);
            // OPD wajib lewat approval: paksa 'pending' walau form mengirim status lain
            $status = $this->isApprover($request->user()) ? $validated['status'] : 'pending';
            $agenda->fill([
                'category_uuid' => $validated['category_uuid'],
                'title'         => $validated['title'],
                'slug'          => Str::slug($validated['title']),
                'excerpt'       => $validated['excerpt'] ?? null,
                'content'       => $validated['content'],
                'scheduled_at'  => $validated['scheduled_at'] ?? now(),
                'tagging'       => $validated['tagging'] ?? null,
                'video'         => $validated['video'] ?? null,
                'status'        => $status,
                'search_engine' => $validated['search_engine'],
                'is_featured'   => $request->boolean('is_featured'),
                'is_popular'    => $request->boolean('is_popular'),
            ]);

            if ($request->hasFile('featured_image')) {
                $agenda->featured_image = $request->file('featured_image')->store(self::IMAGE_DIRECTORY, self::IMAGE_DISK);
                $storedFiles[] = $agenda->featured_image;
            }

            $agenda->save();

            // storeImages akan catat file, tapi kita track manual agar bisa rollback file jika DB gagal
            $this->storeImages($agenda, $request, $storedFiles);
            $this->saveSeoData($agenda, $request);

            DB::commit();

            // Agenda OPD (pending) -> beri tahu admin agar segera direview
            if ($status === 'pending') {
                $this->notifyApprovers($agenda);
            }
        } catch (\Throwable $e) {
            DB::rollBack();
            foreach ($storedFiles as $f) {
                if ($f && Storage::disk(self::IMAGE_DISK)->exists($f)) {
                    Storage::disk(self::IMAGE_DISK)->delete($f);
                }
            }
            // bersihkan juga images yang sempat ter-create di DB tapi file sudah di-track
            Log::error('Gagal menyimpan agenda: ' . $e->getMessage(), ['exception' => $e]);

            return back()->withInput()->with('error', 'Gagal menyimpan agenda. Silakan coba lagi.');
        }

        return redirect()->route('agendas.index')->with('success', $this->isApprover($request->user()) ? 'Agenda berhasil disimpan.' : 'Agenda dikirim dan menunggu persetujuan admin.');
    }

    /**
     * Display the specified agenda.
     */
    public function show(string $slug): View
    {
        $agenda = Agenda::with('images')->where('slug', $slug)->firstOrFail();

        $sessionKey = 'agenda_viewed_' . $agenda->uuid;

        if (! session()->has($sessionKey)) {
            $agenda->incrementViews();
            session()->put($sessionKey, true);
        }

        return view('agendas.show', compact('agenda'));
    }

    /**
     * Show the form for editing the specified agenda.
     */
    public function edit(Agenda $agenda): View
    {
        // OPD hanya boleh ubah agenda miliknya sendiri
        if (! $this->isApprover() && $agenda->user_uuid !== auth()->user()->uuid) {
            abort(403, 'Anda tidak memiliki akses ke agenda ini.');
        }

        $categories = Category::orderBy('slug')->get();
        $agenda->load('images');

        return view('pages.agendas.edit', compact('agenda', 'categories'));
    }

    /**
     * Update the specified agenda.
     */
    public function update(UpdateAgendaRequest $request, Agenda $agenda): RedirectResponse
    {
        // OPD hanya boleh ubah agenda miliknya sendiri; edit OPD kembali ke 'pending'
        if (! $this->isApprover($request->user()) && $agenda->user_uuid !== $request->user()->uuid) {
            abort(403, 'Anda tidak memiliki akses ke agenda ini.');
        }

        $validated = $request->validated();
        $oldFeatured = $agenda->featured_image;
        $newFeatured = null;
        $storedFiles = [];
        $removedImagePaths = [];

        DB::beginTransaction();

        try {
            $validated['content'] = HtmlSanitizer::clean($validated['content']);
            if ($request->hasFile('featured_image')) {
                $newFeatured = $request->file('featured_image')->store(self::IMAGE_DIRECTORY, self::IMAGE_DISK);
                $storedFiles[] = $newFeatured;
                $agenda->featured_image = $newFeatured;
            }

            // OPD yang mengubah agenda (miliknya) otomatis kembali antre approval
            $status = $this->isApprover($request->user()) ? $validated['status'] : 'pending';

            $agenda->fill([
                'category_uuid' => $validated['category_uuid'],
                'title'         => $validated['title'],
                'slug'          => Str::slug($validated['title']),
                'excerpt'       => $validated['excerpt'] ?? null,
                'content'       => $validated['content'],
                'scheduled_at'  => $validated['scheduled_at'] ?? $agenda->scheduled_at ?? now(),
                'tagging'       => $validated['tagging'] ?? null,
                'video'         => $validated['video'] ?? null,
                'status'        => $status,
                'search_engine' => $validated['search_engine'],
                'is_featured'   => $request->boolean('is_featured'),
                'is_popular'    => $request->boolean('is_popular'),
            ])->save();

            // kumpulkan path yang akan dihapus dulu, hapus file setelah commit
            $removeUuids = (array) $request->input('remove_images', []);
            if (!empty($removeUuids)) {
                $removedImagePaths = $agenda->images()->whereIn('uuid', $removeUuids)->pluck('image_path')->all();
                $agenda->images()->whereIn('uuid', $removeUuids)->delete();
            }
            $this->storeImages($agenda, $request, $storedFiles);
            $this->saveSeoData($agenda, $request);

            DB::commit();

            // Edit OPD kembali pending -> beri tahu admin agar direview ulang
            if ($status === 'pending' && ! $this->isApprover($request->user())) {
                $this->notifyApprovers($agenda);
            }
            // baru hapus file lama setelah DB sukses (atomic)
            if ($newFeatured && $oldFeatured && $oldFeatured !== $newFeatured) {
                $this->deleteFile($oldFeatured);
            }
            foreach ($removedImagePaths as $p) {
                $this->deleteFile($p);
            }
        } catch (\Throwable $e) {
            DB::rollBack();
            foreach ($storedFiles as $f) {
                if ($f && Storage::disk(self::IMAGE_DISK)->exists($f)) {
                    Storage::disk(self::IMAGE_DISK)->delete($f);
                }
            }
            Log::error('Gagal memperbarui agenda: ' . $e->getMessage(), ['exception' => $e]);

            return back()->withInput()->with('error', 'Gagal memperbarui agenda. Silakan coba lagi.');
        }

        return redirect()->route('agendas.index')->with('success', $this->isApprover($request->user()) ? 'Agenda berhasil diperbarui.' : 'Perubahan dikirim dan menunggu persetujuan admin.');
    }

    /**
     * Kirim notifikasi ke admin/super-admin (kecuali penulis sendiri).
     */
    private function notifyApprovers(Agenda $agenda): void
    {
        try {
            $approvers = User::role(['super-admin', 'admin'])
                ->where('uuid', '!=', $agenda->user_uuid)
                ->get();

            foreach ($approvers as $approver) {
                $approver->notify(new AgendaSubmittedNotification(
                    $agenda->title,
                    $agenda->user?->name ?? 'OPD',
                    $agenda->uuid,
                ));
            }
        } catch (\Throwable $e) {
            Log::warning('Gagal kirim notifikasi agenda ke admin: ' . $e->getMessage());
        }
    }

    /**
     * Kirim notifikasi hasil review ke penulis agenda.
     */
    private function notifyAuthor(Agenda $agenda, object $notification): void
    {
        try {
            $author = $agenda->user;

            if ($author) {
                $author->notify($notification);
            }
        } catch (\Throwable $e) {
            Log::warning('Gagal kirim notifikasi agenda ke penulis: ' . $e->getMessage());
        }
    }

    /**
     * Setujui agenda OPD (pending -> published). Khusus admin.
     */
    public function approve(Agenda $agenda): RedirectResponse
    {
        if ($agenda->status !== 'pending') {
            return back()->with('error', 'Hanya agenda berstatus pending yang bisa disetujui.');
        }

        $agenda->update(['status' => 'published']);

        $this->notifyAuthor($agenda, new AgendaApprovedNotification($agenda->title, $agenda->uuid));

        return back()->with('success', "Agenda \"{$agenda->title}\" disetujui dan dipublikasikan.");
    }

    /**
     * Tolak agenda OPD (pending -> draft). Khusus admin.
     */
    public function reject(Agenda $agenda): RedirectResponse
    {
        if ($agenda->status !== 'pending') {
            return back()->with('error', 'Hanya agenda berstatus pending yang bisa ditolak.');
        }

        $agenda->update(['status' => 'draft']);

        $this->notifyAuthor($agenda, new AgendaRejectedNotification($agenda->title, $agenda->uuid));

        return back()->with('success', "Agenda \"{$agenda->title}\" dikembalikan sebagai draft.");
    }

    /**
     * Remove the specified agenda along with its files.
     */
    public function destroy(Agenda $agenda): RedirectResponse
    {
        $featured = $agenda->featured_image;
        $imagePaths = $agenda->images()->pluck('image_path')->all();

        DB::beginTransaction();

        try {
            $agenda->images()->delete();
            $agenda->delete();

            DB::commit();
            // hapus file setelah DB commit (atomic)
            $this->deleteFile($featured);
            foreach ($imagePaths as $p) {
                $this->deleteFile($p);
            }
        } catch (\Throwable $e) {
            DB::rollBack();
            Log::error('Gagal menghapus agenda: ' . $e->getMessage(), ['exception' => $e]);

            return back()->with('error', 'Gagal menghapus agenda. Silakan coba lagi.');
        }

        return back()->with('success', 'Agenda berhasil dihapus.');
    }

    /**
     * Remove the selected agendas along with their files.
     */
    public function bulkDestroy(Request $request): RedirectResponse
    {
        $ids = $request->input('ids', []);

        if (! is_array($ids) || empty($ids)) {
            return back()->with('error', 'Tidak ada agenda yang dipilih.');
        }

        $ids = array_slice(array_values(array_unique(array_filter($ids))), 0, 100);

        $agendas = Agenda::with('images')->whereIn('uuid', $ids)->get();

        if ($agendas->isEmpty()) {
            return back()->with('error', 'Data yang dipilih tidak ditemukan.');
        }

        $filePaths = [];
        foreach ($agendas as $agenda) {
            if ($agenda->featured_image) {
                $filePaths[] = $agenda->featured_image;
            }
            foreach ($agenda->images as $image) {
                $filePaths[] = $image->image_path;
            }
        }

        DB::beginTransaction();

        try {
            AgendaImage::whereIn('agenda_uuid', $agendas->pluck('uuid')->all())->delete();
            Agenda::whereIn('uuid', $agendas->pluck('uuid')->all())->delete();

            DB::commit();

            // hapus file setelah DB commit (atomic)
            foreach ($filePaths as $path) {
                $this->deleteFile($path);
            }
        } catch (\Throwable $e) {
            DB::rollBack();
            Log::error('Gagal menghapus agenda terpilih: ' . $e->getMessage(), ['exception' => $e]);

            return back()->with('error', 'Gagal menghapus agenda terpilih. Silakan coba lagi.');
        }

        return back()->with('success', $agendas->count() . ' agenda berhasil dihapus.');
    }

    /**
     * Store the uploaded slider photos for the given agenda.
     */
    private function storeImages(Agenda $agenda, Request $request, array &$storedFiles = []): void
    {
        if (! $request->hasFile('images')) {
            return;
        }

        $order = (int) $agenda->images()->max('sort_order');

        foreach ($request->file('images') as $file) {
            if (! $file || ! $file->isValid()) {
                continue;
            }

            $path = $file->store(self::IMAGE_DIRECTORY, self::IMAGE_DISK);
            $storedFiles[] = $path;
            $agenda->images()->create([
                'image_path' => $path,
                'sort_order' => ++$order,
            ]);
        }
    }

    /**
     * Delete the selected slider photos along with their files.
     *
     * @param  array<int, string>  $uuids
     */
    private function removeImages(Agenda $agenda, array $uuids): void
    {
        if (empty($uuids)) {
            return;
        }

        $agenda->images()
            ->whereIn('uuid', $uuids)
            ->get()
            ->each(function (AgendaImage $image) {
                $this->deleteFile($image->image_path);
                $image->delete();
            });
    }

    /**
     * Persist the SEO metadata for the given agenda.
     */
    private function saveSeoData(Agenda $agenda, Request $request): void
    {
        $agenda->seo()->updateOrCreate([], [
            'title'         => $agenda->title,
            'description'   => $agenda->excerpt,
            'image'         => $agenda->featured_image,
            'author'        => $request->user()->name,
            'robots'        => $agenda->search_engine ?? 'index, follow',
            'canonical_url' => route('agendas.show', $agenda->slug),
        ]);
    }

    /**
     * Delete a stored file when it exists.
     */
    private function deleteFile(?string $path): void
    {
        if ($path && Storage::disk(self::IMAGE_DISK)->exists($path)) {
            Storage::disk(self::IMAGE_DISK)->delete($path);
        }
    }
}
