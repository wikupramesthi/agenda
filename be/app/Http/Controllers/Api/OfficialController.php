<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;

class OfficialController extends Controller
{
    /**
     * GET /api/officials
     * Daftar pejabat (is_pejabat=1) urut urutan_pejabat, sinkron dengan
     * /informasi-pejabat frontend. Hanya field publik, tanpa email/no_hp.
     */
    public function index(): JsonResponse
    {
        try {
            $officials = User::query()
                ->where('is_pejabat', 1)
                ->whereHas('roles', fn ($q) => $q->where('name', 'pegawai'))
                ->where(function ($q) {
                    $q->where('is_active', 'active')->orWhereNull('is_active');
                })
                ->with('departments')
                ->orderByRaw('urutan_pejabat IS NULL, urutan_pejabat ASC')
                ->orderBy('name')
                ->get()
                ->map(function (User $user) {
                    $departments = $user->departments->pluck('name')->filter()->values()->all();
                    // Jabatan: pakai Department (jabatan), bukan unit_kerja
                    $position = ($departments[0] ?? $user->unit_kerja) ?: 'Pejabat DBMSDA';
                    $avatarUrl = null;
                    if ($user->avatar) {
                        $avatarUrl = '/storage/' . ltrim($user->avatar, '/');
                    }
                    return [
                        'uuid' => $user->uuid,
                        'name' => $user->name,
                        'position' => $position,
                        'departments' => $departments,
                        'unit_kerja' => $user->unit_kerja,
                        'avatar' => $user->avatar,
                        'avatar_url' => $avatarUrl,
                        'urutan_pejabat' => $user->urutan_pejabat,
                    ];
                });

            return $this->success('Daftar pejabat berhasil diambil', $officials);
        } catch (\Exception $e) {
            Log::error('Official fetch error: ' . $e->getMessage());
            return $this->error('Gagal mengambil data pejabat', null, 500);
        }
    }

    /**
     * GET /api/officials/{uuid}
     * Detail satu pejabat untuk halaman /informasi-pejabat/:uuid
     */
    public function show(string $uuid): JsonResponse
    {
        try {
            $user = User::query()
                ->where('uuid', $uuid)
                ->where('is_pejabat', 1)
                ->whereHas('roles', fn ($q) => $q->where('name', 'pegawai'))
                ->with('departments')
                ->first();

            if (! $user) {
                return $this->error('Pejabat tidak ditemukan', null, 404);
            }

            $departments = $user->departments->pluck('name')->filter()->values()->all();
            $position = ($departments[0] ?? $user->unit_kerja) ?: 'Pejabat DBMSDA';
            $avatarUrl = $user->avatar ? '/storage/' . ltrim($user->avatar, '/') : null;

            // riwayat berisi HTML admin (pendidikan/karir) — kirim apa adanya, FE sanitasi
            $data = [
                'uuid' => $user->uuid,
                'name' => $user->name,
                'position' => $position,
                'departments' => $departments,
                'unit_kerja' => $user->unit_kerja,
                'avatar' => $user->avatar,
                'avatar_url' => $avatarUrl,
                'urutan_pejabat' => $user->urutan_pejabat,
                'riwayat' => $user->riwayat,
                'nip' => $user->nip,
                'email' => $user->email,
            ];

            return $this->success('Detail pejabat berhasil diambil', $data);
        } catch (\Exception $e) {
            Log::error('Official detail error: ' . $e->getMessage());
            return $this->error('Gagal mengambil detail pejabat', null, 500);
        }
    }
}
