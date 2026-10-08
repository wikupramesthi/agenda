@extends('layouts.app')

@section('content')

<div class="container-fluid px-md-4">

    {{-- Data injection for external JS --}}
    <script>
        window.dashboardData = {
            visitorStats: @json($visitorStats),
            agendas: {
                total: {{ $totalAgendas }},
                published: {{ $publishedAgendas }}
            },
            agendaTrenLabels: @json($agendaTrenLabels ?? []),
            agendaTrenData: @json($agendaTrenData ?? []),
            agendaPendingData: @json($agendaPendingData ?? []),
            topOpdLabels: @json(($topOpd ?? collect())->pluck('name')),
            topOpdData: @json(($topOpd ?? collect())->pluck('total_agenda')),
            agendaKategoriLabels: @json($agendaKategoriLabels ?? []),
            agendaKategoriData: @json($agendaKategoriData ?? []),
            komposisiKontenLabels: @json($komposisiKontenLabels ?? []),
            komposisiKontenData: @json($komposisiKontenData ?? []),
            browserLabels: @json($browserStats ? $browserStats->keys()->values() : []),
            browserData: @json($browserStats ? $browserStats->values()->values() : []),
            kotaLabels: @json($kotaStats ? $kotaStats->keys()->values() : []),
            kotaData: @json($kotaStats ? $kotaStats->values()->values() : []),
            routes: {
                deviceStats: "{{ route('dashboard.device-stats') }}"
            }
        };
    </script>

    {{-- Hero Section --}}
    <div class="dash-hero mb-3">
        <div class="hero-content d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <span class="hero-date">
                    <i class="bi bi-calendar3 me-1"></i>
                    {{ now()->translatedFormat('l, j F Y') }}
                </span>
                @php
                    $hourNow = (int) now()->format('H');
                    $greeting = $hourNow < 11 ? 'Selamat Pagi' : ($hourNow < 15 ? 'Selamat Siang' : ($hourNow < 19 ? 'Selamat Sore' : 'Selamat Malam'));
                @endphp
                <h3 class="fw-bold mb-1">{{ $greeting }}, {{ auth()->user()->name }}</h3>
                <p class="mb-0 small text-white">Ringkasan statistik pengunjung website Pemerintah Kota Bekasi.</p>
                @if (($pendingCount ?? 0) > 0)
                    <a href="{{ route('agendas.index', ['status' => 'pending']) }}" class="btn btn-sm btn-warning text-dark mt-2">
                        <i class="bi bi-hourglass-split me-1"></i>{{ $pendingCount }} agenda menunggu persetujuan
                    </a>
                @endif
            </div>
            <div class="d-flex gap-2 hero-actions">
                <a href="{{ route('dashboard.analytics.preview', request()->only(['start_date', 'end_date'])) }}" class="btn btn-success"><i class="bi bi-file-earmark-bar-graph me-1"></i> Download Analytics</a>
                <a href="{{ route('agendas.create') }}" class="btn btn-light"><i class="bi bi-plus-lg me-1"></i> Tulis Agenda</a>
            </div>
        </div>
    </div>

    {{-- Date Range Filter --}}
    <div class="card shadow-sm mb-3">
        <div class="card-body py-2 px-3">
            <form method="GET" action="{{ route('dashboard.index') }}" class="d-flex flex-wrap align-items-end gap-2">
                <div class="d-flex align-items-center gap-1">
                    <label class="form-label small fw-semibold mb-0 me-1">Dari</label>
                    <input type="date" name="start_date" class="form-control form-control-sm dash-date-input" value="{{ request('start_date', now()->subDays(30)->format('Y-m-d')) }}">
                </div>
                <div class="d-flex align-items-center gap-1">
                    <label class="form-label small fw-semibold mb-0 me-1">Sampai</label>
                    <input type="date" name="end_date" class="form-control form-control-sm dash-date-input" value="{{ request('end_date', now()->format('Y-m-d')) }}">
                </div>
                <div class="d-flex gap-1">
                    <button type="submit" class="btn btn-primary btn-sm"><i class="bi bi-filter me-1"></i> Filter</button>
                    <a href="{{ route('dashboard.index') }}" class="btn btn-danger btn-sm"><i class="bi bi-x-circle me-1"></i> Reset</a>
                </div>
                <div class="small text-muted ms-auto d-none d-md-block"><strong>Range:</strong> {{ $dateRangeLabel }}</div>
            </form>
        </div>
    </div>

