<?php

namespace App\Http\Controllers;

use App\Models\Article;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

/**
 * Snapshot HTML server-side untuk crawler share (WhatsApp, Facebook,
 * X/Twitter, Telegram, LinkedIn, Googlebot).
 *
 * Latar: frontend adalah SPA statis — meta OG yang dipasang via JS
 * (NewsDetailPage) tidak terbaca crawler karena mereka tidak mengeksekusi
 * JavaScript. nginx mendeteksi User-Agent bot pada path /berita/{slug}
 * dan mem-proxy request itu ke endpoint ini, sehingga HTML mentah sudah
 * memuat og:title / og:description / og:image yang sesuai berita.
 *
 * Catatan: sengaja TIDAK memanggil incrementViews() agar hitungan
 * dibaca tidak terdongkrak oleh bot.
 */
class SeoSnapshotController extends Controller
{
    /**
     * Nama situs untuk og:site_name. APP_NAME bawaan ("Laravel") tidak
     * cocok untuk preview share, jadi diganti identitas portal bila
     * admin belum mengonfigurasi APP_NAME.
     */
    private function siteName(): string
    {
        $name = (string) config('app.name', '');

        return $name !== '' && $name !== 'Laravel' ? $name : 'Kementerian Pemuda dan Olahraga';
    }
    public function show(Request $request, string $slug): Response
    {
        $base = $request->getSchemeAndHttpHost();
        $canonical = $base . '/berita/' . rawurlencode($slug);

        $article = Article::query()
            ->with(['user', 'category', 'images'])
            ->where('slug', $slug)
            ->first();

        if (! $article) {
            return response()->view('seo.article', [
                'title' => 'Berita tidak ditemukan',
                'heading' => 'Berita tidak ditemukan',
                'description' => 'Tautan yang Anda buka tidak mengarah ke artikel mana pun.',
                'canonical' => $canonical,
                'image' => $base . '/assets/logo.png',
                'publishedAt' => null,
                'dateLabel' => '',
                'author' => null,
                'section' => null,
                'paragraphs' => [],
                'jsonLd' => json_encode([
                    '@context' => 'https://schema.org',
                    '@type' => 'WebPage',
                    'name' => 'Berita tidak ditemukan',
                    'url' => $canonical,
                ], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE),
                'robots' => 'noindex, follow',
                'siteName' => $this->siteName(),
            ], 404)->header('Content-Type', 'text/html; charset=utf-8');
        }

        $plain = trim(preg_replace(
            '/\s+/u',
            ' ',
            html_entity_decode(strip_tags(str_replace(['<br>', '<br/>', '<br />', '</p>', '</li>'], "\n", (string) $article->content)), ENT_QUOTES, 'UTF-8')
        ) ?: '');

        $description = mb_substr(
            trim((string) ($article->excerpt ?: $plain ?: $article->title)),
            0,
            200
        );

        $image = $this->absoluteImage($base, $article->featured_image)
            ?? $this->firstGalleryImage($base, $article)
            ?? $base . '/assets/logo.png';

        $publishedAt = $article->created_at?->toIso8601String();
        $dateLabel = $article->created_at?->translatedFormat('l, d F Y') ?? '';

        $paragraphs = array_values(array_filter(array_map(
            fn (string $line): string => trim(preg_replace('/\s+/u', ' ', $line)),
            preg_split('/\R+/', str_replace(
                ['<br>', '<br/>', '<br />', '</p>', '</li>', '</h1>', '</h2>', '</h3>', '</h4>', '</h5>', '</h6>'],
                "\n",
                html_entity_decode(strip_tags((string) $article->content, '<br><p><li><h1><h2><h3><h4><h5><h6>'), ENT_QUOTES, 'UTF-8')
            )) ?: []
        )));
        $paragraphs = array_slice($paragraphs, 0, 6);

        $siteName = $this->siteName();

        $jsonLd = json_encode([
            '@context' => 'https://schema.org',
            '@type' => 'NewsArticle',
            'headline' => $article->title,
            'description' => $description,
            'image' => [$image],
            'datePublished' => $publishedAt,
            'author' => ['@type' => 'Organization', 'name' => $article->user?->name ?? 'Admin'],
            'publisher' => [
                '@type' => 'Organization',
                'name' => $siteName,
                'logo' => ['@type' => 'ImageObject', 'url' => $base . '/assets/logo.png'],
            ],
            'mainEntityOfPage' => $canonical,
        ], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);

        return response()->view('seo.article', [
            'title' => $article->title,
            'heading' => $article->title,
            'description' => $description,
            'canonical' => $canonical,
            'image' => $image,
            'publishedAt' => $publishedAt,
            'dateLabel' => $dateLabel,
            'author' => $article->user?->name,
            'section' => $article->category?->name,
            'paragraphs' => $paragraphs,
            'jsonLd' => $jsonLd,
            'robots' => 'index, follow',
            'siteName' => $siteName,
        ], 200)->header('Content-Type', 'text/html; charset=utf-8')
            ->header('Cache-Control', 'public, max-age=300');
    }

    /**
     * Ubah path gambar relatif (/storage/..., images/...) menjadi URL absolut.
     * og:image/twitter:image WAJIB absolut — URL relatif diabaikan crawler
     * sehingga gambar tidak nongol saat di-share.
     */
    private function absoluteImage(string $base, ?string $path): ?string
    {
        $path = trim((string) $path);
        if ($path === '') {
            return null;
        }
        if (preg_match('#^https?://#i', $path)) {
            return $path;
        }
        $path = '/' . ltrim($path, '/');
        // Kolom DB menyimpan "images/xxx.jpg" (relatif storage), bukan URL publik.
        if (! str_starts_with($path, '/storage/')) {
            $path = '/storage/' . ltrim($path, '/');
        }

        return $base . $path;
    }

    private function firstGalleryImage(string $base, Article $article): ?string
    {
        $first = $article->images->first();
        if (! $first || empty($first->image_path)) {
            return null;
        }
        // Kolom image_path menyimpan path relatif storage ("images/xxx.jpg"),
        // sama seperti featured_image — pakai helper yang sama agar prefix
        // /storage/ konsisten dan og:image tidak 404.
        return $this->absoluteImage($base, (string) $first->image_path);
    }
}
