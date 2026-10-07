@extends('layouts.app')
@section('title', 'Tambah Jadwal')
@section('breadcrumb')
<x-breadcrumb title="Tambah Jadwal" page="Jadwal" active="Tambah Jadwal" route="{{ route('maintenance.index') }}" />
@endsection
@section('content')
<div class="page-content">
    <div class="card shadow-sm">
        <div class="card-body">
            <form method="POST" action="{{ route('maintenance.store') }}">
                @csrf
                <div class="mb-3"><label class="form-label">Judul *</label><input type="text" name="judul" class="form-control @error('judul') is-invalid @enderror" value="{{ old('judul') }}" required>@error('judul')<div class="invalid-feedback">{{ $message }}</div>@enderror</div>
                <div class="mb-3"><label class="form-label">Tautkan Aduan (opsional)</label><select name="aduan_uuid" class="form-select"><option value="">- Tanpa aduan -</option>@foreach($aduans as $a)<option value="{{ $a->uuid }}">{{ $a->nomor_aduan }} - {{ $a->judul }} ({{ $a->status }})</option>@endforeach</select></div>
                <div class="row g-3">
                    <div class="col-md-6"><label class="form-label">Tanggal Rencana *</label><input type="date" name="tanggal_rencana" class="form-control" value="{{ old('tanggal_rencana') }}" required></div>
                    <div class="col-md-6"><label class="form-label">Tanggal Selesai</label><input type="date" name="tanggal_selesai" class="form-control" value="{{ old('tanggal_selesai') }}"></div>
                </div>
                <div class="mb-3 mt-3"><label class="form-label">Status</label><select name="status" class="form-select"><option value="terjadwal">Terjadwal</option><option value="berjalan">Berjalan</option><option value="selesai">Selesai</option><option value="tertunda">Tertunda</option></select></div>
                <div class="mb-3"><label class="form-label">Keterangan</label><textarea name="keterangan" rows="3" class="form-control">{{ old('keterangan') }}</textarea></div>
                <button class="btn btn-primary">Simpan</button>
                <a href="{{ route('maintenance.index') }}" class="btn btn-light">Batal</a>
            </form>
        </div>
    </div>
</div>
@endsection
