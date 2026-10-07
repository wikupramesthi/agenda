<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Concerns\HandlesTransactions;
use App\Http\Requests\Article\StoreArticleRequest;
use App\Http\Requests\Article\UpdateArticleRequest;
use App\Models\Article;
use App\Models\ArticleImage;
use App\Models\Category;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use App\Services\HtmlSanitizer;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\View\View;

class ArticleController extends Controller
{
    
    use HandlesTransactions;
private const IMAGE_DISK = 'public';

    private const IMAGE_DIRECTORY = 'images';

    /**
     * Display a listing of the articles.
     */
    public function index(Request $request): View
    {
        $search = $request->get('search');
        $start_date = $request->get('start_date');
        $end_date = $request->get('end_date');
        $status = $request->get('status');

        $baseQuery = Article::query()
            ->when($start_date, fn ($query) => $query->whereDate('created_at', '>=', $start_date))
            ->when($end_date, fn ($query) => $query->whereDate('created_at', '<=', $end_date))
            ->when($status, fn ($query) => $query->where('status', $status))
            ->when($request->filled('search'), function ($query) use ($request) {
                $search = $request->search;
                $query->where('title', 'like', "%{$search}%")
                    ->orWhere('slug', 'like', "%{$search}%");
            });

        // Statistik dihitung dari query yang SUDAH difilter (tanpa paginasi),
        // sehingga angka pada card selalu sesuai dengan data hasil filter.
        $stats = [
            'total'     => (clone $baseQuery)->count(),
            'published' => (clone $baseQuery)->where('status', 'published')->count(),
            'draft'     => (clone $baseQuery)->where('status', 'draft')->count(),
            'featured'  => (clone $baseQuery)->where('is_featured', true)->count(),
            'popular'   => (clone $baseQuery)->where('is_popular', true)->count(),
        ];

        $articles = $baseQuery
            ->with(['user', 'category', 'images'])
            ->latest('created_at')
            ->paginate(10)->withQueryString();

        return view('pages.articles.index', compact('articles', 'stats', 'start_date', 'end_date', 'status', 'search'));
    }

    /**
     * Show the form for creating a new article.
     */
    public function create(): View
    {
        $categories = Category::orderBy('slug')->get();

        return view('pages.articles.create', compact('categories'));
    }

    /**
     * Store a newly created article.
     */
    public function store(StoreArticleRequest $request): RedirectResponse
    {
        $validated = $request->validated();
        $storedFiles = [];

        DB::beginTransaction();

        try {
            $article = new Article();
            $article->user_uuid = $request->user()->uuid;
            $validated['content'] = HtmlSanitizer::clean($validated['content']);
            $article->fill([
                'category_uuid' => $validated['category_uuid'],
                'title'         => $validated['title'],
                'slug'          => Str::slug($validated['title']),
                'excerpt'       => $validated['excerpt'] ?? null,
                'content'       => $validated['content'],
                'scheduled_at'  => $validated['scheduled_at'] ?? null,
                'tagging'       => $validated['tagging'] ?? null,
                'video'         => $validated['video'] ?? null,
                'status'        => $validated['status'],
                'search_engine' => $validated['search_engine'],
                'is_featured'   => $request->boolean('is_featured'),
                'is_popular'    => $request->boolean('is_popular'),
            ]);

            if ($request->hasFile('featured_image')) {
                $article->featured_image = $request->file('featured_image')->store(self::IMAGE_DIRECTORY, self::IMAGE_DISK);
                $storedFiles[] = $article->featured_image;
            }

            $article->save();

            // storeImages akan catat file, tapi kita track manual agar bisa rollback file jika DB gagal
            $this->storeImages($article, $request, $storedFiles);
            $this->saveSeoData($article, $request);

            DB::commit();
        } catch (\Throwable $e) {
            DB::rollBack();
            foreach ($storedFiles as $f) {
                if ($f && Storage::disk(self::IMAGE_DISK)->exists($f)) {
                    Storage::disk(self::IMAGE_DISK)->delete($f);
                }
            }
            // bersihkan juga images yang sempat ter-create di DB tapi file sudah di-track
            Log::error('Gagal menyimpan berita: ' . $e->getMessage(), ['exception' => $e]);

            return back()->withInput()->with('error', 'Gagal menyimpan berita. Silakan coba lagi.');
        }

        return redirect()->route('articles.index')->with('success', 'Berita berhasil disimpan.');
    }

