<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Str;

class ArticleImage extends Model
{
    use HasFactory;

    protected $table = 'article_images';

    protected $primaryKey = 'uuid';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'article_uuid',
        'image_path',
        'caption',
        'sort_order',
    ];

    protected static function boot(): void
    {
        parent::boot();

        static::creating(function (self $image) {
            if (empty($image->uuid)) {
                $image->uuid = (string) Str::uuid();
            }
        });
    }

    public function article(): BelongsTo
    {
        return $this->belongsTo(Article::class, 'article_uuid', 'uuid');
    }

    public function url(): string
    {
        return asset('storage/' . $this->image_path);
    }
}
