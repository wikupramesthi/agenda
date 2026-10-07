@extends('layouts.app')
@section('title', 'Edit Jadwal')
@section('breadcrumb')
<x-breadcrumb title="Edit Jadwal" page="Jadwal" active="Edit Jadwal" route="{{ route('maintenance.index') }}" />
@endsection
@section('content')
<div class="page-content">
    <div class="card shadow-sm">
        <div class="card-body">
            <form method="POST" action="{{ route('maintenance.update', $item->uuid) }}">
                @csrf @method('PUT')
                <div class="mb-3"><label class="form-label">Judul *</label><input type="text" name="judul" class="form-control" value="{{ old('judul', $item->judul) }}" required></div>
                <div class="row g-3">
                    <div class="col-md-6"><label class="form-label">Tanggal Rencana *</label><input type="date" name="tanggal_rencana" class="form-control" value="{{ old('tanggal_rencana', $item->tanggal_rencana?->format('Y-m-d')) }}" required></div>
                    <div class="col-md-6"><label class="form-label">Tanggal Selesai</label><input type="date" name="tanggal_selesai" class="form-control" value="{{ old('tanggal_selesai', $item->tanggal_selesai?->format('Y-m-d')) }}"></div>
                </div>
                <div class="mb-3 mt-3"><label class="form-label">Status</label><select name="status" class="form-select"><option value="terjadwal" @selected($item->status=='terjadwal')>Terjadwal</option><option value="berjalan" @selected($item->status=='berjalan')>Berjalan</option><option value="selesai" @selected($item->status=='selesai')>Selesai</option><option value="tertunda" @selected($item->status=='tertunda')>Tertunda</option></select></div>
                <div class="mb-3"><label class="form-label">Keterangan</label><textarea name="keterangan" rows="3" class="form-control">{{ old('keterangan', $item->keterangan) }}</textarea></div>
                <button class="btn btn-primary">Update</button>
                <a href="{{ route('maintenance.index') }}" class="btn btn-light">Batal</a>
            </form>
        </div>
    </div>
</div>
@endsection