    /**
     * Display the specified article.
     */
    public function show(string $slug): View
    {
        $article = Article::with('images')->where('slug', $slug)->firstOrFail();

        $sessionKey = 'article_viewed_' . $article->uuid;

        if (! session()->has($sessionKey)) {
            $article->incrementViews();
            session()->put($sessionKey, true);
        }

        return view('articles.show', compact('article'));
    }

    /**
     * Show the form for editing the specified article.
     */
    public function edit(Article $article): View
    {
        $categories = Category::orderBy('slug')->get();
        $article->load('images');

        return view('pages.articles.edit', compact('article', 'categories'));
    }

    /**
     * Update the specified article.
     */
    public function update(UpdateArticleRequest $request, Article $article): RedirectResponse
    {
        $validated = $request->validated();
        $oldFeatured = $article->featured_image;
        $newFeatured = null;
        $storedFiles = [];
        $removedImagePaths = [];

        DB::beginTransaction();

        try {
            $validated['content'] = HtmlSanitizer::clean($validated['content']);
            if ($request->hasFile('featured_image')) {
                $newFeatured = $request->file('featured_image')->store(self::IMAGE_DIRECTORY, self::IMAGE_DISK);
                $storedFiles[] = $newFeatured;
                $article->featured_image = $newFeatured;
            }

            $article->fill([
                'category_uuid' => $validated['category_uuid'],
                'title'         => $validated['title'],
                'slug'          => Str::slug($validated['title']),
                'excerpt'       => $validated['excerpt'] ?? null,
                'content'       => $validated['content'],
                'scheduled_at'  => $validated['scheduled_at'] ?? null,
                'tagging'       => $validated['tagging'] ?? null,
                'video'         => $validated['video'] ?? null,
                'status'        => $validated['status'],
                'search_engine' => $validated['search_engine'],
                'is_featured'   => $request->boolean('is_featured'),
                'is_popular'    => $request->boolean('is_popular'),
            ])->save();

            // kumpulkan path yang akan dihapus dulu, hapus file setelah commit
            $removeUuids = (array) $request->input('remove_images', []);
            if (!empty($removeUuids)) {
                $removedImagePaths = $article->images()->whereIn('uuid', $removeUuids)->pluck('image_path')->all();
                $article->images()->whereIn('uuid', $removeUuids)->delete();
            }
            $this->storeImages($article, $request, $storedFiles);
            $this->saveSeoData($article, $request);

            DB::commit();
            // baru hapus file lama setelah DB sukses (atomic)
            if ($newFeatured && $oldFeatured && $oldFeatured !== $newFeatured) {
                $this->deleteFile($oldFeatured);
            }
            foreach ($removedImagePaths as $p) {
                $this->deleteFile($p);
            }
        } catch (\Throwable $e) {
            DB::rollBack();
            foreach ($storedFiles as $f) {
                if ($f && Storage::disk(self::IMAGE_DISK)->exists($f)) {
                    Storage::disk(self::IMAGE_DISK)->delete($f);
                }
            }
            Log::error('Gagal memperbarui berita: ' . $e->getMessage(), ['exception' => $e]);

            return back()->withInput()->with('error', 'Gagal memperbarui berita. Silakan coba lagi.');
        }

        return redirect()->route('articles.index')->with('success', 'Berita berhasil diperbarui.');
    }

