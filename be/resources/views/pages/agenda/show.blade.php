@extends('layouts.app')
@section('title', $item->judul)
@section('breadcrumb')
<x-breadcrumb title="Detail Agenda" page="Agenda" route="{{ route('agenda.index') }}" active="{{ Str::limit($item->judul, 30) }}" />
@endsection
@section('content')
<section class="section">
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0">{{ $item->judul }}</h5>
            <a href="{{ route('agenda.index') }}" class="btn btn-sm btn-light">Kembali</a>
        </div>
        <div class="card-body">
            @if($item->gambar)
            <img src="{{ asset('storage/' . $item->gambar) }}" alt="{{ $item->judul }}" class="rounded mb-3" style="max-width:400px; width:100%; object-fit:cover;">
            @endif
            <table class="table table-sm">
                <tr><th style="width:160px;">Tanggal</th><td>{{ $item->tanggal?->format('d/m/Y') ?? '-' }}</td></tr>
                <tr><th>Waktu</th><td>@if($item->waktu_mulai){{ $item->waktu_mulai }}@if($item->waktu_selesai) - {{ $item->waktu_selesai }}@endif @else - @endif</td></tr>
                <tr><th>Lokasi</th><td>{{ $item->lokasi ?? '-' }}</td></tr>
                <tr><th>Status</th><td><span class="badge bg-primary">{{ $item->status }}</span></td></tr>
                <tr><th>Slug</th><td>{{ $item->slug }}</td></tr>
            </table>
            <div class="border-top pt-3 mt-3">
                <h6>Deskripsi</h6>
                <div>{!! $item->deskripsi !!}</div>
            </div>
            @can('agenda.update')
            <div class="mt-3">
                <a href="{{ route('agenda.edit', $item->uuid) }}" class="btn btn-primary">Edit Agenda</a>
            </div>
            @endcan
        </div>
    </div>
</section>
@endsection
