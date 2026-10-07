<?php

namespace App\Http\Controllers;

use App\Models\Aduan;
use Illuminate\Http\Request;

class WallboardController extends Controller
{
    /**
     * Layar TV pusat pantau pengaduan (read-only, refresh otomatis).
     * Akses: sudah login, atau ?token= sesuai WALLBOARD_TOKEN di .env.
     */
    public function index(Request $request)
    {
        $token = env('WALLBOARD_TOKEN');

        $boleh = $request->user()
            || ($token && hash_equals((string) $token, (string) $request->query('token')));

        if (!$boleh) {
            abort(403, 'Akses wallboard membutuhkan login atau token yang valid.');
        }

        $total = Aduan::belumArsip()->count();
        $selesai = Aduan::belumArsip()->where('status', 'selesai')->count();
        $menunggu = Aduan::belumArsip()->where('status', 'menunggu')->count();
        $diproses = Aduan::belumArsip()->whereIn('status', ['diverifikasi', 'diproses'])->count();
        $persen = $total > 0 ? round($selesai / $total * 100, 1) : 0;

        $perKategori = [];
        foreach (Aduan::KATEGORI as $kat) {
            $perKategori[] = [
                'nama' => $kat,
                'total' => Aduan::belumArsip()->where('kategori', $kat)->count(),
            ];
        }
        $maks = max([1, ...array_column($perKategori, 'total')]);

        $terbaru = Aduan::belumArsip()
            ->orderByDesc('tanggal_pengaduan')
            ->limit(8)
            ->get(['uuid', 'nomor_aduan', 'judul', 'kategori', 'status', 'tanggal_pengaduan']);

        return view('pages.wallboard.index', compact(
            'total',
            'selesai',
            'menunggu',
            'diproses',
            'persen',
            'perKategori',
            'maks',
            'terbaru'
        ));
    }
}
