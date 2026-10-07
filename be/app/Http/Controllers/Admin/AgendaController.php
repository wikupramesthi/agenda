<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Concerns\HandlesTransactions;
use App\Models\Agenda;
use App\Services\HtmlSanitizer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class AgendaController extends Controller
{
    use HandlesTransactions;

    public function index(Request $request)
    {
        $baseQuery = Agenda::query()
            ->when($request->filled('status'), fn($q) => $q->where('status', $request->status))
            ->when($request->filled('tanggal_mulai'), fn($q) => $q->whereDate('tanggal', '>=', $request->tanggal_mulai))
            ->when($request->filled('tanggal_selesai'), fn($q) => $q->whereDate('tanggal', '<=', $request->tanggal_selesai))
            ->when($request->filled('search'), fn($q) => $q->where('judul', 'like', '%' . $request->search . '%'));

        // Statistik dari query yang SUDAH difilter (tanpa paginasi).
        $stats = [
            'total'     => (clone $baseQuery)->count(),
            'published' => (clone $baseQuery)->where('status', 'published')->count(),
            'draft'     => (clone $baseQuery)->where('status', 'draft')->count(),
            'completed' => (clone $baseQuery)->where('status', 'completed')->count(),
            'cancelled' => (clone $baseQuery)->where('status', 'cancelled')->count(),
        ];

        $items = $baseQuery
            ->orderBy('tanggal', 'desc')
            ->paginate(10)->withQueryString();

        return view('pages.agenda.index', [
            'title' => 'Agenda',
            'items' => $items,
            'stats' => $stats,
            'status' => $request->status,
            'tanggal_mulai' => $request->tanggal_mulai,
            'tanggal_selesai' => $request->tanggal_selesai,
        ]);
    }

    public function create()
    {
        return view('pages.agenda.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'judul'          => 'required|string|max:255',
            'deskripsi'      => 'required|string',
            'gambar'         => 'required|image|mimes:jpg,jpeg,png,webp|max:2048',
            'tanggal'        => 'required|date',
            'waktu_mulai'    => 'nullable|date_format:H:i',
            'waktu_selesai'  => 'nullable|date_format:H:i|after_or_equal:waktu_mulai',
            'lokasi'         => 'nullable|string|max:255',
            'status'         => 'required|in:draft,published,cancelled,completed',
        ]);

        $path = null;
        try {
            $path = $request->file('gambar')->store('agenda', 'public');
            \Illuminate\Support\Facades\DB::beginTransaction();
            $slug = $this->uniqueSlug($request->judul);
            Agenda::create([
                'judul'         => $request->judul,
                'slug'          => $slug,
                'deskripsi'     => HtmlSanitizer::clean($request->deskripsi),
                'gambar'        => $path,
                'tanggal'       => $request->tanggal,
                'waktu_mulai'   => $request->waktu_mulai,
                'waktu_selesai' => $request->waktu_selesai,
                'lokasi'        => $request->lokasi,
                'status'        => $request->status,
            ]);
            \Illuminate\Support\Facades\DB::commit();
            return redirect()->route('agenda.index')->with('success', 'Agenda berhasil ditambahkan.');
        } catch (\Throwable $e) {
            \Illuminate\Support\Facades\DB::rollBack();
            if ($path && Storage::disk('public')->exists($path)) Storage::disk('public')->delete($path);
            return back()->withInput()->with('error', $e->getMessage());
        }
    }

    public function show(string $uuid)
    {
        $item = Agenda::where('uuid', $uuid)->firstOrFail();
        return view('pages.agenda.show', compact('item'));
    }

    public function edit(string $uuid)
    {
        $item = Agenda::where('uuid', $uuid)->firstOrFail();
        return view('pages.agenda.edit', compact('item'));
    }

    public function update(Request $request, string $uuid)
    {
        $item = Agenda::where('uuid', $uuid)->firstOrFail();
        $request->validate([
            'judul'          => 'required|string|max:255',
            'deskripsi'      => 'required|string',
            'gambar'         => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
            'tanggal'        => 'required|date',
            'waktu_mulai'    => 'nullable|date_format:H:i',
            'waktu_selesai'  => 'nullable|date_format:H:i|after_or_equal:waktu_mulai',
            'lokasi'         => 'nullable|string|max:255',
            'status'         => 'required|in:draft,published,cancelled,completed',
        ]);

        $oldPath = $item->gambar;
        $newPath = null;
        try {
            if ($request->hasFile('gambar')) {
                $newPath = $request->file('gambar')->store('agenda', 'public');
            }
            \Illuminate\Support\Facades\DB::beginTransaction();
            $slug = $this->uniqueSlug($request->judul, $item->uuid);
            $item->update([
                'judul'         => $request->judul,
                'slug'          => $slug,
                'deskripsi'     => HtmlSanitizer::clean($request->deskripsi),
                'gambar'        => $newPath ?? $oldPath,
                'tanggal'       => $request->tanggal,
                'waktu_mulai'   => $request->waktu_mulai,
                'waktu_selesai' => $request->waktu_selesai,
                'lokasi'        => $request->lokasi,
                'status'        => $request->status,
            ]);
            \Illuminate\Support\Facades\DB::commit();
            if ($newPath && $oldPath && Storage::disk('public')->exists($oldPath)) {
                Storage::disk('public')->delete($oldPath);
            }
            return redirect()->route('agenda.index')->with('success', 'Agenda berhasil diperbarui.');
        } catch (\Throwable $e) {
            \Illuminate\Support\Facades\DB::rollBack();
            if ($newPath && Storage::disk('public')->exists($newPath)) Storage::disk('public')->delete($newPath);
            return back()->withInput()->with('error', $e->getMessage());
        }
    }

    public function destroy(string $uuid)
    {
        $item = Agenda::where('uuid', $uuid)->firstOrFail();
        $path = $item->gambar;
        \Illuminate\Support\Facades\DB::beginTransaction();
        try {
            $item->delete();
            \Illuminate\Support\Facades\DB::commit();
            if ($path && Storage::disk('public')->exists($path)) Storage::disk('public')->delete($path);
            return back()->with('success', 'Agenda berhasil dihapus.');
        } catch (\Throwable $e) {
            \Illuminate\Support\Facades\DB::rollBack();
            return back()->with('error', $e->getMessage());
        }
    }

    private function uniqueSlug(string $judul, ?string $ignoreUuid = null): string
    {
        $base = Str::slug($judul);
        $slug = $base;
        $i = 1;
        while (Agenda::where('slug', $slug)->when($ignoreUuid, fn($q) => $q->where('uuid', '!=', $ignoreUuid))->exists()) {
            $slug = $base . '-' . $i++;
        }
        return $slug;
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request->input('ids', []);

        if (! is_array($ids) || empty($ids)) {
            return back()->with('error', 'Tidak ada agenda yang dipilih.');
        }

        $ids = array_slice(array_values(array_unique(array_filter($ids))), 0, 100);
        $items = Agenda::whereIn('uuid', $ids)->get();

        if ($items->isEmpty()) {
            return back()->with('error', 'Data yang dipilih tidak ditemukan.');
        }

        $paths = $items->pluck('gambar')->filter()->all();

        \Illuminate\Support\Facades\DB::beginTransaction();
        try {
            Agenda::whereIn('uuid', $items->pluck('uuid')->all())->delete();
            \Illuminate\Support\Facades\DB::commit();
            foreach ($paths as $path) {
                if (Storage::disk('public')->exists($path)) Storage::disk('public')->delete($path);
            }
            return back()->with('success', $items->count() . ' agenda berhasil dihapus.');
        } catch (\Throwable $e) {
            \Illuminate\Support\Facades\DB::rollBack();
            return back()->with('error', $e->getMessage());
        }
    }
}
