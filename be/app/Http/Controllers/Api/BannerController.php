<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\BannerResource;
use App\Models\Banner;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class BannerController extends Controller
{
    /**
     * GET /api/banners — read-only untuk frontend.
     * Query: ?kategori=slider|banner|pengumuman|... &limit=1..5
     * Untuk posisi banner/slider otomatis limit 5 (rapih slider FE) kecuali diminta lain.
     */
    public function index(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'kategori' => ['nullable', 'string', 'max:30'],
                'limit' => ['nullable', 'integer', 'min:1', 'max:10'],
            ]);

            // Hanya ambil banner foto yang aktif
            $query = Banner::where('tipe', 'foto')->where('status', 'active');

            $allowedKategori = ['slider', 'banner', 'pengumuman', 'infografis', 'galeri', 'popup', 'mitra', 'lainnya'];

            $kategori = $request->input('kategori');
            // alias: "banner" dianggap sama dengan "slider" (istilah FE)
            $effectiveKategori = $kategori === 'banner' ? 'slider' : $kategori;

            if ($kategori && in_array($kategori, $allowedKategori, true)) {
                $query->where('posisi', $effectiveKategori);
            }

            $query->orderBy('created_at', 'asc');

            $limit = $request->integer('limit', 0);
            // default rapih: slider/banner limit 5, lainnya tidak limit (atau pakai param)
            if ($limit === 0 && in_array($kategori, ['slider', 'banner'], true)) {
                $limit = 5;
            }
            if ($limit > 0) {
                $query->limit(min($limit, 5));
            }

            $banners = $query->get();

            return response()->json([
                'status' => 'success',
                'message' => 'Daftar banner berhasil diambil',
                'data' => BannerResource::collection($banners)
            ], 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Parameter tidak valid',
                'errors' => $e->errors(),
                'data' => []
            ], 422);
        } catch (\Exception $e) {
            Log::error('Banner fetch error: ' . $e->getMessage());
            return response()->json([
                'status' => 'error',
                'message' => 'Gagal mengambil data banner',
                'data' => []
            ], 500);
        }
    }
}
