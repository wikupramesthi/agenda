<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class WebsiteMenuItemResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        $link = null;
        try {
            $link = $this->link;
        } catch (\Throwable $e) {
            $link = $this->url;
        }

        $children = $this->whenLoaded('allChildren') ?? $this->whenLoaded('children');
        // ensure children are filtered by status already via eager load

        return [
            'id' => $this->id,
            'name' => $this->name,
            'url' => $this->url,
            'route' => $this->route,
            'route_params' => $this->route_params,
            'icon' => $this->icon,
            'target_blank' => (bool) $this->target_blank,
            'position' => $this->position,
            'link' => $link,
            'children' => WebsiteMenuItemResource::collection($children ?? collect()),
        ];
    }
}