<!-- Key Stats Row with Trends -->
    <div class="row g-4 mb-4">
        {{-- Total Visitors --}}
        <div class="col-6 col-lg-3">
            <a href="{{ route('health.page') }}" class="text-decoration-none text-reset">
                <div class="card border-danger shadow-sm h-100 stat-card hover-lift">
                    <div class="card-body d-flex align-items-center gap-3 p-4 p-md-5">
                        <div class="stats-icon bg-light-soft-red rounded-3 p-3 flex-shrink-0" style="width: 40px; height: 40px; font-size: 1.1rem;">
                            <i class='bi bi-people-fill text-danger'></i>
                        </div>
                        <div class="min-w-0">
                            <div class="stat-label small text-truncate d-block" title="{{ $dateRangeLabel ?? '' }}">Total Pengunjung ({{ $daysDiff ?? 30 }} hari)</div>
                            <div class="stat-value fw-bold text-truncate" style="font-size: 1.25rem; line-height: 1.2;">{{ number_format($visitorStats['total_visits']) }}</div>
                            @include('partials.stat-trend', ['growth' => $visitorGrowth, 'daysDiff' => $daysDiff ?? 30])
                        </div>
                    </div>
                </div>
            </a>
        </div>

        {{-- Unique Visitors --}}
        <div class="col-6 col-lg-3">
            <a href="{{ route('health.page') }}" class="text-decoration-none text-reset">
                <div class="card border-success shadow-sm h-100 stat-card hover-lift">
                    <div class="card-body d-flex align-items-center gap-3 p-4 p-md-5">
                        <div class="stats-icon bg-light-success rounded-3 p-3 flex-shrink-0" style="width: 40px; height: 40px; font-size: 1.1rem;">
                            <i class='bi bi-person-check-fill text-success'></i>
                        </div>
                        <div class="min-w-0">
                            <div class="stat-label small text-truncate d-block" title="{{ $dateRangeLabel ?? '' }}">Pengunjung Unik ({{ $daysDiff ?? 30 }} hari)</div>
                            <div class="stat-value fw-bold text-truncate" style="font-size: 1.25rem; line-height: 1.2;">{{ number_format($visitorStats['unique_visitors']) }}</div>
                            @include('partials.stat-trend', ['growth' => $uniqueGrowth, 'daysDiff' => $daysDiff ?? 30])
                        </div>
                    </div>
                </div>
            </a>
        </div>

        {{-- Total Agendas --}}
        <div class="col-6 col-lg-3">
            <a href="{{ route('agendas.index') }}" class="text-decoration-none text-reset">
                <div class="card border-info shadow-sm h-100 stat-card hover-lift">
                    <div class="card-body d-flex align-items-center gap-3 p-4 p-md-5">
                        <div class="stats-icon bg-light-info rounded-3 p-3 flex-shrink-0" style="width: 40px; height: 40px; font-size: 1.1rem;">
                            <i class='bi bi-file-text-fill text-info'></i>
                        </div>
                        <div class="min-w-0">
                            <div class="stat-label small text-truncate d-block" title="{{ $dateRangeLabel ?? '' }}">Total Agenda ({{ $daysDiff ?? 30 }} hari)</div>
                            <div class="stat-value fw-bold text-truncate" style="font-size: 1.25rem; line-height: 1.2;">{{ $totalAgendas }}</div>
                            @include('partials.stat-trend', ['growth' => $agendaGrowth, 'daysDiff' => $daysDiff ?? 30])
                        </div>
                    </div>
                </div>
            </a>
        </div>

        {{-- OPD Aktif --}}
        <div class="col-6 col-lg-3">
            <a href="{{ route('user.index') }}" class="text-decoration-none text-reset">
                <div class="card border-primary shadow-sm h-100 stat-card hover-lift">
                    <div class="card-body d-flex align-items-center gap-3 p-4 p-md-5">
                        <div class="stats-icon bg-light-primary rounded-3 p-3 flex-shrink-0" style="width: 40px; height: 40px; font-size: 1.1rem;">
                            <i class='bi bi-building-fill text-primary'></i>
                        </div>
                        <div class="min-w-0">
                            <div class="stat-label small text-truncate d-block">Total OPD Aktif</div>
                            <div class="stat-value fw-bold text-truncate" style="font-size: 1.25rem; line-height: 1.2;">{{ $totalOpdAktif }}</div>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        {{-- Pages --}}
        <div class="col-6 col-lg-3">
            <a href="{{ route('pages.index') }}" class="text-decoration-none text-reset">
                <div class="card border-dark shadow-sm h-100 stat-card hover-lift">
                    <div class="card-body d-flex align-items-center gap-3 p-4 p-md-5">
                        <div class="stats-icon bg-light-dark rounded-3 p-3 flex-shrink-0" style="width: 40px; height: 40px; font-size: 1.1rem;">
                            <i class='bi bi-file-earmark-fill text-dark'></i>
                        </div>
                        <div class="min-w-0">
                            <div class="stat-label small text-truncate d-block">Total Halaman</div>
                            <div class="stat-value fw-bold text-truncate" style="font-size: 1.25rem; line-height: 1.2;">{{ $totalPages }}</div>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        {{-- Documents --}}
        <div class="col-6 col-lg-3">
            <a href="{{ route('documents.index') }}" class="text-decoration-none text-reset">
                <div class="card border-info shadow-sm h-100 stat-card hover-lift">
                    <div class="card-body d-flex align-items-center gap-3 p-4 p-md-5">
                        <div class="stats-icon bg-light-cyan rounded-3 p-3 flex-shrink-0" style="width: 40px; height: 40px; font-size: 1.1rem;">
                            <i class='bi bi-file-earmark-text-fill text-info'></i>
                        </div>
                        <div class="min-w-0">
                            <div class="stat-label small text-truncate d-block">Total Dokumen</div>
                            <div class="stat-value fw-bold text-truncate" style="font-size: 1.25rem; line-height: 1.2;">{{ $totalDocuments }}</div>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        {{-- FAQ --}}
        <div class="col-6 col-lg-3">
            <a href="{{ route('faq.index') }}" class="text-decoration-none text-reset">
                <div class="card border-secondary shadow-sm h-100 stat-card hover-lift">
                    <div class="card-body d-flex align-items-center gap-3 p-4 p-md-5">
                        <div class="stats-icon bg-light-secondary rounded-3 p-3 flex-shrink-0" style="width: 40px; height: 40px; font-size: 1.1rem;">
                            <i class='bi bi-question-circle-fill text-secondary'></i>
                        </div>
                        <div class="min-w-0">
                            <div class="stat-label small text-truncate d-block">FAQ Aktif</div>
                            <div class="stat-value fw-bold text-truncate" style="font-size: 1.25rem; line-height: 1.2;">{{ $totalFaq }}</div>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        {{-- Galeri --}}
        <div class="col-6 col-lg-3">
            <a href="{{ route('banner.index') }}" class="text-decoration-none text-reset">
                <div class="card border-secondary shadow-sm h-100 stat-card hover-lift">
                    <div class="card-body d-flex align-items-center gap-3 p-4 p-md-5">
                        <div class="stats-icon bg-light-secondary rounded-3 p-3 flex-shrink-0" style="width: 40px; height: 40px; font-size: 1.1rem;">
                            <i class='bi bi-images text-secondary'></i>
                        </div>
                        <div class="min-w-0">
                            <div class="stat-label small text-truncate d-block">Total Galeri</div>
                            <div class="stat-value fw-bold text-truncate" style="font-size: 1.25rem; line-height: 1.2;">{{ $totalGaleri }}</div>
                        </div>
                    </div>
                </div>
            </a>
        </div>

    </div>

    {{-- Charts Section - Tabbed --}}
    <div class="card shadow-sm mb-3">
        <div class="card-header">
            <ul class="nav nav-tabs nav-fill dash-tabs mb-0" role="tablist">
                <li class="nav-item"><button class="nav-link active" data-bs-toggle="tab" data-bs-target="#tab-visitor">Pengunjung</button></li>
                <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-content">Konten</button></li>
                <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-device">Perangkat</button></li>
            </ul>
        </div>
        <div class="card-body p-3">
            <div class="tab-content" style="min-height: 300px;">
                {{-- Visitor Tab --}}
                <div class="tab-pane fade show active" id="tab-visitor">
                    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                        <div>
                            <h6 class="mb-0">Statistik Pengunjung</h6>
                            <small class="text-muted">{{ $dateRangeLabel ?? '' }} &middot; {{ $daysDiff ?? 30 }} hari</small>
                        </div>
                        <div class="d-flex gap-2" role="group">
                            <button type="button" class="btn btn-sm chart-toggle chart-toggle-red active" data-chart-type="daily" onclick="switchVisitorChart('daily', this)"><i class="bi bi-calendar-day me-1"></i> Harian</button>
                            <button type="button" class="btn btn-sm chart-toggle chart-toggle-green" data-chart-type="monthly" onclick="switchVisitorChart('monthly', this)"><i class="bi bi-calendar-month me-1"></i> Bulanan</button>
                        </div>
                    </div>
                    <div style="height:200px"><canvas id="visitorChart"></canvas></div>
                </div>


                {{-- Content Tab --}}
                <div class="tab-pane fade" id="tab-content">
                    <div class="row g-3 mb-3">
                        <div class="col-lg-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-header bg-transparent py-2 px-3 border-bottom">
                                    <h6 class="mb-0 small fw-semibold"><i class="bi bi-bar-chart me-1"></i>Status Agenda</h6>
                                </div>
                                <div class="card-body p-3 pb-2 d-flex align-items-center justify-content-center">
                                    <div class="d-flex justify-content-center mb-3" style="height: 180px;">
                                        <canvas id="agendaStatusChart" width="180" height="180"></canvas>
                                    </div>
                                    <div class="row g-2 text-center w-100">
                                        <div class="col-4"><div class="fw-bold text-success">{{ $publishedAgendas }}</div><div class="small text-muted">Dipublikasikan</div></div>
                                        <div class="col-4"><div class="fw-bold text-warning">{{ $totalAgendas - $publishedAgendas }}</div><div class="small text-muted">Draft</div></div>
                                        <div class="col-4"><div class="fw-bold text-primary">{{ $totalAgendas }}</div><div class="small text-muted">Total</div></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-8">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-header bg-transparent py-2 px-3 border-bottom">
                                    <h6 class="mb-0 small fw-semibold"><i class="bi bi-bar-chart-steps me-1"></i>Top 5 OPD Pengirim Agenda</h6>
                                </div>
                                <div class="card-body p-3 pb-2" style="height: 260px;">
                                    <canvas id="topOpdChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row g-3">
                        <div class="col-lg-6">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-header bg-transparent py-2 px-3 border-bottom">
                                    <h6 class="mb-0 small fw-semibold"><i class="bi bi-tags me-1"></i>Agenda per Kategori</h6>
                                </div>
                                <div class="card-body p-3 pb-2" style="height: 230px;">
                                    <canvas id="agendaKategoriChart"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-header bg-transparent py-2 px-3 border-bottom">
                                    <h6 class="mb-0 small fw-semibold"><i class="bi bi-pie-chart me-1"></i>Komposisi Konten</h6>
                                </div>
                                <div class="card-body p-3 pb-2 d-flex justify-content-center" style="height: 230px;">
                                    <canvas id="komposisiKontenChart" width="230" height="230"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                {{-- Device Tab --}}
                <div class="tab-pane fade" id="tab-device">
                    <div class="row g-3">
                        <div class="col-lg-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-header bg-transparent py-2 px-3 border-bottom">
                                    <h6 class="mb-0 small fw-semibold"><i class="bi bi-device-desktop me-1"></i>Perangkat</h6>
                                </div>
                                <div class="card-body p-3 pb-2" style="height: 280px;">
                                    <div style="position: relative; height: 100%;"><canvas id="deviceChart"></canvas></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-header bg-transparent py-2 px-3 border-bottom">
                                    <h6 class="mb-0 small fw-semibold"><i class="bi bi-browser-chrome me-1"></i>Browser Pengunjung</h6>
                                </div>
                                <div class="card-body p-3 pb-2" style="height: 280px;">
                                    <div style="position: relative; height: 100%; display: flex; justify-content: center; align-items: center;"><canvas id="browserChart"></canvas></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-header bg-transparent py-2 px-3 border-bottom">
                                    <h6 class="mb-0 small fw-semibold"><i class="bi bi-geo-alt me-1"></i>Kota Asal Pengunjung</h6>
                                </div>
                                <div class="card-body p-3 pb-2" style="height: 280px;">
                                    <div style="position: relative; height: 100%;"><canvas id="kotaChart"></canvas></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    {{-- Agenda OPD: tren + top 5 + antrean approval --}}
    <div class="row g-3 mb-3">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-transparent py-2 px-3 border-bottom d-flex justify-content-between align-items-center">
                    <h6 class="mb-0 small fw-semibold"><i class="bi bi-graph-up-arrow me-1"></i>Tren Agenda OPD (6 Bulan Terakhir)</h6>
                    <a href="{{ route('agendas.index') }}" class="small text-decoration-none fw-medium text-primary">Kelola <i class="bi bi-arrow-right ms-1"></i></a>
                </div>
                <div class="card-body p-3 pb-2" style="height: 230px;">
                    <canvas id="agendaTrenChart"></canvas>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-transparent py-2 px-3 border-bottom">
                    <h6 class="mb-0 small fw-semibold"><i class="bi bi-trophy me-1"></i>Top 5 OPD</h6>
                </div>
                <div class="list-group list-group-flush">
                    @forelse ($topOpd ?? [] as $i => $opd)
                        <div class="list-group-item d-flex align-items-center gap-2 px-3 py-2">
                            <span class="fw-bold text-muted" style="width: 18px;">{{ $i + 1 }}</span>
                            <div class="avatar avatar-sm flex-shrink-0">
                                <img src="{{ $opd->avatar ? (Str::startsWith($opd->avatar, 'http') ? $opd->avatar : asset('storage/' . $opd->avatar)) : asset('dist/assets/images/avatar.jpg') }}" alt="{{ $opd->name }}" class="rounded-circle" style="width: 34px; height: 34px; object-fit: cover;">
                            </div>
                            <div class="flex-grow-1 min-w-0">
                                <div class="fw-semibold small text-truncate">{{ $opd->name }}</div>
                                <div class="progress" style="height: 5px;">
                                    <div class="progress-bar" role="progressbar" style="width: {{ ($topOpd->max('total_agenda') ?? 1) > 0 ? round($opd->total_agenda / max($topOpd->max('total_agenda'), 1) * 100) : 0 }}%;" aria-valuenow="{{ $opd->total_agenda }}" aria-valuemin="0" aria-valuemax="{{ $topOpd->max('total_agenda') ?? 1 }}"></div>
                                </div>
                            </div>
                            <div class="text-end flex-shrink-0">
                                <div class="fw-bold small">{{ $opd->total_agenda }}</div>
                                @if ($opd->pending_agenda > 0)
                                    <span class="badge bg-warning text-dark" style="font-size: 0.62rem;">{{ $opd->pending_agenda }} pending</span>
                                @else
                                    <small class="text-muted" style="font-size: 0.65rem;">agenda</small>
                                @endif
                            </div>
                        </div>
                    @empty
                        <div class="text-center text-muted py-4">
                            <i class="bi bi-inbox fs-4 d-block mb-1"></i>
                            <small>Belum ada OPD pengirim agenda.</small>
                        </div>
                    @endforelse
                </div>
            </div>
        </div>
    </div>

    @if (($pendingAgendas ?? collect())->isNotEmpty())
        <div class="card border-0 shadow-sm mb-3 border-start border-warning border-3">
            <div class="card-header bg-transparent py-2 px-3 border-bottom d-flex justify-content-between align-items-center">
                <h6 class="mb-0 small fw-semibold"><i class="bi bi-hourglass-split me-1 text-warning"></i>Antrean Persetujuan ({{ $pendingAgendas->count() }} menunggu)</h6>
                <a href="{{ route('agendas.index', ['status' => 'pending']) }}" class="small text-decoration-none fw-medium text-primary">Review semua <i class="bi bi-arrow-right ms-1"></i></a>
            </div>
            <div class="list-group list-group-flush">
                @foreach ($pendingAgendas as $agenda)
                    <div class="list-group-item d-flex align-items-center gap-2 px-3 py-2">
                        <i class="bi bi-file-earmark-text text-warning"></i>
                        <div class="flex-grow-1 min-w-0">
                            <div class="fw-semibold small text-truncate">{{ $agenda->title }}</div>
                            <small class="text-muted">oleh {{ $agenda->user->name ?? '-' }} &middot; {{ $agenda->created_at->diffForHumans() }}</small>
                        </div>
                        <a href="{{ route('agendas.edit', $agenda->uuid) }}" class="btn btn-sm btn-outline-primary">Review</a>
                    </div>
                @endforeach
            </div>
        </div>
    @endif

    {{-- Recent Activity --}}
    <div class="row g-3">
        <div class="col-lg-6">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-transparent d-flex justify-content-between align-items-center py-2 px-3 border-bottom">
                    <h5 class="card-title mb-0 small fw-semibold"><i class="bi bi-clock-history me-1"></i>Aktivitas Terbaru</h5>
                    <a href="{{ route('agendas.index') }}" class="small text-decoration-none fw-medium text-primary">Lihat Semua <i class="bi bi-arrow-right ms-1"></i></a>
                </div>
                <div class="card-body p-3 pb-2">
                    <div class="timeline">
                        @foreach ($recentActivities as $activity)
                        <div class="timeline-item {{ $activity['type'] === 'message' ? 'timeline-success' : '' }}">
                            <div class="timeline-icon bg-light-{{ $activity['color'] }} rounded-circle d-inline-flex align-items-center justify-content-center me-3" style="width: 32px; height: 32px; font-size: 0.75rem;">
                                <i class="bi {{ $activity['icon'] }} text-{{ $activity['color'] }}"></i>
                            </div>
                            <div class="flex-grow-1 min-w-0">
                                <div class="fw-medium small mb-0">{{ $activity['title'] }}</div>
                                <div class="small text-muted timeline-desc text-truncate">{{ $activity['description'] }}</div>
                            </div>
                            <div class="small text-muted ms-2 d-none d-md-block text-end">{{ $activity['date'] }}<br><span class="text-muted">{{ $activity['time']->diffForHumans() }}</span></div>
                            <a href="{{ $activity['url'] }}" class="btn btn-outline-{{ $activity['color'] }} btn-sm ms-2 d-inline-flex align-items-center text-nowrap" style="padding: 0.25rem 0.6rem; gap: 4px;"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="flex-shrink-0" viewBox="0 0 16 16"><path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8a13 13 0 0 1-1.66 2.043C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/><path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/></svg>Lihat</a>
                        </div>
                        @endforeach
                    </div>
                </div>
            </div>
        </div>

        <div class="@hasanyrole('super-admin|admin') col-lg-3 @else col-lg-6 @endhasanyrole">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-transparent py-2 px-3 border-bottom">
                    <h5 class="card-title mb-0 small fw-semibold"><i class="bi bi-eye me-1"></i>Paling Banyak Dilihat</h5>
                </div>
                <div class="list-group list-group-flush">
                    @forelse ($topViewedAgendas ?? [] as $tema)
                        <a href="{{ route('agendas.show', $tema->slug) }}" class="list-group-item list-group-item-action d-flex align-items-center gap-2 px-3 py-2">
                            <div class="flex-grow-1 min-w-0">
                                <div class="fw-semibold small text-truncate">{{ $tema->title }}</div>
                                <small class="text-muted">{{ $tema->created_at->translatedFormat('d M Y') }}</small>
                            </div>
                            <span class="badge bg-light-primary text-primary"><i class="bi bi-eye me-1"></i>{{ number_format($tema->views) }}</span>
                        </a>
                    @empty
                        <div class="text-center text-muted py-4"><small>Belum ada agenda.</small></div>
                    @endforelse
                </div>
            </div>
        </div>

        @hasanyrole('super-admin|admin')
        <div class="col-lg-3">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-transparent py-2 px-3 border-bottom">
                    <h5 class="card-title mb-0 small fw-semibold"><i class="bi bi-exclamation-triangle me-1 text-warning"></i>OPD 7 Hari Tidak Aktif</h5>
                </div>
                <div class="list-group list-group-flush">
                    @forelse ($opdTidakAktif ?? [] as $opd)
                        <div class="list-group-item d-flex align-items-center gap-2 px-3 py-2">
                            <div class="avatar avatar-sm flex-shrink-0">
                                <img src="{{ $opd['avatar'] ? (Str::startsWith($opd['avatar'], 'http') ? $opd['avatar'] : asset('storage/' . $opd['avatar'])) : asset('dist/assets/images/avatar.jpg') }}" alt="{{ $opd['name'] }}" class="rounded-circle" style="width: 30px; height: 30px; object-fit: cover;">
                            </div>
                            <div class="flex-grow-1 min-w-0">
                                <div class="fw-semibold small text-truncate">{{ $opd['name'] }}</div>
                                <small class="text-muted">{{ $opd['last_agenda'] ? 'Terakhir isi: ' . $opd['last_agenda']->diffForHumans() : 'Belum pernah isi agenda' }}</small>
                            </div>
                        </div>
                    @empty
                        <div class="text-center text-muted py-4"><small>Semua OPD aktif.</small></div>
                    @endforelse
                </div>
            </div>
        </div>
        @endhasanyrole
    </div>

