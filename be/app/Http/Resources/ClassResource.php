<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ClassResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'uuid' => $this->uuid,
            'name' => $this->name,
            'slug' => $this->slug,
            'description' => $this->description,

            'image' => $this->image
                ? asset('storage/' . $this->image)
                : null,

            'price' => $this->price,
            'level' => $this->level,

            'instructor' => [
                'uuid' => $this->instructor?->uuid,
                'name' => $this->instructor?->name,
                'avatar' => $this->instructor?->avatar
                    ? asset(
                        'storage/' .
                        $this->instructor->avatar
                    )
                    : null,
            ],
        ];
    }
}