<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DocumentResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'uuid'         => $this->uuid,
            'title'        => $this->title,
            'slug'         => $this->slug,
            'excerpt'      => $this->excerpt,
            'published_at' => $this->published_at?->format('Y-m-d'),
            // Path relatif same-origin agar lolos CSP frontend (`img-src 'self'`)
            // dan bisa dilewati proxy nginx (/storage/*).
            'file'         => $this->file ? '/storage/' . $this->file : null,
            'thumbnail'    => $this->thumbnail ? '/storage/' . $this->thumbnail : null,
            'category'     => $this->category?->name,
            'category_slug' => $this->category?->slug,
            'created_at'   => $this->created_at?->format('Y-m-d H:i:s'),
        ];
    }
}
