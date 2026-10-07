<?php

namespace App\Models;

use App\Traits\HasUuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;


class Department extends Model
{
    use HasFactory, HasUuid;

    protected $table = 'departments';

    protected $primaryKey = 'uuid';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'uuid',
        'name',
        'slug',
        'description',
    ];


    public function users(): BelongsToMany
    {
        return $this->belongsToMany(
            User::class,
            'user_department',
            'department_uuid',
            'user_uuid',
            'uuid',
            'uuid'
        )->using(UserDepartment::class)->withTimestamps();
    }
}
