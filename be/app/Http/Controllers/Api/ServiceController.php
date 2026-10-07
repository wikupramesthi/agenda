<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\ServiceResource;
use App\Models\Service;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ServiceController extends Controller
{

    /**
     * GET /api/services?search=&category=&status=&per_page=
     */
    public function index(Request $request): JsonResponse
    {
        $request->validate([
            'search' => 'nullable|string|max:150',
            'category' => 'nullable|in:external,internal,other',
            'status' => 'nullable|in:active,inactive',
            'per_page' => 'nullable|integer|min:1|max:50',
        ]);

        // Publik hanya lihat layanan aktif; filter status hanya untuk aktif (inactive tidak di-expose)
        $services = Service::query()
            ->where('is_active', 'active')
            ->when($request->filled('search'), fn ($q) => $q->where('name', 'like', '%' . $request->search . '%'))
            ->when($request->filled('category'), fn ($q) => $q->where('category', $request->category))
            ->latest()
            ->paginate($request->input('per_page', 12));

        return $this->paginated(
            $services->isEmpty() ? 'Belum ada layanan' : 'Daftar layanan berhasil diambil',
            $services,
            fn ($items) => ServiceResource::collection($items)
        );
    }

    /**
     * GET /api/services/{uuid}
     */
    public function show(string $uuid): JsonResponse
    {
        $service = Service::where('uuid', $uuid)->where('is_active', 'active')->first();

        if (! $service) {
            return $this->notFound('Layanan tidak ditemukan.');
        }

        return $this->success('Detail layanan berhasil diambil.', new ServiceResource($service));
    }
}
