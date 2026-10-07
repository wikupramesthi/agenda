@extends('layouts.app')
@section('title', 'Agenda')
@section('content')

@section('breadcrumb')
<x-breadcrumb title="Agenda" page="Agenda" active="Semua Agenda" route="{{ route('agenda.index') }}" />
@endsection

<style>
    .agenda-check { width: 17px; height: 17px; cursor: pointer; }
    #checkAllAgenda { width: 17px; height: 17px; cursor: pointer; }
    tr.row-selected > td { background-color: rgba(13, 110, 253, .07) !important; }
    #bulkBarAgenda { border: 1px solid rgba(244, 63, 94, .25); }
</style>

<section class="section">
    @if (session('success'))
    <div class="alert alert-success alert-dismissible mb-3 fade show" role="alert">
        <span class="alert-text text-white"> {{ session('success') }}</span>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    @endif
    @if (session('error'))
    <div class="alert alert-danger alert-dismissible mb-3 fade show" role="alert">
        <span class="alert-text text-white"> {{ session('error') }}</span>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    @endif

    {{-- Kartu statistik: angka mengikuti data hasil filter --}}
    <div class="row mb-3 g-3 ml-stats">
        <div class="col-6 col-md-4 col-xl"><div class="card shadow-sm h-100"><div class="card-body py-2 px-3"><div class="ml-stat"><div class="ml-stat-icon ic-primary"><i class="bx bx-calendar-event"></i></div><div><div class="ml-stat-value">{{ number_format($stats['total']) }}</div><div class="ml-stat-label">Total Agenda</div></div></div></div></div></div>
        <div class="col-6 col-md-4 col-xl"><div class="card shadow-sm h-100"><div class="card-body py-2 px-3"><div class="ml-stat"><div class="ml-stat-icon ic-success"><i class="bx bx-check-circle"></i></div><div><div class="ml-stat-value">{{ number_format($stats['published']) }}</div><div class="ml-stat-label">Published</div></div></div></div></div></div>
        <div class="col-6 col-md-4 col-xl"><div class="card shadow-sm h-100"><div class="card-body py-2 px-3"><div class="ml-stat"><div class="ml-stat-icon ic-warning"><i class="bx bx-edit"></i></div><div><div class="ml-stat-value">{{ number_format($stats['draft']) }}</div><div class="ml-stat-label">Draft</div></div></div></div></div></div>
        <div class="col-6 col-md-4 col-xl"><div class="card shadow-sm h-100"><div class="card-body py-2 px-3"><div class="ml-stat"><div class="ml-stat-icon ic-violet"><i class="bx bx-check-double"></i></div><div><div class="ml-stat-value">{{ number_format($stats['completed']) }}</div><div class="ml-stat-label">Selesai</div></div></div></div></div></div>
        <div class="col-6 col-md-4 col-xl"><div class="card shadow-sm h-100"><div class="card-body py-2 px-3"><div class="ml-stat"><div class="ml-stat-icon ic-danger"><i class="bx bx-x-circle"></i></div><div><div class="ml-stat-value">{{ number_format($stats['cancelled']) }}</div><div class="ml-stat-label">Batal</div></div></div></div></div></div>
    </div>

    <div class="card shadow-sm mb-3">
        <div class="card-body py-2 px-3">
            <div class="d-flex flex-wrap align-items-end justify-content-between gap-3">
                <form method="GET" action="{{ route('agenda.index') }}" class="d-flex flex-wrap align-items-end gap-2">
                    <div>
                        <label class="form-label small mb-0">Cari</label>
                        <input type="text" name="search" class="form-control form-control-sm" placeholder="Cari judul..." value="{{ request('search') }}" style="min-width:160px;">
                    </div>
                    <div>
                        <label class="form-label small mb-0">Status</label>
                        <select name="status" class="form-select form-select-sm" style="min-width:150px;">
                            <option value="">Semua Status</option>
                            <option value="draft" @selected(request('status')=='draft')>Draft</option>
                            <option value="published" @selected(request('status')=='published')>Published</option>
                            <option value="cancelled" @selected(request('status')=='cancelled')>Cancelled</option>
                            <option value="completed" @selected(request('status')=='completed')>Completed</option>
                        </select>
                    </div>
                    <div>
                        <label class="form-label small mb-0">Dari</label>
                        <input type="date" name="tanggal_mulai" class="form-control form-control-sm" value="{{ request('tanggal_mulai') }}">
                    </div>
                    <div>
                        <label class="form-label small mb-0">Sampai</label>
                        <input type="date" name="tanggal_selesai" class="form-control form-control-sm" value="{{ request('tanggal_selesai') }}">
                    </div>
                    <div class="d-flex gap-1">
                        <button type="submit" class="btn btn-sm btn-primary"><i class="bi bi-funnel"></i> Filter</button>
                        <a href="{{ route('agenda.index') }}" class="btn btn-sm btn-light">Reset</a>
                    </div>
                </form>
                @can('agenda.store')
                <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#modal-form-add-agenda">
                    <i class="bi bi-plus-lg"></i> Tambah Agenda
                </button>
                @endcan
            </div>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-header py-2 px-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div class="d-flex align-items-center gap-2">
                <h6 class="mb-0">Daftar Agenda</h6>
                <span class="badge bg-primary-subtle text-primary">{{ number_format($stats['total']) }} agenda</span>
            </div>
            <small class="text-muted d-none d-md-block">{{ $items->firstItem() }}-{{ $items->lastItem() }} dari {{ $items->total() }}</small>
        </div>

        @can('agenda.destroy')
        <div id="bulkBarAgenda" class="d-none align-items-center justify-content-between flex-wrap gap-2 px-3 py-2 bg-danger-subtle">
            <span class="small fw-semibold text-danger"><i class="bi bi-check-square me-1"></i><span id="bulkCountAgenda">0</span> agenda dipilih</span>
            <div class="d-flex gap-1">
                <button type="button" class="btn btn-sm btn-light" onclick="clearAgendaSelection()">Batal</button>
                <button type="button" class="btn btn-sm btn-danger" onclick="bulkDeleteAgenda()"><i class="bi bi-trash"></i> Hapus terpilih</button>
            </div>
        </div>
        <form id="bulkDeleteAgendaForm" action="{{ route('agenda.bulkDestroy') }}" method="POST" class="d-none">
            @csrf @method('DELETE')
            <div id="bulkIdsAgenda"></div>
        </form>
        @endcan

        <div class="card-body p-0">
            <div class="table-responsive mx-2">
                <table class="table table-hover mb-0" style="font-size:0.9rem;">
                    <thead class="table-light">
                        <tr>
                            @can('agenda.destroy')<th class="text-center" style="width:38px;"><input type="checkbox" id="checkAllAgenda" class="form-check-input" title="Pilih semua"></th>@endcan
                            <th>No.</th>
                            <th>Gambar</th>
                            <th>Nama Agenda</th>
                            <th>Tanggal</th>
                            <th class="hide-sm">Waktu</th>
                            <th class="hide-xs">Lokasi</th>
                            <th>Status</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($items as $item)
                        <tr>
                            @can('agenda.destroy')<td class="text-center"><input type="checkbox" class="form-check-input agenda-check" value="{{ $item->uuid }}"></td>@endcan
                            <td>{{ ($items->currentPage()-1)*$items->perPage() + $loop->iteration }}</td>
                            <td>
                                @if($item->gambar)
                                <img src="{{ asset('storage/' . $item->gambar) }}" alt="Gambar Agenda" class="rounded" style="width:60px;height:42px;object-fit:cover;" loading="lazy">
                                @else
                                <span class="d-inline-flex align-items-center justify-content-center rounded bg-light text-muted" style="width:60px;height:42px;"><i class="bi bi-image"></i></span>
                                @endif
                            </td>
                            <td style="min-width:180px;"><span class="fw-semibold">{{ Str::limit($item->judul, 50) }}</span></td>
                            <td><small>{{ $item->tanggal?->format('d/m/Y') ?? '-' }}</small></td>
                            <td class="hide-sm"><small>@if($item->waktu_mulai){{ $item->waktu_mulai }}@if($item->waktu_selesai) - {{ $item->waktu_selesai }}@endif@else-@endif</small></td>
                            <td class="hide-xs"><small>{{ Str::limit($item->lokasi ?? '-', 25) }}</small></td>
                            <td>
                                @if ($item->status === 'published')
                                <span class="badge bg-success">Pub</span>
                                @elseif ($item->status === 'draft')
                                <span class="badge bg-secondary">Draft</span>
                                @elseif ($item->status === 'cancelled')
                                <span class="badge bg-danger">Batal</span>
                                @elseif ($item->status === 'completed')
                                <span class="badge bg-primary">Selesai</span>
                                @endif
                            </td>
                            <td>
                                <div class="d-flex gap-1">
                                    @can('agenda.update')
                                    <a data-bs-toggle="modal" data-bs-target="#modal-form-edit-agenda-{{ $item->uuid }}" class="btn btn-sm btn-success" title="Edit"><i class="bi bi-pencil"></i></a>
                                    @include('pages.agenda.modal-edit')
                                    @endcan
                                    @can('agenda.destroy')
                                    <a onclick="showSweetAlert('{{ $item->uuid }}')" title="Hapus" class="btn btn-sm btn-danger"><i class="bi bi-trash"></i></a>
                                    <form id="deleteForm_{{ $item->uuid }}" action="{{ route('agenda.destroy', $item->uuid) }}" method="POST" class="d-none">
                                        @method('DELETE')
                                        @csrf
                                    </form>
                                    @endcan
                                </div>
                            </td>
                        </tr>
                        @empty
                        <tr><td colspan="9" class="text-center py-4 text-muted">Belum ada agenda.</td></tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
            <div class="p-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
                <small class="text-muted">Menampilkan {{ $items->firstItem() }}-{{ $items->lastItem() }} dari {{ $items->total() }}</small>
                <div>{{ $items->links('pagination::minimal') }}</div>
            </div>
        </div>
    </div>
