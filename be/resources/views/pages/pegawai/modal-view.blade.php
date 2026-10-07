<div class="modal fade" id="modal-view-pegawai-{{ $user->uuid }}" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content shadow-lg border-0 rounded-3">
            <div class="modal-header">
                <h5 class="modal-title">Detail Pegawai</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <div class="row g-4 align-items-start">
                    <div class="col-md-4 text-center">
                        @if ($user->avatar)
                        <img src="{{ Str::startsWith($user->avatar, 'http') ? $user->avatar : asset('storage/' . $user->avatar) }}"
                            alt="Foto {{ $user->name }}" class="img-fluid rounded-circle shadow" style="max-width: 150px;">
                        @else
                        <div class="bg-light rounded-circle d-flex align-items-center justify-content-center"
                            style="width:150px; height:150px; margin:auto;">
                            <i class="bi bi-person fs-1 text-muted"></i>
                        </div>
                        @endif
                        <h5 class="mt-3 mb-1">{{ $user->name }}</h5>
                        <small class="text-muted">{{ $user->email }}</small>
                        <div class="mt-2">
                            @if (($user->is_active ?? 'active') === 'active')
                            <span class="badge bg-success-subtle text-success">Aktif</span>
                            @else
                            <span class="badge bg-danger-subtle text-danger">Nonaktif</span>
                            @endif
                            @if ($user->is_pejabat)
                            <span class="badge bg-warning-subtle text-warning">
                                <i class="bi bi-award"></i> Pejabat
                                @if ($user->urutan_pejabat)#{{ $user->urutan_pejabat }}@endif
                            </span>
                            @endif
                        </div>
                    </div>

                    <div class="col-md-8">
                        <table class="table table-sm table-borderless">
                            <tr>
                                <th class="text-muted" style="width: 35%;">Jabatan</th>
                                <td>
                                    <div class="d-flex flex-wrap gap-1">
                                        @forelse ($user->departments as $department)
                                        <span class="badge bg-primary">{{ $department->name }}</span>
                                        @empty
                                        <span class="text-muted">-</span>
                                        @endforelse
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="text-muted">NIP</th>
                                <td>{{ $user->nip ?? '-' }}</td>
                            </tr>
                            <tr>
                                <th class="text-muted">No. HP</th>
                                <td>{{ $user->no_hp ?? '-' }}</td>
                            </tr>
                            <tr>
                                <th class="text-muted">TTL</th>
                                <td>{{ $user->tempat_lahir ?? '-' }}{{ $user->tanggal_lahir ? ', ' . \Carbon\Carbon::parse($user->tanggal_lahir)->translatedFormat('d M Y') : '' }}</td>
                            </tr>
                            <tr>
                                <th class="text-muted">Jenis Kelamin</th>
                                <td>{{ $user->jenis_kelamin == 'L' ? 'Laki-laki' : ($user->jenis_kelamin == 'P' ? 'Perempuan' : '-') }}</td>
                            </tr>
                            <tr>
                                <th class="text-muted">Agama</th>
                                <td>{{ $user->agama ?? '-' }}</td>
                            </tr>
                            <tr>
                                <th class="text-muted">Alamat</th>
                                <td>
                                    {{ $user->alamat ?? '-' }}<br>
                                    <small class="text-muted">
                                        {{ $user->kelurahan->nama ?? '' }}{{ $user->kecamatan ? ', ' . $user->kecamatan->nama : '' }}
                                    </small>
                                </td>
                            </tr>
                            <tr>
                                <th class="text-muted">Unit Kerja</th>
                                <td>{{ $user->unit_kerja ?? '-' }}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
            </div>
        </div>
    </div>
</div>
