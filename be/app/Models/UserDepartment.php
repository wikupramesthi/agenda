<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\Pivot;
use Illuminate\Support\Str;

class UserDepartment extends Pivot
{
    protected $table = 'user_department';

    public $incrementing = false;

    protected $keyType = 'string';

    protected static function booted()
    {
        static::creating(function ($pivot) {
            if (empty($pivot->uuid)) {
                $pivot->uuid = (string) Str::uuid();
            }
        });
    }
}
