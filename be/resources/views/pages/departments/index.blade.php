@extends('layouts.app')
@section('title', 'Profil Pejabat')
@section('content')

@section('breadcrumb')
<x-breadcrumb title="Profil Pejabat" page="Profil Pejabat" active="Kategori Jabatan" route="{{ route('departments.index') }}" />
@endsection

@if (session('success'))
<div class="alert alert-success alert-dismissible mb-3 mt-3 fade show" role="alert">
    <span class="text-white">{{ session('success') }}</span>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
@endif

@if (session('error'))
<div class="alert alert-danger alert-dismissible mb-3 mt-3 fade show" role="alert">
    <span class="text-white">{{ session('error') }}</span>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
@endif

<!-- Content -->
<section class="section">

<div class="alert alert-danger alert-dismissible mb-3 mt-3 fade show position-relative" role="alert">
    <div class="d-flex">
        <i class="bi-briefcase-fill text-white fs-1 me-3 flex-shrink-0 align-self-start"></i>
        <div class="text-white mt-0">
            Kelola kategori jabatan yang tersedia dalam sistem.<br>
            Tambahkan, perbarui, atau nonaktifkan kategori jabatan untuk mendukung pengelolaan data pegawai dan organisasi.
        </div>
    </div>
</div>

    <div class="card">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                <h4 class="fw-normal mb-0 text-body">Kategori Jabatan</h4>
                <form method="GET" action="{{ route('departments.index') }}" class="d-flex gap-1">
                    <input type="text" name="search" value="{{ request('search') }}" class="form-control form-control-sm" placeholder="Cari jabatan..." style="min-width:200px;">
                    <button class="btn btn-sm btn-primary" type="submit"><i class="bi bi-search"></i></button>
                    @if(request('search'))
                    <a href="{{ route('departments.index') }}" class="btn btn-sm btn-light"><i class="bi bi-x-lg"></i></a>
                    @endif
                </form>
                @can('departments.store')
                <button type="button" class="btn btn-primary btn-md" data-bs-toggle="modal"
                    data-bs-target="#modal-form-add-departments">
                    <i class="bi bi-plus-lg"></i>
                    Tambah Jabatan
                </button>
                @endcan
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive text-nowrap mx-2">
                <table class="table table table-bordered" id="table1">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Kategori Jabatan</th>
                            <th>Deskripsi</th>
                            <th>Total Pejabat</th>
                            <th>Edit</th>
                            <th>Hapus</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($departments as $item)
                        <tr>
                            <td>{{ ($departments->firstItem() ?? 0) + $loop->index }}</td>
                            <td>{{ $item->name }}</td>
                            <td>{{ $item->description }}</td>
                            <td>{{ $item->departments_count }}</td>

                            <td>
                                @can('departments.update')
                                <a data-bs-toggle="modal"
                                    data-bs-target="#modal-form-edit-departments-{{ $item->uuid }}"
                                    class="btn btn-icon btn-success text-white">
                                    <i class="bi bi-pencil-square"></i> Edit
                                </a>
                                @include('pages.departments.modal-edit')
                                @endcan
                            </td>

                            <td>
                                @can('departments.destroy')
                                <a onclick="showSweetAlert('{{ $item->uuid }}')" title="Delete"
                                    class="btn btn-icon btn-danger text-white">
                                    <i class="bi bi-x-square"></i> Hapus
                                </a>
                                <form id="deleteForm_{{ $item->uuid }}"
                                    action="{{ route('departments.destroy', $item->uuid) }}" method="POST">
                                    @method('DELETE')
                                    @csrf
                                </form>
                                @endcan
                            </td>

                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
@if ($departments->hasPages())
<div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mt-3">
    <small class="text-muted">Menampilkan {{ $departments->firstItem() }}-{{ $departments->lastItem() }} dari {{ $departments->total() }} jabatan</small>
    <div>{{ $departments->links('pagination::minimal') }}</div>
</div>
@endif
<!-- / Content -->

<!--/ Basic Bootstrap Table -->
@include('pages.departments.modal-create')

<script>
    function showSweetAlert(getId) {
        Swal.fire({
            title: 'Konfirmasi Penghapusan',
            text: 'Data ini akan dihapus secara permanen dan tidak bisa dikembalikan. Apakah Anda yakin ingin menghapusnya?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Ya, Hapus!'
        }).then((result) => {
            if (result.isConfirmed) {
                // If the user clicks "Yes, delete it!", submit the corresponding form
                document.getElementById('deleteForm_' + getId).submit();
            }
        });
    }
</script>
@endsection