</div>

@push('after-style')
<style>
    .stat-card { transition: transform 0.2s ease, box-shadow 0.2s ease; padding: 1rem !important; }
    .stat-card.hover-lift:hover { transform: translateY(-2px); box-shadow: 0 0.5rem 1rem rgba(0,0,0,.15) !important; }
    .stat-trend { display: flex; align-items: center; gap: 0.25rem; margin-top: 0.25rem; font-size: 0.7rem; }
    .stat-trend i { font-size: 0.65rem; }
    .bg-light-primary { background-color: rgba(94, 114, 228, 0.1) !important; }
    .bg-light-success { background-color: rgba(45, 206, 137, 0.1) !important; }
    .bg-light-info { background-color: rgba(13, 202, 240, 0.1) !important; }
    .bg-light-warning { background-color: rgba(251, 99, 64, 0.1) !important; }
    .bg-light-danger { background-color: rgba(245, 54, 92, 0.1) !important; }
    .bg-light-secondary { background-color: rgba(108, 117, 125, 0.1) !important; }
    .bg-light-dark { background-color: rgba(33, 37, 41, 0.1) !important; }
    .bg-light-soft-red { background-color: rgba(245, 54, 92, 0.1) !important; }
    .bg-light-cyan { background-color: rgba(13, 202, 240, 0.1) !important; }
    .timeline-item { display: flex; align-items: flex-start; gap: 12px; padding: 12px 0; border-bottom: 1px solid #f1f5f9; }
    .timeline-item:last-child { border-bottom: none; }
    .timeline-icon { flex-shrink: 0; }
    .chart-toggle { border-radius: 10px; padding: 6px 14px; font-weight: 600; font-size: 0.82rem; border: 1px solid transparent; display: inline-flex; align-items: center; transition: all .15s ease; }
    .chart-toggle-red { background-color: #fee2e2; color: #b91c1c; border-color: #fecaca; }
    .chart-toggle-red:hover { background-color: #fecaca; color: #991b1b; }
    .chart-toggle-red.active { background-color: #f87171; border-color: #f87171; color: #fff; box-shadow: 0 2px 6px rgba(248, 113, 113, .35); }
    .chart-toggle-green { background-color: #dcfce7; color: #15803d; border-color: #bbf7d0; }
    .chart-toggle-green:hover { background-color: #bbf7d0; color: #166534; }
    .chart-toggle-green.active { background-color: #22c55e; border-color: #22c55e; color: #fff; box-shadow: 0 2px 6px rgba(34, 197, 94, .35); }
</style>
@endpush

@push('after-script')
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
<script>if (typeof window.Chart === 'undefined') { document.write('<script src="{{ asset('dist/assets/extensions/chart.js/chart.umd.js') }}"><\/script>'); }</script>
<script src="{{ asset('js/dashboard/charts.js') }}"></script>
@endpush

@endsection
