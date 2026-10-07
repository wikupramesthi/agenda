@extends('layouts.app')
@section('title', 'Kelola Berita')
@section('content')

@section('breadcrumb')
    <x-breadcrumb title="Kelola Berita" page="Berita" active="Daftar Berita" route="{{ route('articles.index') }}" />
@endsection

<style>
    .article-check { width: 17px; height: 17px; cursor: pointer; }
    #checkAllArticle { width: 17px; height: 17px; cursor: pointer; }
    tr.row-selected > td { background-color: rgba(13, 110, 253, .07) !important; }
    #bulkBarArticle { border: 1px solid rgba(244, 63, 94, .25); }
</style>

<section class="section">
    @if (session('success'))
        <div class="alert alert-success alert-dismissible mb-3 fade show" role="alert">
            <span class="alert-text text-white">{{ session('success') }}</span>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    @endif
    @if (session('error'))
        <div class="alert alert-danger alert-dismissible mb-3 fade show" role="alert">
            <span class="alert-text text-white">{{ session('error') }}</span>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    @endif

    {{-- Kartu statistik: angka mengikuti data hasil filter --}}
    <div class="row mb-3 g-3 ml-stats">
        <div class="col-6 col-md-4 col-xl"><div class="card shadow-sm h-100"><div class="card-body py-2 px-3"><div class="ml-stat"><div class="ml-stat-icon ic-primary"><i class="bx bx-news"></i></div><div><div class="ml-stat-value">{{ number_format($stats['total']) }}</div><div class="ml-stat-label">Total Berita</div></div></div></div></div></div>
        <div class="col-6 col-md-4 col-xl"><div class="card shadow-sm h-100"><div class="card-body py-2 px-3"><div class="ml-stat"><div class="ml-stat-icon ic-success"><i class="bx bx-check-circle"></i></div><div><div class="ml-stat-value">{{ number_format($stats['published']) }}</div><div class="ml-stat-label">Published</div></div></div></div></div></div>
        <div class="col-6 col-md-4 col-xl"><div class="card shadow-sm h-100"><div class="card-body py-2 px-3"><div class="ml-stat"><div class="ml-stat-icon ic-warning"><i class="bx bx-edit"></i></div><div><div class="ml-stat-value">{{ number_format($stats['draft']) }}</div><div class="ml-stat-label">Draft</div></div></div></div></div></div>
        <div class="col-6 col-md-4 col-xl"><div class="card shadow-sm h-100"><div class="card-body py-2 px-3"><div class="ml-stat"><div class="ml-stat-icon ic-violet"><i class="bx bxs-star"></i></div><div><div class="ml-stat-value">{{ number_format($stats['featured']) }}</div><div class="ml-stat-label">Featured</div></div></div></div></div></div>
        <div class="col-6 col-md-4 col-xl"><div class="card shadow-sm h-100"><div class="card-body py-2 px-3"><div class="ml-stat"><div class="ml-stat-icon ic-danger"><i class="bx bxs-flame"></i></div><div><div class="ml-stat-value">{{ number_format($stats['popular']) }}</div><div class="ml-stat-label">Populer</div></div></div></div></div></div>
    </div>

    <div class="card shadow-sm mb-3">
        <div class="card-body py-2 px-3">
            <div class="d-flex flex-wrap align-items-end justify-content-between gap-3">
                <form method="GET" action="{{ route('articles.index') }}" class="d-flex flex-wrap align-items-end gap-2">
                    <div><label class="form-label small mb-0">Cari</label><input type="text" name="search" value="{{ request('search') }}" class="form-control form-control-sm" placeholder="Judul..." style="min-width:180px;"></div>
                    <div><label class="form-label small mb-0">Status</label><select name="status" class="form-select form-select-sm" style="min-width:150px;"><option value="">Semua</option><option value="published" @selected($status==='published')>Published</option><option value="draft" @selected($status==='draft')>Draft</option><option value="scheduled" @selected($status==='scheduled')>Scheduled</option></select></div>
                    <div><label class="form-label small mb-0">Dari</label><input type="date" name="start_date" class="form-control form-control-sm" value="{{ $start_date }}"></div>
                    <div><label class="form-label small mb-0">Sampai</label><input type="date" name="end_date" class="form-control form-control-sm" value="{{ $end_date }}"></div>
                    <div class="d-flex gap-1"><button type="submit" class="btn btn-sm btn-primary"><i class="bi bi-funnel"></i> Filter</button><a href="{{ route('articles.index') }}" class="btn btn-sm btn-light">Reset</a></div>
                </form>
                @can('articles.store')<a href="{{ route('articles.create') }}" class="btn btn-sm btn-primary"><i class="bi bi-plus-lg"></i> Tambah</a>@endcan
            </div>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-header py-2 px-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div class="d-flex align-items-center gap-2">
                <h6 class="mb-0">Daftar Berita</h6>
                <span class="badge bg-primary-subtle text-primary">{{ number_format($stats['total']) }} berita</span>
            </div>
            <small class="text-muted d-none d-md-block">{{ $articles->firstItem() }}-{{ $articles->lastItem() }} dari {{ $articles->total() }}</small>
        </div>

        @can('articles.destroy')
        <div id="bulkBarArticle" class="d-none align-items-center justify-content-between flex-wrap gap-2 px-3 py-2 bg-danger-subtle">
            <span class="small fw-semibold text-danger"><i class="bi bi-check-square me-1"></i><span id="bulkCountArticle">0</span> berita dipilih</span>
            <div class="d-flex gap-1">
                <button type="button" class="btn btn-sm btn-light" onclick="clearArticleSelection()">Batal</button>
                <button type="button" class="btn btn-sm btn-danger" onclick="bulkDeleteArticle()"><i class="bi bi-trash"></i> Hapus terpilih</button>
            </div>
        </div>
        <form id="bulkDeleteArticleForm" action="{{ route('articles.bulkDestroy') }}" method="POST" class="d-none">
            @csrf @method('DELETE')
            <div id="bulkIdsArticle"></div>
        </form>
        @endcan

        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0" style="font-size:0.9rem;">
                    <thead class="table-light">
                        <tr>
                            @can('articles.destroy')<th class="text-center" style="width:38px;"><input type="checkbox" id="checkAllArticle" class="form-check-input" title="Pilih semua"></th>@endcan
                            <th>No</th><th>Gambar</th><th>Judul</th><th class="hide-xs">Kategori</th><th class="hide-sm">Penulis</th><th>Status</th><th class="hide-xs">Label</th><th class="hide-sm">Dilihat</th><th class="hide-xs">Tanggal</th><th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($articles as $item)
                            <tr>
                                @can('articles.destroy')<td class="text-center"><input type="checkbox" class="form-check-input article-check" value="{{ $item->uuid }}"></td>@endcan
                                <td>{{ ($articles->currentPage()-1)*$articles->perPage() + $loop->iteration }}</td>
                                <td>@if($item->thumbnail_url)<img src="{{ $item->thumbnail_url }}" alt="{{ $item->title }}" class="rounded" style="width:60px;height:42px;object-fit:cover;" loading="lazy">@else<span class="d-inline-flex align-items-center justify-content-center rounded bg-light text-muted" style="width:60px;height:42px;"><i class="bi bi-image"></i></span>@endif</td>
                                <td class="article-title-cell"><span class="fw-semibold d-block" style="font-size:0.9rem;">{{ Str::limit($item->title, 50) }}</span>@if($item->excerpt)<small class="text-muted d-block">{{ Str::limit($item->excerpt, 60) }}</small>@endif</td>
                                <td class="hide-xs"><small>{{ $item->category->name ?? '-' }}</small></td>
                                <td class="hide-sm"><small>{{ $item->user->name ?? '-' }}</small></td>
                                <td>@if($item->status==='published')<span class="badge bg-success">Pub</span>@elseif($item->status==='draft')<span class="badge bg-secondary">Draft</span>@else<span class="badge bg-warning text-dark">Sch</span>@endif</td>
                                <td class="hide-xs">@if($item->is_featured)<span class="badge bg-warning-subtle text-warning"><i class="bi bi-star-fill"></i></span>@endif @if($item->is_popular)<span class="badge bg-danger-subtle text-danger"><i class="bi bi-fire"></i></span>@endif</td>
                                <td class="hide-sm"><small><i class="bi bi-eye"></i> {{ number_format($item->views) }}</small></td>
                                <td class="hide-xs"><small>{{ optional($item->scheduled_at)->format('d/m/y') ?? '-' }}</small></td>
                                <td><div class="d-flex gap-1">@can('articles.update')<a href="{{ route('articles.edit', $item->uuid) }}" class="btn btn-sm btn-success"><i class="bi bi-pencil"></i></a>@endcan @can('articles.destroy')<a onclick="showSweetAlert('{{ $item->uuid }}')" class="btn btn-sm btn-danger"><i class="bi bi-trash"></i></a><form id="deleteForm_{{ $item->uuid }}" action="{{ route('articles.destroy', $item->uuid) }}" method="POST" class="d-none">@method('DELETE')@csrf</form>@endcan</div></td>
                            </tr>
                        @empty
                            <tr><td colspan="11" class="text-center py-4 text-muted">Belum ada berita.</td></tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
            <div class="p-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
                <small class="text-muted">Menampilkan {{ $articles->firstItem() }}-{{ $articles->lastItem() }} dari {{ $articles->total() }}</small>
                <div>{{ $articles->links('pagination::minimal') }}</div>
            </div>
        </div>
    </div>
