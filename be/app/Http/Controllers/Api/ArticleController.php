<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\ArticleResource;
use App\Http\Resources\CategoryResource;
use App\Models\Article;
use App\Models\Category;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class ArticleController extends Controller
{
    /**
     * Display a listing of the articles.
     *
     * Mendukung `?limit=N` (1-50) agar frontend cukup mengambil yang
     * dibutuhkan (mis. 8 untuk headline beranda), dan `?popular=1`
     * untuk hanya berita populer. Tanpa param, perilaku lama
     * dipertahankan: seluruh artikel.
     */
    public function index(Request $request): JsonResponse
    {
        try {
            $limit = $request->integer('limit', 0);
            $query = $this->articlesQuery()->where('status', 'published')->published()->latest('created_at');
            if ($request->boolean('popular')) {
                $query->where('is_popular', true);
            }
            if ($limit > 0) {
                $query->limit(min($limit, 50));
            }
            $articles = $query->get();

            return $this->success('Daftar artikel berhasil diambil', ArticleResource::collection($articles));
        } catch (\Exception $e) {
            Log::error('Article fetch error: ' . $e->getMessage());

            return $this->error('Gagal mengambil artikel');
        }
    }

    /**
     * Display the specified article.
     */
    public function show(string $slug): JsonResponse
    {
        try {
            $article = $this->articlesQuery()->where('slug', $slug)->where('status', 'published')->published()->first();

            if (! $article) {
                return $this->error('Artikel tidak ditemukan', null, 404);
            }

            $article->incrementViews();

            return $this->success('Detail artikel berhasil diambil', new ArticleResource($article));
        } catch (\Exception $e) {
            Log::error('Article detail error: ' . $e->getMessage());

            return $this->error('Gagal mengambil detail artikel', null);
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
     * Display a listing of the articles for the given category slug.
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
            $query = $this->articlesQuery()
                ->where('status', 'published')
                ->published()
                ->whereHas('category', fn (Builder $query) => $query->where('slug', $slug))
                ->latest('created_at');
            if ($limit > 0) {
                $query->limit(min($limit, 50));
            }
            $articles = $query->get();

            if ($articles->isEmpty()) {
                return $this->success('Belum ada artikel di kategori "' . $slug . '"', []);
            }

            return $this->success(
                'Daftar artikel kategori "' . $slug . '" berhasil diambil',
                ArticleResource::collection($articles)
            );
        } catch (\Exception $e) {
            Log::error('Article by category fetch error: ' . $e->getMessage());

            return $this->error('Gagal mengambil artikel kategori ' . $slug);
        }
    }

    private function articlesQuery(): Builder
    {
        return Article::query()->with(['user', 'category', 'images']);
    }
}
