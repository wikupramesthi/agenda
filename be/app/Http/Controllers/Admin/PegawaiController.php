<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Department;
use App\Models\Kecamatan;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class PegawaiController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $users = User::whereHas('roles', function ($query) {
            $query->where('name', 'pegawai');
        })
            ->when($request->filled('search'), function ($query) use ($request) {
                $search = $request->search;
                $query->where(function ($q) use ($search) {
                    $q->where('name', 'like', "%{$search}%")
                        ->orWhere('email', 'like', "%{$search}%")
                        ->orWhere('no_hp', 'like', "%{$search}%");
                });
            })
            ->when($request->filled('start_date'), function ($query) use ($request) {
                $query->whereDate('created_at', '>=', $request->start_date);
            })
            ->when($request->filled('end_date'), function ($query) use ($request) {
                $query->whereDate('created_at', '<=', $request->end_date);
            })
            ->when($request->filled('jenis_kelamin'), function ($query) use ($request) {
                $query->where('jenis_kelamin', $request->jenis_kelamin);
            })
            ->when($request->filled('department'), function ($query) use ($request) {
                $query->whereHas('departments', function ($q) use ($request) {
                    $q->where('departments.uuid', $request->department);
                });
            })
            ->with(['departments', 'kecamatan', 'kelurahan'])
            ->latest()
            ->paginate(10)->withQueryString();

        $departments = Department::where('is_active', 'active')
            ->orderBy('name')
            ->get();

        $search = $request->input('search');

        return view('pages.pegawai.index', compact(
            'users',
            'departments',
            'search'
        ));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $departments = Department::where('is_active', 'active')
            ->orderBy('name')
            ->get();
        $kecamatans = Kecamatan::orderBy('nama')->get();

        return view('pages.pegawai.create', compact('departments', 'kecamatans'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'avatar'         => 'required|image|mimes:jpg,jpeg,png,webp|max:2048',
            'name'           => 'required|string|max:255',
            'email'          => 'required|email|unique:users,email',
            'no_hp'          => 'nullable|string|max:20|unique:users,no_hp',
            'nip'            => 'nullable|string|max:30',
            'alamat'         => 'nullable|string',
            'kecamatan_id'   => 'nullable|exists:kecamatans,id',
            'kelurahan_id'   => 'nullable|exists:kelurahans,id',
            'tempat_lahir'   => 'nullable|string|max:100',
            'tanggal_lahir'  => 'nullable|date',
            'jenis_kelamin'  => 'nullable|in:L,P',
            'agama'          => 'nullable|in:Islam,Kristen,Katolik,Hindu,Buddha,Konghucu,Lainnya',
            'is_pejabat'     => 'nullable|boolean',
            'is_active'      => 'nullable|in:active,inactive',
            'urutan_pejabat' => 'nullable|integer|min:1',
            'unit_kerja'     => 'nullable|string|max:255',
            'riwayat'        => 'nullable|string',

            'departments'    => 'required|array|min:1',
            'departments.*'  => 'uuid|exists:departments,uuid',
        ]);

        DB::beginTransaction();
        try {
            $avatarPath = $request->file('avatar')->store('avatars', 'public');

            $user = User::create([
                'uuid'             => (string) Str::uuid(),
                'avatar'           => $avatarPath,
                'name'             => $validated['name'],
                'email'            => $validated['email'],
                'password'         => Hash::make('password'),
                'email_verified_at' => now(),
                'no_hp'            => $validated['no_hp'] ?? null,
                'nip'              => $validated['nip'] ?? null,
                'alamat'           => $validated['alamat'] ?? null,
                'kecamatan_id'     => $validated['kecamatan_id'] ?? null,
                'kelurahan_id'     => $validated['kelurahan_id'] ?? null,
                'tempat_lahir'     => $validated['tempat_lahir'] ?? null,
                'tanggal_lahir'    => $validated['tanggal_lahir'] ?? null,
                'jenis_kelamin'    => $validated['jenis_kelamin'] ?? null,
                'agama'            => $validated['agama'] ?? null,
                'is_pejabat'       => array_key_exists('is_pejabat', $validated) ? (int) (bool) $validated['is_pejabat'] : false,
                'is_active'        => $validated['is_active'] ?? 'active',
                'urutan_pejabat'   => $validated['urutan_pejabat'] ?? null,
                'unit_kerja'       => $validated['unit_kerja'] ?? null,
                'riwayat'          => $validated['riwayat'] ?? null,
            ]);

            $user->assignRole('pegawai');
            $user->departments()->sync($validated['departments']);

            DB::commit();

            return redirect()->route('pegawai.index')->with('success', 'Data pegawai berhasil disimpan.');
        } catch (\Throwable $th) {
            DB::rollBack();

            return redirect()->back()->withInput()->with('error', $th->getMessage());
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(User $pegawai)
    {
        return redirect()->route('pegawai.index');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(User $pegawai)
    {
        $authUser = auth()->user();

        if (! $authUser->hasRole(['admin', 'super-admin']) && $authUser->uuid !== $pegawai->uuid) {
            abort(403, 'Anda tidak memiliki akses ke data ini.');
        }

        $departments = Department::where('is_active', 'active')
            ->orderBy('name')
            ->get();
        $kecamatans = Kecamatan::orderBy('nama')->get();

        return view('pages.pegawai.edit', compact(
            'pegawai',
            'departments',
            'kecamatans'
        ));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, User $pegawai)
    {
        $authUser = auth()->user();

        if (! $authUser->hasRole(['admin', 'super-admin']) && $authUser->uuid !== $pegawai->uuid) {
            abort(403, 'Anda tidak memiliki akses ke data ini.');
        }

        $validated = $request->validate([
            'avatar'         => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
            'name'           => 'required|string|max:255',
            'email'          => 'required|email|unique:users,email,' . $pegawai->uuid . ',uuid',
            'no_hp'          => 'nullable|string|max:20|unique:users,no_hp,' . $pegawai->uuid . ',uuid',
            'nip'            => 'nullable|string|max:30',
            'alamat'         => 'nullable|string',
            'kecamatan_id'   => 'nullable|exists:kecamatans,id',
            'kelurahan_id'   => 'nullable|exists:kelurahans,id',
            'tempat_lahir'   => 'nullable|string|max:100',
            'tanggal_lahir'  => 'nullable|date',
            'jenis_kelamin'  => 'nullable|in:L,P',
            'agama'          => 'nullable|in:Islam,Kristen,Katolik,Hindu,Buddha,Konghucu,Lainnya',
            'is_pejabat'     => 'nullable|boolean',
            'is_active'      => 'nullable|in:active,inactive',
            'urutan_pejabat' => 'nullable|integer|min:1',
            'unit_kerja'     => 'nullable|string|max:255',
            'riwayat'        => 'nullable|string',

            'departments'    => 'required|array|min:1',
            'departments.*'  => 'uuid|exists:departments,uuid',
        ]);

        DB::beginTransaction();
        try {
            $pegawai->fill([
                'name'           => $validated['name'],
                'email'          => $validated['email'],
                'no_hp'          => $validated['no_hp'] ?? null,
                'nip'            => $validated['nip'] ?? null,
                'alamat'         => $validated['alamat'] ?? null,
                'kecamatan_id'   => $validated['kecamatan_id'] ?? null,
                'kelurahan_id'   => $validated['kelurahan_id'] ?? null,
                'tempat_lahir'   => $validated['tempat_lahir'] ?? null,
                'tanggal_lahir'  => $validated['tanggal_lahir'] ?? null,
                'jenis_kelamin'  => $validated['jenis_kelamin'] ?? null,
                'agama'          => $validated['agama'] ?? null,
                'is_pejabat'     => array_key_exists('is_pejabat', $validated) ? (int) (bool) $validated['is_pejabat'] : false,
                'is_active'      => $validated['is_active'] ?? $pegawai->is_active ?? 'active',
                'urutan_pejabat' => $validated['urutan_pejabat'] ?? null,
                'unit_kerja'     => $validated['unit_kerja'] ?? null,
                'riwayat'        => $validated['riwayat'] ?? null,
            ]);

            if ($request->hasFile('avatar')) {
                if ($pegawai->avatar && Storage::disk('public')->exists($pegawai->avatar)) {
                    Storage::disk('public')->delete($pegawai->avatar);
                }
                $pegawai->avatar = $request->file('avatar')->store('avatars', 'public');
            }

            $pegawai->save();
            $pegawai->departments()->sync($validated['departments']);

            DB::commit();

            return redirect()->route('pegawai.index')->with('success', 'Data pegawai berhasil diperbarui.');
        } catch (\Throwable $th) {
            DB::rollBack();

            return redirect()->back()->withInput()->with('error', $th->getMessage());
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(User $pegawai)
    {
        $authUser = auth()->user();

        if (! $authUser->hasRole(['admin', 'super-admin'])) {
            abort(403, 'Anda tidak memiliki akses untuk menghapus data ini.');
        }

        try {
            $pegawai->delete();

            return redirect()
                ->route('pegawai.index')
                ->with('success', 'Data pegawai berhasil dihapus.');
        } catch (\Throwable $th) {
            return redirect()
                ->route('pegawai.index')
                ->with('error', 'Gagal menghapus data: ' . $th->getMessage());
        }
    }
}
