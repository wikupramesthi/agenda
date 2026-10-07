<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Agenda;
use App\Models\Article;
use App\Models\Page;
use App\Models\Faq;
use App\Models\Document;
use App\Models\Category;
use App\Models\Aduan;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class SearchController extends Controller
{
    public function search(Request $request): JsonResponse
    {
        $query = trim((string) $request->get('q', ''));
        $types = $request->get('types', ['article', 'page', 'faq', 'agenda', 'document', 'category', 'aduan']);
        $limit = min((int) $request->get('limit', 10), 50);
        $filters = $request->get('filters', []);

        if (mb_strlen($query) < 2) {
            return response()->json([
                'query' => $query,
                'results' => [],
                'total' => 0,
            ]);
        }

        $results = [];
        $total = 0;

        $modelMap = [
            'article' => [
                'model' => Article::class,
                'label' => 'Artikel',
                'route' => 'articles.show',
                'icon' => 'bi-newspaper',
            ],
            'page' => [
                'model' => Page::class,
                'label' => 'Halaman',
                'route' => 'pages.show',
                'icon' => 'bi-file-richtext',
            ],
            'faq' => [
                'model' => Faq::class,
                'label' => 'FAQ',
                'route' => 'faqs.show',
                'icon' => 'bi-question-circle',
            ],
            'agenda' => [
                'model' => Agenda::class,
                'label' => 'Agenda',
                'route' => 'agenda.show',
                'icon' => 'bi-calendar-event',
            ],
            'event' => [
                'model' => Agenda::class,
                'label' => 'Agenda',
                'route' => 'agenda.show',
                'icon' => 'bi-calendar-event',
            ],
            'document' => [
                'model' => Document::class,
                'label' => 'Dokumen',
                'route' => 'documents.show',
                'icon' => 'bi-file-earmark-text',
            ],
            'category' => [
                'model' => Category::class,
                'label' => 'Kategori',
                'route' => 'categories.show',
                'icon' => 'bi-tags',
            ],
            'aduan' => [
                'model' => Aduan::class,
                'label' => 'Pengaduan',
                'route' => 'aduan.track',
                'icon' => 'bi-megaphone',
            ],
        ];

        foreach ($types as $type) {
            if (!isset($modelMap[$type])) {
                continue;
            }

            $config = $modelMap[$type];
            $modelClass = $config['model'];

            try {
                $search = $modelClass::search($query);

                // Apply filters if provided
                if (!empty($filters[$type])) {
                    foreach ($filters[$type] as $field => $value) {
                        $search = $search->where($field, $value);
                    }
                }

                $items = $search->limit($limit)->get();

                $formatted = $items->map(function ($item) use ($config, $type) {
                    $url = $this->generateUrl($type, $item, $config['route']);
                    
                    return [
                        'type' => $type,
                        'id' => $item->getKey(),
                        'title' => $this->getTitle($item),
                        'subtitle' => $this->getSubtitle($item, $type),
                        'url' => $url,
                        'icon' => $config['icon'],
                        'thumbnail' => $this->getThumbnail($item),
                        'metadata' => $this->getMetadata($item, $type),
                    ];
                })->values();

                $results[$type] = [
                    'label' => $config['label'],
                    'icon' => $config['icon'],
                    'count' => $items->count(),
                    'items' => $formatted,
                ];

                $total += $items->count();
            } catch (\Throwable $e) {
                // Silently skip failed searches (e.g., Meilisearch not running)
                $results[$type] = [
                    'label' => $config['label'],
                    'icon' => $config['icon'],
                    'count' => 0,
                    'items' => [],
                    'error' => 'Search unavailable',
                ];
            }
        }

        return response()->json([
            'query' => $query,
            'total' => $total,
            'results' => $results,
            'took' => 0, // Could add timing if needed
        ]);
    }

    public function suggest(Request $request): JsonResponse
    {
        $query = trim((string) $request->get('q', ''));
        $limit = min((int) $request->get('limit', 5), 10);

        if (mb_strlen($query) < 1) {
            return response()->json(['suggestions' => []]);
        }

        $suggestions = [];
        $types = ['article', 'page', 'faq', 'agenda', 'document', 'category'];

        foreach ($types as $type) {
            try {
                $modelClass = match ($type) {
                    'article' => Article::class,
                    'page' => Page::class,
                    'faq' => Faq::class,
                    'agenda' => Agenda::class,
                    'event' => Agenda::class,
                    'document' => Document::class,
                    'category' => Category::class,
                    default => null,
                };

                if (!$modelClass) continue;

                $items = $modelClass::search($query)
                    ->limit($limit)
                    ->get(['id', 'title', 'slug', 'name', 'judul', 'pertanyaan']);

                foreach ($items as $item) {
                    $title = $this->getTitle($item);
                    $suggestions[] = [
                        'text' => $title,
                        'type' => $type,
                        'id' => $item->getKey(),
                        'url' => $this->generateUrl($type, $item, $this->getRoute($type)),
                    ];
                }
            } catch (\Throwable) {
                // Skip
            }
        }

        // Deduplicate by text
        $suggestions = collect($suggestions)
            ->unique('text')
            ->take($limit)
            ->values()
            ->all();

        return response()->json(['suggestions' => $suggestions]);
    }

    private function getTitle($item): string
    {
        return $item->title ?? $item->judul ?? $item->name ?? $item->pertanyaan ?? 'Tanpa Judul';
    }

    private function getSubtitle($item, string $type): string
    {
        return match ($type) {
            'article' => $item->category?->name ?? ucfirst($item->status ?? 'draft'),
            'page' => $item->is_published ? 'Dipublikasikan' : 'Draft',
            'faq' => ucfirst($item->status ?? 'active'),
            'agenda' => ucfirst($item->status ?? '-'),
            'event' => ucfirst($item->status ?? '-'),
            'document' => $item->category?->name ?? ucfirst($item->status ?? '-'),
            'category' => $item->articles_count . ' artikel',
            'aduan' => $item->kategori . ' • ' . ucfirst($item->status),
            default => '',
        };
    }

    private function getThumbnail($item): ?string
    {
        return $item->thumbnail_url 
            ?? ($item->featured_image ? asset('storage/' . $item->featured_image) : null)
            ?? ($item->gambar ? asset('storage/' . $item->gambar) : null)
            ?? ($item->thumbnail ? asset('storage/' . $item->thumbnail) : null)
            ?? null;
    }

    private function getMetadata($item, string $type): array
    {
        return match ($type) {
            'article' => [
                'views' => $item->views ?? 0,
                'is_featured' => $item->is_featured ?? false,
                'published_at' => $item->created_at?->toISOString(),
            ],
            'agenda' => [
                'tanggal' => $item->tanggal?->toDateString(),
                'lokasi' => $item->lokasi,
            ],
            'event' => [
                'tanggal' => $item->tanggal?->toDateString(),
                'lokasi' => $item->lokasi,
            ],
            'document' => [
                'file_size' => $item->file_size ?? null,
                'downloads' => $item->downloads ?? 0,
            ],
            'aduan' => [
                'nomor' => $item->nomor_aduan,
                'prioritas' => $item->prioritas,
                'kecamatan' => $item->kecamatan?->name,
            ],
            default => [],
        };
    }

    private function getRoute(string $type): string
    {
        return match ($type) {
            'article' => 'articles.show',
            'page' => 'pages.show',
            'faq' => 'faqs.show',
            'agenda' => 'agenda.show',
            'event' => 'agenda.show',
            'document' => 'documents.show',
            'category' => 'categories.show',
            'aduan' => 'aduan.track',
            default => '#',
        };
    }

    private function generateUrl(string $type, $item, string $route): string
    {
        $key = $item->slug ?? $item->uuid ?? $item->nomor_aduan ?? $item->getKey();
        
        try {
            return route($route, $key);
        } catch (\Throwable) {
            return '#';
        }
    }
}