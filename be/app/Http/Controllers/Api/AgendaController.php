<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\EventResource;
use App\Models\Agenda;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

/**
 * Agenda = Event yang dipakai. Rapih: pakai ApiResponse trait dari base Controller,
 * validasi ringkas, pagination konsisten.
 */
class AgendaController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'search' => ['nullable', 'string', 'max:255'],
                'status' => ['nullable', 'in:draft,published,cancelled,completed'],
                'page' => ['nullable', 'integer', 'min:1'],
                'per_page' => ['nullable', 'integer', 'min:1', 'max:50'],
            ]);

            $q = Agenda::query()->where('status', 'published')
                ->when($request->filled('search'), fn($qq) => $qq->where('judul', 'like', '%' . $request->input('search') . '%'))
                ->orderBy('tanggal', 'desc');

            $perPage = (int) $request->input('per_page', 10);
            $data = $q->paginate($perPage);

            return $this->paginated('Daftar agenda berhasil diambil', $data, fn($items) => EventResource::collection($items));
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['status' => 'error', 'message' => 'Parameter tidak valid', 'errors' => $e->errors(), 'data' => []], 422);
        } catch (\Throwable $e) {
            Log::error('Agenda index error: ' . $e->getMessage());
            return $this->error('Gagal mengambil agenda');
        }
    }

    public function show(string $slug): JsonResponse
    {
        try {
            $item = Agenda::where('slug', $slug)->where('status', 'published')->firstOrFail();
            return $this->success('Detail agenda berhasil diambil', new EventResource($item));
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return $this->error('Agenda tidak ditemukan', null, 404);
        } catch (\Throwable $e) {
            Log::error('Agenda show error: ' . $e->getMessage());
            return $this->error('Gagal mengambil detail agenda');
        }
    }
}
