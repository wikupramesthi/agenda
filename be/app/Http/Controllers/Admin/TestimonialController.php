<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Concerns\HandlesTransactions;
use App\Models\Testimonial;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;


class TestimonialController extends Controller
{
    
    use HandlesTransactions;
/**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $search = $request->input('search');
        $items = Testimonial::orderBy('urutan', 'ASC')
            ->when($search, function ($query) use ($search) {
                $query->where('nama', 'like', "%{$search}%")
                    ->orWhere('isi_testimoni', 'like', "%{$search}%");
            })
            ->paginate(10)->withQueryString();
        return view('pages.testimonial.index', [
            'title' => 'Testimonial',
            'items' => $items,
            'search' => $search,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'nama'          => 'required|string|max:255',
            'jabatan'       => 'nullable|string|max:255',
            'isi_testimoni' => 'required|string',
            'foto'          => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
            'urutan'        => 'required|integer|min:1|unique:testimonials,urutan',
            'is_active'     => 'required|in:active,inactive',

        ]);

        DB::beginTransaction();
        try {
            $data = $request->only(['nama', 'jabatan', 'isi_testimoni', 'urutan', 'is_active']);
            if ($request->hasFile('foto')) {
                $data['foto'] = $request->file('foto')->store('testimoni', 'public');
            }

            Testimonial::create([
                'uuid'          => (string) Str::uuid(),
                'nama'          => $data['nama'],
                'jabatan'       => $data['jabatan'],
                'isi_testimoni' => $data['isi_testimoni'],
                'foto'          => $data['foto'],
                'urutan'        => $data['urutan'],
                'is_active'     => $data['is_active'],
            ]);

            DB::commit();
            return redirect()->back()->with('success', 'Testimoni berhasil ditambahkan.');
        } catch (\Throwable $th) {
            DB::rollBack();
            return redirect()->back()->with('error', 'Gagal menambahkan testimoni: ' . $th->getMessage());
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $uuid)
    {
        $item = Testimonial::where('uuid', $uuid)->firstOrFail();

        $request->validate([
            'nama'          => 'required|string|max:255',
            'jabatan'       => 'nullable|string|max:255',
            'isi_testimoni' => 'required|string',
            'foto'          => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
            'urutan'        => [
                'required',
                'integer',
                'min:1',
                Rule::unique('testimonials', 'urutan')->ignore($item->id),
            ],
            'is_active'     => 'required|in:active,inactive',
        ]);

        DB::beginTransaction();

        try {
            $data = $request->only([
                'nama',
                'jabatan',
                'isi_testimoni',
                'urutan',
                'is_active',
            ]);

            if ($request->hasFile('foto')) {
                if ($item->foto && Storage::disk('public')->exists($item->foto)) {
                    Storage::disk('public')->delete($item->foto);
                }

                $data['foto'] = $request->file('foto')->store('testimoni', 'public');
            }

            $item->update($data);

            DB::commit();

            return redirect()
                ->back()
                ->with('success', 'Testimonial berhasil diperbarui.');
        } catch (\Throwable $th) {
            DB::rollBack();

            return redirect()
                ->back()
                ->with('error', $th->getMessage());
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($uuid)
    {
        $item = Testimonial::where('uuid', $uuid)->firstOrFail();

        if ($item->foto && Storage::disk('public')->exists($item->foto)) {
            Storage::disk('public')->delete($item->foto);
        }

        $item->delete();

        return redirect()->back()->with('success', 'Testimonial berhasil dihapus.');
    }
}
