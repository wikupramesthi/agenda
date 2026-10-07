<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class EventResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'uuid' => $this->uuid,
            'judul' => $this->judul,
            'slug' => $this->slug,
            'deskripsi' => $this->deskripsi,
            'gambar' => $this->gambar ? asset('storage/' . $this->gambar) : null,
            'tanggal' => $this->tanggal
                ? $this->tanggal->format('d-m-Y')
                : null,
            'waktu_mulai' => $this->waktu_mulai,
            'waktu_selesai' => $this->waktu_selesai,
            'lokasi' => $this->lokasi,
            'kapasitas' => $this->kapasitas,
            'status' => $this->status,
        ];
    }
}