</section>

<script>
    function showSweetAlert(getId) {
        Swal.fire({title:'Hapus berita?', text:'Akan dihapus permanen.', icon:'warning', showCancelButton:true, confirmButtonText:'Ya, Hapus!'}).then(r=>{ if(r.isConfirmed) document.getElementById('deleteForm_'+getId).submit(); });
    }

    document.addEventListener('DOMContentLoaded', function () {
        const checkAll = document.getElementById('checkAllArticle');
        const bulkBar = document.getElementById('bulkBarArticle');
        const bulkCount = document.getElementById('bulkCountArticle');
        if (!checkAll || !bulkBar) return;

        function updateBulkBar() {
            const checks = document.querySelectorAll('.article-check');
            const selected = document.querySelectorAll('.article-check:checked');
            const n = selected.length;
            bulkCount.textContent = n;
            bulkBar.classList.toggle('d-none', n === 0);
            bulkBar.classList.toggle('d-flex', n > 0);
            checkAll.checked = n > 0 && n === checks.length;
            checkAll.indeterminate = n > 0 && n < checks.length;
            checks.forEach(c => c.closest('tr').classList.toggle('row-selected', c.checked));
        }

        checkAll.addEventListener('change', function () {
            document.querySelectorAll('.article-check').forEach(c => { c.checked = this.checked; });
            updateBulkBar();
        });

        document.addEventListener('change', function (e) {
            if (e.target.classList.contains('article-check')) updateBulkBar();
        });

        window.clearArticleSelection = function () {
            document.querySelectorAll('.article-check:checked').forEach(c => { c.checked = false; });
            updateBulkBar();
        };

        window.bulkDeleteArticle = function () {
            const ids = Array.from(document.querySelectorAll('.article-check:checked')).map(c => c.value);
            if (!ids.length) return;
            Swal.fire({title:'Hapus ' + ids.length + ' berita?', text:'Data terpilih akan dihapus permanen.', icon:'warning', showCancelButton:true, confirmButtonText:'Ya, Hapus!', confirmButtonColor:'#f43f5e'}).then(r => {
                if (r.isConfirmed) {
                    const form = document.getElementById('bulkDeleteArticleForm');
                    const box = document.getElementById('bulkIdsArticle');
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
