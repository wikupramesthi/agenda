<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Account extends Authenticatable
{
    use HasFactory, Notifiable;

    protected $fillable = [
        'avatar',
        'name',
        'email',
        'no_hp',
        'tempat_lahir',
        'tanggal_lahir',
        'nuptk',
        'nik',
        'jenis_kelamin',
        'agama',
        'alamat',
        'kecamatan_id',
        'kelurahan_id',
        'file_pendukung',
        'password',
    ];

    // Jika ada relasi dengan kecamatan dan kelurahan
    public function kecamatan()
    {
        return $this->belongsTo(Kecamatan::class);
    }

    public function kelurahan()
    {
        return $this->belongsTo(Kelurahan::class);
    }

    protected $hidden = [
        'password',
        'remember_token',
    ];
}
