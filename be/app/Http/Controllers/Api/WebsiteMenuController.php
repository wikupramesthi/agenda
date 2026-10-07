<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\WebsiteMenuResource;
use App\Models\WebsiteMenu;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class WebsiteMenuController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        try {
            $query = WebsiteMenu::where('status', true)->orderBy('position');

            if ($request->filled('location')) {
                $query->where('location', $request->location);
            }

            $menus = $query->with(['activeItems.allChildren' => function ($q) {
                $q->where('status', true)->orderBy('position');
            }])->get();

            // Eager load nested children for activeItems.allChildren -> ensure children of children also filtered
            // allChildren relation already orders by position; filter status via closure above

            return $this->success('Daftar menu berhasil diambil', WebsiteMenuResource::collection($menus));
        } catch (\Exception $e) {
            Log::error('WebsiteMenu fetch error: ' . $e->getMessage());
            return $this->error('Gagal mengambil menu');
        }
    }

    public function show(string $slug): JsonResponse
    {
        try {
            $menu = WebsiteMenu::where('status', true)
                ->where(function ($q) use ($slug) {
                    $q->where('slug', $slug)->orWhere('id', $slug);
                })
                ->with(['activeItems.allChildren' => function ($q) {
                    $q->where('status', true)->orderBy('position');
                }])
                ->first();

            if (! $menu) {
                return $this->error('Menu tidak ditemukan', null, 404);
            }

            return $this->success('Detail menu berhasil diambil', new WebsiteMenuResource($menu));
        } catch (\Exception $e) {
            Log::error('WebsiteMenu detail error: ' . $e->getMessage());
            return $this->error('Gagal mengambil detail menu');
        }
    }
}
