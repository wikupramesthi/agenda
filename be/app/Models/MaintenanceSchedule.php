<?php

namespace App\Models;

use App\Traits\HasUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class MaintenanceSchedule extends Model
{
    use HasFactory, HasUuid, SoftDeletes;

    protected $table = 'maintenance_schedules';
    protected $primaryKey = 'uuid';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'uuid', 'aduan_uuid', 'judul', 'keterangan',
        'tanggal_rencana', 'tanggal_selesai', 'status', 'petugas_uuid', 'prioritas'
    ];

    protected $casts = [
        'tanggal_rencana' => 'date',
        'tanggal_selesai' => 'date',
    ];

    public function aduan()
    {
        return $this->belongsTo(Aduan::class, 'aduan_uuid', 'uuid');
    }

    public function petugas()
    {
        return $this->belongsTo(User::class, 'petugas_uuid', 'uuid');
    }

    public function getIsTerlambatAttribute(): bool
    {
        return $this->status !== 'selesai' && $this->tanggal_rencana && $this->tanggal_rencana->isPast();
    }
}
