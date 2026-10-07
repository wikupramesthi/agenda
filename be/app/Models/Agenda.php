<?php

namespace App\Models;

use App\Traits\HasUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;
use Laravel\Scout\Searchable;
use App\Traits\ImageOptimizable;

/**
 * Agenda = Event yang dipakai. Tabel tetap `events` biar data lama tidak hilang.
 * Model ini rapih: pakai HasUuid, Searchable, ImageOptimizable, casts jelas.
 */
class Agenda extends Model
{
    use HasFactory, HasUuid, Searchable, ImageOptimizable;

    protected $table = 'agendas';

    protected $primaryKey = 'uuid';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'uuid', 'judul', 'slug', 'deskripsi', 'gambar',
        'tanggal', 'waktu_mulai', 'waktu_selesai', 'lokasi', 'kapasitas', 'status',
    ];

    protected $casts = [
        'tanggal' => 'date',
    ];

    // alias agar kode lama yang panggil Event tetap jalan
    public static function bootAgendas(): void {}

    protected function getImageAttributes(): array
    {
        return ['gambar' => 'public'];
    }

    /**
     * Helper URL gambar untuk blade (konsisten dengan Banner::gambar()).
     * Dipakai di modal-edit lama: $item->gambar()
     */
    public function gambar(): string
    {
        if (! $this->gambar) {
            return asset('images/no-image.png');
        }
        if (str_starts_with($this->gambar, 'http')) {
            return $this->gambar;
        }
        return asset('storage/' . ltrim($this->gambar, '/'));
    }

    public function gambarUrl(): string
    {
        return $this->gambar();
    }

    public function getDynamicSEOData(): \RalphJSmit\Laravel\SEO\Support\SEOData
    {
        return new \RalphJSmit\Laravel\SEO\Support\SEOData(
            title: $this->judul,
            description: \Illuminate\Support\Str::limit(strip_tags($this->deskripsi), 150),
            image: $this->gambar,
            robots: $this->status === 'published' ? 'index, follow' : 'noindex, nofollow',
        );
    }

    public function toSearchableArray(): array
    {
        return [
            'id' => $this->uuid,
            'judul' => $this->judul,
            'slug' => $this->slug,
            'deskripsi' => strip_tags($this->deskripsi),
            'lokasi' => $this->lokasi,
            'status' => $this->status,
            'tanggal' => $this->tanggal?->timestamp,
        ];
    }

    public function shouldBeSearchable(): bool
    {
        return $this->status === 'published';
    }
}
