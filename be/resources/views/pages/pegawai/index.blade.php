@extends('layouts.app')
@section('title', 'Data Pegawai')
@section('content')

@section('breadcrumb')
<x-breadcrumb title="Data Pegawai" page="Kepegawaian" active="Semua Pegawai" route="{{ route('pegawai.index') }}" />
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

<section class="section mt-2">
    <div class="card">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <form action="{{ route('pegawai.index') }}" method="GET" class="row g-2 align-items-center">
                    <div class="col-md-auto col-12">
                        <input type="text" name="search" value="{{ request('search') }}"
                            class="form-control form-control-sm" placeholder="Cari nama, email, no. HP...">
                    </div>

                    <div class="col-md-auto col-12">
                        <div class="input-group input-group-sm">
                            <span class="input-group-text">Masuk</span>
                            <input type="date" name="start_date" value="{{ request('start_date') }}"
                                class="form-control">
                        </div>
                    </div>

                    <div class="col-md-auto col-12">
                        <div class="input-group input-group-sm">
                            <span class="input-group-text">Sampai</span>
                            <input type="date" name="end_date" value="{{ request('end_date') }}"
                                class="form-control">
                        </div>
                    </div>

                    <div class="col-md-auto col-12">
                        <div class="input-group input-group-sm">
                            <span class="input-group-text">JK</span>
                            <select name="jenis_kelamin" class="form-select">
                                <option value="">-- Semua --</option>
                                <option value="L" {{ request('jenis_kelamin') == 'L' ? 'selected' : '' }}>Laki-laki
                                </option>
                                <option value="P" {{ request('jenis_kelamin') == 'P' ? 'selected' : '' }}>Perempuan
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="col-md-auto col-12">
                        <div class="input-group input-group-sm">
                            <span class="input-group-text">Jabatan</span>
                            <select name="department" class="form-select">
                                <option value="">-- Semua Jabatan --</option>
                                @foreach ($departments as $department)
                                <option
                                    value="{{ $department->uuid }}"
                                    {{ request('department') == $department->uuid ? 'selected' : '' }}>
                                    {{ $department->name }}
                                </option>
                                @endforeach
                            </select>
                        </div>
                    </div>

                    <div class="col-md-auto col-12">
                        <button class="btn btn-sm btn-success" type="submit">
                            <i class="bi bi-funnel"></i> Filter
                        </button>
                        <a href="{{ route('pegawai.index') }}" class="btn btn-sm btn-secondary">
                            Reset
                        </a>
                    </div>
                </form>

                <div class="d-flex gap-2">
                    @can('pegawai.create')
                    <a href="{{ route('pegawai.create') }}" class="btn btn-primary btn-md">
                        <i class="bi bi-plus-lg"></i> Tambah Pegawai
                    </a>
                    @endcan
                </div>
            </div>
        </div>

        <div class="card-body">
            @if ($users->isNotEmpty())
            <div class="table-responsive text-nowrap mx-2">
                <table class="table table-hover align-middle text-wrap text-break" id="table1">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Foto</th>
                            <th>Nama</th>
                            <th>NIP</th>
                            <th>Jabatan</th>
                            <th>Kontak</th>
                            <th>Status</th>
                            <th class="text-end">Aksi</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        @foreach ($users as $user)
                        <tr>
                            <td>{{ ($users->firstItem() ?? 0) + $loop->index }}</td>
                            <td>
                                @if ($user->avatar)
                                <img src="{{ Str::startsWith($user->avatar, 'http') ? $user->avatar : asset('storage/' . $user->avatar) }}"
                                    alt="Foto {{ $user->name }}" width="60" class="img-thumbnail">
                                @else
                                <span class="text-muted">-</span>
                                @endif
                            </td>
                            <td>
                                <span class="d-block fw-semibold">{{ $user->name }}</span>
                                <small class="text-muted">{{ $user->email }}</small>
                                @if ($user->is_pejabat)
                                <span class="badge bg-warning-subtle text-warning d-block mt-1" style="width: fit-content;">
                                    <i class="bi bi-award"></i> Pejabat
                                </span>
                                @endif
                            </td>
                             <td>{{ $user->nip ?? '-' }}</td>
                            <td>
                                <div class="d-flex flex-wrap gap-1">
                                    @forelse ($user->departments as $department)
                                    <span class="badge bg-primary">
                                        {{ $department->name }}
                                    </span>
                                    @empty
                                    <span class="text-muted">-</span>
                                    @endforelse
                                </div>
                            </td>
                            <td>
                                <span class="d-block">{{ $user->no_hp ?? '-' }}</span>
                                <small class="text-muted">{{ $user->jenis_kelamin == 'L' ? 'Laki-laki' : ($user->jenis_kelamin == 'P' ? 'Perempuan' : '-') }}</small>
                            </td>
                            <td>
                                @if (($user->is_active ?? 'active') === 'active')
                                <span class="badge bg-success-subtle text-success">Aktif</span>
                                @else
                                <span class="badge bg-danger-subtle text-danger">Nonaktif</span>
                                @endif
                            </td>
                            <td class="text-end">
                                <button type="button" data-bs-toggle="modal"
                                    data-bs-target="#modal-view-pegawai-{{ $user->uuid }}"
                                    class="btn btn-icon btn-info text-white" title="Detail">
                                    <i class="bi bi-eye"></i>
                                </button>
                                @include('pages.pegawai.modal-view', ['user' => $user])

                                @can('pegawai.edit')
                                <a href="{{ route('pegawai.edit', $user->uuid) }}" title="Ubah"
                                    class="btn btn-icon btn-success text-white">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                                @endcan

                                @can('pegawai.destroy')
                                <button type="button" onclick="confirmDeletePegawai('{{ $user->uuid }}')" title="Hapus"
                                    class="btn btn-icon btn-danger text-white">
                                    <i class="bi bi-trash"></i>
                                </button>
                                <form id="delete-pegawai-{{ $user->uuid }}"
                                    action="{{ route('pegawai.destroy', $user->uuid) }}" method="POST" class="d-none">
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
            @if($users->hasPages())
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mt-3">
                <small class="text-muted">Menampilkan {{ $users->firstItem() }}-{{ $users->lastItem() }} dari {{ $users->total() }} pegawai</small>
                <div>{{ $users->links('pagination::minimal') }}</div>
            </div>
            @endif
            @else
            <div class="text-center text-muted py-5">
                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                <p class="mb-0">Belum ada data pegawai.</p>
                @can('pegawai.create')
                <a href="{{ route('pegawai.create') }}" class="btn btn-sm btn-primary mt-3">
                    <i class="bi bi-plus-lg"></i> Tambah Pegawai
                </a>
                @endcan
            </div>
            @endif
        </div>
    </div>
</section>

@push('after-script')
<script>
    function confirmDeletePegawai(uuid) {
        Swal.fire({
            title: 'Hapus data pegawai?',
            text: 'Data akan dihapus (soft delete) dan dapat dipulihkan dari database.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Ya, Hapus!',
            cancelButtonText: 'Batal',
            confirmButtonColor: '#f43f5e'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('delete-pegawai-' + uuid).submit();
            }
        });
    }
</script>
@endpush

@endsection


