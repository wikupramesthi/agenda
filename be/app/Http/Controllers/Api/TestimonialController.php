<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\TestimonialResource;
use App\Models\Testimonial;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;

class TestimonialController extends Controller
{
    /**
     * GET /api/testimonials — read-only untuk frontend.
     */
     public function index(): JsonResponse
    {
        try {
            $testimoni = Testimonial::where('is_active', 'active')
                ->orderBy('urutan', 'asc')
                ->get();

            return response()->json([
                'status' => 'success',
                'message' => 'Daftar Testimoni berhasil diambil',
                'data' => TestimonialResource::collection($testimoni)
            ], 200);

        } catch (\Exception $e) {
            // Log error supaya mudah debugging
            Log::error('FAQ fetch error: '.$e->getMessage());

            return response()->json([
                'status' => 'error',
                'message' => 'Gagal mengambil FAQ',
                'data' => []
            ], 500);
        }
    }
}
