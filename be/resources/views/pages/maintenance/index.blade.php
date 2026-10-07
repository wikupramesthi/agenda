@extends('layouts.app')
@section('title', 'Jadwal Pemeliharaan')
@section('breadcrumb')
<x-breadcrumb title="Jadwal Pemeliharaan" page="Jadwal" active="Daftar" route="{{ route('maintenance.index') }}" />
@endsection
@section('content')
<div class="page-content">
    @if(session('success'))<div class="alert alert-success">{{ session('success') }}</div>@endif
    @if(session('error'))<div class="alert alert-danger">{{ session('error') }}</div>@endif

    <div class="row g-3 mb-3">
        <div class="col-4"><div class="card"><div class="card-body text-center"><div class="fw-bold fs-4">{{ $stats['terjadwal'] }}</div><small>Terjadwal</small></div></div></div>
        <div class="col-4"><div class="card"><div class="card-body text-center"><div class="fw-bold fs-4 text-warning">{{ $stats['berjalan'] }}</div><small>Berjalan</small></div></div></div>
        <div class="col-4"><div class="card"><div class="card-body text-center"><div class="fw-bold fs-4 text-danger">{{ $stats['terlambat'] }}</div><small>Terlambat</small></div></div></div>
    </div>

    <div class="card shadow-sm mb-3">
        <div class="card-body d-flex flex-wrap gap-2 justify-content-between align-items-center">
            <form method="GET" class="d-flex gap-2">
                <input type="text" name="search" value="{{ request('search') }}" placeholder="Cari judul..." class="form-control form-control-sm">
                <select name="status" class="form-select form-select-sm">
                    <option value="">Semua status</option>
                    @foreach(['terjadwal','berjalan','selesai','tertunda'] as $s)
                        <option value="{{ $s }}" @selected(request('status')==$s)>{{ ucfirst($s) }}</option>
                    @endforeach
                </select>
                <button class="btn btn-sm btn-primary">Filter</button>
            </form>
            <a href="{{ route('maintenance.create') }}" class="btn btn-sm btn-primary"><i class="bi bi-plus"></i> Tambah Jadwal</a>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead><tr><th>Judul</th><th>Aduan</th><th>Rencana</th><th>Status</th><th>Petugas</th><th></th></tr></thead>
                    <tbody>
                    @forelse($items as $it)
                        <tr class="{{ $it->is_terlambat ? 'table-warning' : '' }}">
                            <td>{{ $it->judul }}@if($it->is_terlambat) <span class="badge bg-danger">Terlambat</span>@endif</td>
                            <td><small>{{ $it->aduan->nomor_aduan ?? '-' }}</small></td>
                            <td>{{ $it->tanggal_rencana?->format('d/m/Y') }} @if($it->tanggal_selesai) → {{ $it->tanggal_selesai->format('d/m/Y') }}@endif</td>
                            <td><span class="badge bg-{{ $it->status=='selesai'?'success':($it->status=='berjalan'?'warning':'secondary') }}">{{ $it->status }}</span></td>
                            <td><small>{{ $it->petugas->name ?? '-' }}</small></td>
                            <td class="text-end">
                                <a href="{{ route('maintenance.edit', $it->uuid) }}" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                <form action="{{ route('maintenance.destroy', $it->uuid) }}" method="POST" class="d-inline" onsubmit="return confirm('Hapus?')">
                                    @csrf @method('DELETE')
                                    <button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
                                </form>
                            </td>
                        </tr>
                    @empty
                        <tr><td colspan="6" class="text-center py-4 text-muted">Belum ada jadwal</td></tr>
                    @endforelse
                    </tbody>
                </table>
            </div>
            <div class="p-3">{{ $items->links('pagination::minimal') }}</div>
        </div>
    </div>
</div>
@endsection
