@extends('layouts.app')
@section('title', 'Template Respons')
@section('content')

@section('breadcrumb')
<x-breadcrumb title="Pengaduan" page="Aduan" active="Template Respons" route="{{ route('templates.index') }}" />
@endsection

<section class="section">
    @if (session('success'))
    <div class="alert alert-success alert-dismissible mb-3 mt-3 fade show" role="alert">
        <span class="alert-text text-white"> {{ session('success') }}</span>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    @endif

    @if (session('error'))
    <div class="alert alert-danger alert-dismissible mb-3 mt-3 fade show" role="alert">
        <span class="alert-text text-white"> {{ session('error') }}</span>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    @endif

    <div class="card">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center">
                <h4 class="fw-normal mb-0 text-body">Template Respons</h4>
                @can('templates.store')
                <button type="button" class="btn btn-primary btn-md" data-bs-toggle="modal"
                    data-bs-target="#modal-form-add-template">
                    <i class="bi bi-plus-lg"></i> Tambah Template
                </button>
                @endcan
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive text-nowrap mx-2">
                <table class="table table-bordered" id="table-template">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Judul</th>
                            <th>Isi</th>
                            <th>Status</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($items as $item)
                        <tr>
                            <td>{{ $loop->iteration }}</td>
                            <td>{{ $item->judul }}</td>
                            <td>
                                <div class="text-truncate d-inline-block" style="max-width: 300px;">
                                    {{ Str::limit(strip_tags($item->isi), 100) }}
                                </div>
                            </td>
                            <td>
                                <span class="badge {{ $item->is_active ? 'bg-success' : 'bg-secondary' }}">
                                    {{ $item->is_active ? 'Aktif' : 'Tidak Aktif' }}
                                </span>
                            </td>
                            <td>
                                @can('templates.update')
                                <a data-bs-toggle="modal" data-bs-target="#modal-form-edit-template-{{ $item->uuid }}"
                                    class="btn btn-icon btn-success text-white" title="Edit">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                                @include('pages.template-tindak-lanjut.modal-edit')
                                @endcan

                                @can('templates.destroy')
                                <a onclick="showSweetAlert('{{ $item->uuid }}')" title="Hapus"
                                    class="btn btn-icon btn-danger text-white">
                                    <i class="bi bi-trash"></i>
                                </a>
                                <form id="deleteForm_{{ $item->uuid }}"
                                    action="{{ route('templates.destroy', $item->uuid) }}" method="POST">
                                    @method('DELETE')
                                    @csrf
                                </form>
                                @endcan
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="5" class="text-center py-4">
                                <p class="text-muted mb-0">Belum ada template respons.</p>
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

@include('pages.template-tindak-lanjut.modal-create')

<script>
    function showSweetAlert(getId) {
        Swal.fire({
            title: 'Konfirmasi Penghapusan',
            text: 'Template ini akan dihapus secara permanen. Apakah Anda yakin?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Ya, Hapus!'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('deleteForm_' + getId).submit();
            }
        });
    }
</script>
@endsection