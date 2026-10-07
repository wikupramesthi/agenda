<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\FaqResource;
use App\Models\Faq;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;

class FaqController extends Controller
{
    /**
     * GET /api/faqs — read-only untuk frontend.
     */
     public function index(): JsonResponse
    {
        try {
            $faqs = Faq::where('status', 'active')
                ->orderBy('urutan', 'asc')
                ->get();

            return $this->success('Daftar FAQ berhasil diambil', FaqResource::collection($faqs));
        } catch (\Exception $e) {
            Log::error('FAQ fetch error: '.$e->getMessage());
            return $this->error('Gagal mengambil FAQ');
        }
    }
}
