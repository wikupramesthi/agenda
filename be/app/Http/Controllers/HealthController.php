<?php

namespace App\Http\Controllers;

use App\Services\SystemHealthService;
use Illuminate\Http\JsonResponse;

class HealthController extends Controller
{
    public function __construct(protected SystemHealthService $health) {}

    /**
     * Halaman visual health check.
     */
    public function page()
    {
        return view('pages.health.index');
    }

    /**
     * Status kesehatan sistem untuk monitoring (boleh publik).
     * 200 = sehat, 503 = ada yang gagal.
     */
    public function index(): JsonResponse
    {
        $checks = $this->health->allChecks();
        $sehat = collect($checks)->every(fn ($c) => $c['ok'] === true);

        return response()->json([
            'status' => $sehat ? 'ok' : 'terganggu',
            'waktu' => now()->format('d M Y H:i:s'),
            'pemeriksaan' => $checks,
        ], $sehat ? 200 : 503);
    }
}
