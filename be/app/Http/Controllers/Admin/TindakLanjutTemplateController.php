<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\TindakLanjutTemplate;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class TindakLanjutTemplateController extends Controller
{
    /**
     * Daftar template + form tambah/ubah dalam satu halaman.
     */
    public function index(Request $request)
    {
        $editItem = null;

        if ($request->filled('edit')) {
            $editItem = TindakLanjutTemplate::where('uuid', $request->edit)->first();
        }

        $items = TindakLanjutTemplate::orderBy('judul')->get();

        return view('pages.template-tindak-lanjut.index', [
            'title' => 'Template Respons',
            'items' => $items,
            'editItem' => $editItem,
        ]);
    }

    /**
     * Simpan template baru.
     */
    public function store(Request $request)
    {
        $request->validate([
            'judul' => 'required|string|max:150',
            'isi' => 'required|string|max:2000',
        ]);

        TindakLanjutTemplate::create([
            'uuid' => (string) Str::uuid(),
            'judul' => $request->judul,
            'isi' => $request->isi,
            'is_active' => $request->boolean('is_active'),
        ]);

        return redirect()
            ->route('templates.index')
            ->with('success', 'Template berhasil ditambahkan.');
    }

    /**
     * Perbarui template.
     */
    public function update(Request $request, $uuid)
    {
        $item = TindakLanjutTemplate::where('uuid', $uuid)->firstOrFail();

        $request->validate([
            'judul' => 'required|string|max:150',
            'isi' => 'required|string|max:2000',
        ]);

        $item->update([
            'judul' => $request->judul,
            'isi' => $request->isi,
            'is_active' => $request->boolean('is_active'),
        ]);

        return redirect()
            ->route('templates.index')
            ->with('success', 'Template berhasil diperbarui.');
    }

    /**
     * Hapus template.
     */
    public function destroy($uuid)
    {
        $item = TindakLanjutTemplate::where('uuid', $uuid)->firstOrFail();
        $item->delete();

        return redirect()
            ->route('templates.index')
            ->with('success', 'Template berhasil dihapus.');
    }
}
