<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\AgendaResource;
use App\Http\Resources\CategoryResource;
use App\Models\Agenda;
use App\Models\Category;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class AgendaController extends Controller
{
    /**
     * Display a listing of the agendas.
     *
     * Mendukung `?limit=N` (1-50) agar frontend cukup mengambil yang
     * dibutuhkan (mis. 8 untuk headline beranda), dan `?popular=1`
     * untuk hanya agenda populer. Tanpa param, perilaku lama
     * dipertahankan: seluruh agenda.
     */
    public function index(Request $request): JsonResponse
    {
        try {
            $limit = $request->integer('limit', 0);
            $query = $this->agendasQuery()->where('status', 'published')->published()->latest('created_at');
            if ($request->boolean('popular')) {
                $query->where('is_popular', true);
            }
            if ($limit > 0) {
                $query->limit(min($limit, 50));
            }
            $agendas = $query->get();

            return $this->success('Daftar agenda berhasil diambil', AgendaResource::collection($agendas));
        } catch (\Exception $e) {
            Log::error('Agenda fetch error: ' . $e->getMessage());

            return $this->error('Gagal mengambil agenda');
        }
    }

    /**
     * Display the specified agenda.
     */
    public function show(string $slug): JsonResponse
    {
        try {
            $agenda = $this->agendasQuery()->where('slug', $slug)->where('status', 'published')->published()->first();

            if (! $agenda) {
                return $this->error('Agenda tidak ditemukan', null, 404);
            }

            $agenda->incrementViews();

            return $this->success('Detail agenda berhasil diambil', new AgendaResource($agenda));
        } catch (\Exception $e) {
            Log::error('Agenda detail error: ' . $e->getMessage());

            return $this->error('Gagal mengambil detail agenda', null);
        }
    }

    /**
     * Display a listing of the categories.
     */
    public function category(): JsonResponse
    {
        try {
            $categories = Category::orderBy('name')->get();

            return $this->success('Daftar kategori berhasil diambil', CategoryResource::collection($categories));
        } catch (\Exception $e) {
            Log::error('Category fetch error: ' . $e->getMessage());

            return $this->error('Gagal mengambil kategori');
        }
    }

    /**
     * Display a listing of the agendas for the given category slug.
     *
     * Mendukung `?limit=N` (1-50) seperti index().
     */
    public function byCategory(Request $request, string $slug): JsonResponse
    {
        try {
            $category = Category::where('slug', $slug)->first();

            if (! $category) {
                return $this->error('Kategori dengan slug "' . $slug . '" tidak ditemukan', [], 404);
            }

            $limit = $request->integer('limit', 0);
            $query = $this->agendasQuery()
                ->where('status', 'published')
                ->published()
                ->whereHas('category', fn (Builder $query) => $query->where('slug', $slug))
                ->latest('created_at');
            if ($limit > 0) {
                $query->limit(min($limit, 50));
            }
            $agendas = $query->get();

            if ($agendas->isEmpty()) {
                return $this->success('Belum ada agenda di kategori "' . $slug . '"', []);
            }

            return $this->success(
                'Daftar agenda kategori "' . $slug . '" berhasil diambil',
                AgendaResource::collection($agendas)
            );
        } catch (\Exception $e) {
            Log::error('Agenda by category fetch error: ' . $e->getMessage());

            return $this->error('Gagal mengambil agenda kategori ' . $slug);
        }
    }

    private function agendasQuery(): Builder
    {
        return Agenda::query()->with(['user', 'category', 'images']);
    }
}