</section>
<!-- / Content -->

@include('pages.agenda.modal-create')

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
                document.getElementById('deleteForm_' + getId).submit();
            }
        });
    }

    document.addEventListener('DOMContentLoaded', function () {
        const checkAll = document.getElementById('checkAllAgenda');
        const bulkBar = document.getElementById('bulkBarAgenda');
        const bulkCount = document.getElementById('bulkCountAgenda');
        if (!checkAll || !bulkBar) return;

        function updateBulkBar() {
            const checks = document.querySelectorAll('.agenda-check');
            const n = document.querySelectorAll('.agenda-check:checked').length;
            bulkCount.textContent = n;
            bulkBar.classList.toggle('d-none', n === 0);
            bulkBar.classList.toggle('d-flex', n > 0);
            checkAll.checked = n > 0 && n === checks.length;
            checkAll.indeterminate = n > 0 && n < checks.length;
            checks.forEach(c => c.closest('tr').classList.toggle('row-selected', c.checked));
        }

        checkAll.addEventListener('change', function () {
            document.querySelectorAll('.agenda-check').forEach(c => { c.checked = this.checked; });
            updateBulkBar();
        });

        document.addEventListener('change', function (e) {
            if (e.target.classList.contains('agenda-check')) updateBulkBar();
        });

        window.clearAgendaSelection = function () {
            document.querySelectorAll('.agenda-check:checked').forEach(c => { c.checked = false; });
            updateBulkBar();
        };

        window.bulkDeleteAgenda = function () {
            const ids = Array.from(document.querySelectorAll('.agenda-check:checked')).map(c => c.value);
            if (!ids.length) return;
            Swal.fire({title:'Hapus ' + ids.length + ' agenda?', text:'Data terpilih akan dihapus permanen.', icon:'warning', showCancelButton:true, confirmButtonText:'Ya, Hapus!', confirmButtonColor:'#f43f5e'}).then(r => {
                if (r.isConfirmed) {
                    const form = document.getElementById('bulkDeleteAgendaForm');
                    const box = document.getElementById('bulkIdsAgenda');
                    box.innerHTML = '';
                    ids.forEach(id => {
                        const input = document.createElement('input');
                        input.type = 'hidden'; input.name = 'ids[]'; input.value = id;
                        box.appendChild(input);
                    });
                    form.submit();
                }
            });
        };

        updateBulkBar();
    });
</script>
@endsection
