<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TestimonialResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->uuid,
            'nama' => $this->nama,
            'jabatan' => $this->jabatan,
            'foto'    => $this->foto
                ? url('storage/' . $this->foto)
                : url('images/default.png'),
            'isi_testimoni' => $this->isi_testimoni,
            'status' => $this->is_active,
            'urutan' => $this->urutan,
        ];
    }
}