    /**
     * Remove the specified article along with its files.
     */
    public function destroy(Article $article): RedirectResponse
    {
        $featured = $article->featured_image;
        $imagePaths = $article->images()->pluck('image_path')->all();

        DB::beginTransaction();

        try {
            $article->images()->delete();
            $article->delete();

            DB::commit();
            // hapus file setelah DB commit (atomic)
            $this->deleteFile($featured);
            foreach ($imagePaths as $p) {
                $this->deleteFile($p);
            }
        } catch (\Throwable $e) {
            DB::rollBack();
            Log::error('Gagal menghapus berita: ' . $e->getMessage(), ['exception' => $e]);

            return back()->with('error', 'Gagal menghapus berita. Silakan coba lagi.');
        }

        return back()->with('success', 'Berita berhasil dihapus.');
    }

    /**
     * Remove the selected articles along with their files.
     */
    public function bulkDestroy(Request $request): RedirectResponse
    {
        $ids = $request->input('ids', []);

        if (! is_array($ids) || empty($ids)) {
            return back()->with('error', 'Tidak ada berita yang dipilih.');
        }

        $ids = array_slice(array_values(array_unique(array_filter($ids))), 0, 100);

        $articles = Article::with('images')->whereIn('uuid', $ids)->get();

        if ($articles->isEmpty()) {
            return back()->with('error', 'Data yang dipilih tidak ditemukan.');
        }

        $filePaths = [];
        foreach ($articles as $article) {
            if ($article->featured_image) {
                $filePaths[] = $article->featured_image;
            }
            foreach ($article->images as $image) {
                $filePaths[] = $image->image_path;
            }
        }

        DB::beginTransaction();

        try {
            ArticleImage::whereIn('article_uuid', $articles->pluck('uuid')->all())->delete();
            Article::whereIn('uuid', $articles->pluck('uuid')->all())->delete();

            DB::commit();

            // hapus file setelah DB commit (atomic)
            foreach ($filePaths as $path) {
                $this->deleteFile($path);
            }
        } catch (\Throwable $e) {
            DB::rollBack();
            Log::error('Gagal menghapus berita terpilih: ' . $e->getMessage(), ['exception' => $e]);

            return back()->with('error', 'Gagal menghapus berita terpilih. Silakan coba lagi.');
        }

        return back()->with('success', $articles->count() . ' berita berhasil dihapus.');
    }

    /**
     * Store the uploaded slider photos for the given article.
     */
    private function storeImages(Article $article, Request $request, array &$storedFiles = []): void
    {
        if (! $request->hasFile('images')) {
            return;
        }

        $order = (int) $article->images()->max('sort_order');

        foreach ($request->file('images') as $file) {
            if (! $file || ! $file->isValid()) {
                continue;
            }

            $path = $file->store(self::IMAGE_DIRECTORY, self::IMAGE_DISK);
            $storedFiles[] = $path;
            $article->images()->create([
                'image_path' => $path,
                'sort_order' => ++$order,
            ]);
        }
    }

    /**
     * Delete the selected slider photos along with their files.
     *
     * @param  array<int, string>  $uuids
     */
    private function removeImages(Article $article, array $uuids): void
    {
        if (empty($uuids)) {
            return;
        }

        $article->images()
            ->whereIn('uuid', $uuids)
            ->get()
            ->each(function (ArticleImage $image) {
                $this->deleteFile($image->image_path);
                $image->delete();
            });
    }

    /**
     * Persist the SEO metadata for the given article.
     */
    private function saveSeoData(Article $article, Request $request): void
    {
        $article->seo()->updateOrCreate([], [
            'title'         => $article->title,
            'description'   => $article->excerpt,
            'image'         => $article->featured_image,
            'author'        => $request->user()->name,
            'robots'        => $article->search_engine ?? 'index, follow',
            'canonical_url' => route('articles.show', $article->slug),
        ]);
    }

    /**
     * Delete a stored file when it exists.
     */
    private function deleteFile(?string $path): void
    {
        if ($path && Storage::disk(self::IMAGE_DISK)->exists($path)) {
            Storage::disk(self::IMAGE_DISK)->delete($path);
        }
    }
}
