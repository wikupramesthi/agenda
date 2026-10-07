<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Concerns\HandlesTransactions;
use App\Models\MaintenanceSchedule;
use App\Models\Aduan;
use Illuminate\Http\Request;

class MaintenanceScheduleController extends Controller
{
    use HandlesTransactions;

    public function index(Request $request)
    {
        $q = MaintenanceSchedule::with(['aduan', 'petugas'])
            ->when($request->filled('status'), fn($qq) => $qq->where('status', $request->input('status')))
            ->when($request->filled('search'), fn($qq) => $qq->where('judul', 'like', '%' . $request->input('search') . '%'))
            ->latest('tanggal_rencana');

        $items = $q->paginate(15)->withQueryString();
        $stats = [
            'terjadwal' => MaintenanceSchedule::where('status', 'terjadwal')->count(),
            'berjalan' => MaintenanceSchedule::where('status', 'berjalan')->count(),
            'terlambat' => MaintenanceSchedule::where('status', '!=', 'selesai')->whereDate('tanggal_rencana', '<', now())->count(),
        ];

        return view('pages.maintenance.index', compact('items', 'stats'));
    }

    public function create()
    {
        $aduans = Aduan::whereIn('status', ['diproses', 'diverifikasi'])->orderByDesc('tanggal_pengaduan')->limit(100)->get();
        return view('pages.maintenance.create', compact('aduans'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'judul' => 'required|string|max:255',
            'aduan_uuid' => 'nullable|exists:aduans,uuid',
            'tanggal_rencana' => 'required|date',
            'tanggal_selesai' => 'nullable|date|after_or_equal:tanggal_rencana',
            'status' => 'required|in:terjadwal,berjalan,selesai,tertunda',
            'keterangan' => 'nullable|string|max:2000',
        ]);

        return $this->transactional(function () use ($request) {
            MaintenanceSchedule::create([
                'judul' => $request->judul,
                'aduan_uuid' => $request->aduan_uuid,
                'tanggal_rencana' => $request->tanggal_rencana,
                'tanggal_selesai' => $request->tanggal_selesai,
                'status' => $request->status,
                'keterangan' => $request->keterangan,
                'petugas_uuid' => auth()->user()->uuid ?? null,
            ]);
        }, 'Jadwal pemeliharaan berhasil dibuat.');
    }

    public function edit($uuid)
    {
        $item = MaintenanceSchedule::where('uuid', $uuid)->firstOrFail();
        $aduans = Aduan::orderByDesc('tanggal_pengaduan')->limit(100)->get();
        return view('pages.maintenance.edit', compact('item', 'aduans'));
    }

    public function update(Request $request, $uuid)
    {
        $request->validate([
            'judul' => 'required|string|max:255',
            'tanggal_rencana' => 'required|date',
            'tanggal_selesai' => 'nullable|date|after_or_equal:tanggal_rencana',
            'status' => 'required|in:terjadwal,berjalan,selesai,tertunda',
            'keterangan' => 'nullable|string|max:2000',
        ]);

        return $this->transactional(function () use ($request, $uuid) {
            $item = MaintenanceSchedule::where('uuid', $uuid)->firstOrFail();
            $item->update($request->only(['judul', 'tanggal_rencana', 'tanggal_selesai', 'status', 'keterangan']));
            if ($request->status === 'selesai' && !$item->tanggal_selesai) {
                $item->update(['tanggal_selesai' => now()->toDateString()]);
            }
        }, 'Jadwal diperbarui.');
    }

    public function destroy($uuid)
    {
        return $this->transactional(function () use ($uuid) {
            MaintenanceSchedule::where('uuid', $uuid)->firstOrFail()->delete();
        }, 'Jadwal dihapus.');
    }
}
