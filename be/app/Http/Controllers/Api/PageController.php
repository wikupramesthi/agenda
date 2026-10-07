<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Resources\PageResource;
use App\Models\Page;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;

class PageController extends Controller
{
    public function index(): JsonResponse
    {
        try {
            $pages = Page::where('is_published', true)->orderBy('created_at', 'DESC')->get();

            if ($pages->isEmpty()) {
                return response()->json([
                    'status' => 'success',
                    'message' => 'Belum ada halaman yang tersedia',
                    'data' => []
                ], 200);
            }

            return response()->json([
                'status' => 'success',
                'message' => 'Data halaman berhasil diambil',
                'data' => PageResource::collection($pages)
            ], 200);
        } catch (\Throwable $e) {
            Log::error('Page fetch error: ' . $e->getMessage());

            return response()->json([
                'status' => 'error',
                'message' => 'Gagal mengambil data halaman',
                'data' => []
            ], 500);
        }
    }

    public function show(string $slug): JsonResponse
    {
        try {
            $page = Page::where('slug', $slug)
                ->where('is_published', true)
                ->firstOrFail();

            return response()->json([
                'status' => 'success',
                'message' => 'Detail halaman berhasil diambil',
                'data' => new PageResource($page)
            ], 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {

            return response()->json([
                'status' => 'error',
                'message' => 'Halaman tidak ditemukan',
                'data' => null
            ], 404);
        } catch (\Throwable $e) {

            Log::error('Page show error: ' . $e->getMessage());

            return response()->json([
                'status' => 'error',
                'message' => 'Terjadi kesalahan saat mengambil detail halaman',
                'data' => null
            ], 500);
        }
    }
}
