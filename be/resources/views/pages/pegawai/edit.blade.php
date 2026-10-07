@extends('layouts.app')
@section('title', 'Ubah Pegawai')
@section('content')

@section('breadcrumb')
<x-breadcrumb title="Ubah Pegawai" page="Kepegawaian" active="Ubah Pegawai" route="{{ route('pegawai.index') }}" />
@endsection

@if (session('error'))
<div class="alert alert-danger alert-dismissible mb-3 mt-3 fade show" role="alert">
    <span class="text-white">{{ session('error') }}</span>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
@endif

<section class="section">
    <div class="card">
        <div class="card-body">
            <form action="{{ route('pegawai.update', $pegawai->uuid) }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('PUT')

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="avatar" class="form-label fw-medium">Foto</label>
                        <input type="file" name="avatar" id="avatar"
                            class="form-control @error('avatar') is-invalid @enderror" accept="image/*">
                        @if ($pegawai->avatar)
                        <small class="text-muted">Foto saat ini:
                            <a href="{{ Str::startsWith($pegawai->avatar, 'http') ? $pegawai->avatar : asset('storage/' . $pegawai->avatar) }}"
                                target="_blank">Lihat</a>
                        </small>
                        @endif
                        @error('avatar')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="name" class="form-label fw-medium">Nama Lengkap <span class="text-danger">*</span></label>
                        <input type="text" name="name" id="name" placeholder="Nama lengkap"
                            value="{{ old('name', $pegawai->name) }}"
                            class="form-control @error('name') is-invalid @enderror" required>
                        @error('name')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="email" class="form-label fw-medium">Email <span class="text-danger">*</span></label>
                        <input type="email" name="email" id="email" value="{{ old('email', $pegawai->email) }}"
                            class="form-control @error('email') is-invalid @enderror" required>
                        @error('email')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="no_hp" class="form-label fw-medium">Nomor HP / WhatsApp</label>
                        <input type="text" name="no_hp" id="no_hp" value="{{ old('no_hp', $pegawai->no_hp) }}"
                            placeholder="Contoh: 08123456789"
                            class="form-control @error('no_hp') is-invalid @enderror">
                        @error('no_hp')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="nip" class="form-label fw-medium">NIP</label>
                        <input type="text" name="nip" id="nip" value="{{ old('nip', $pegawai->nip) }}"
                            class="form-control @error('nip') is-invalid @enderror" placeholder="Nomor Induk Pegawai">
                        @error('nip')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="departments" class="form-label fw-medium">
                            Jabatan / Department <span class="text-danger">*</span>
                        </label>
                        @php
                        $selectedDepartments = old(
                            'departments',
                            $pegawai->departments?->pluck('uuid')?->toArray() ?? []
                        );
                        @endphp
                        <select class="form-select @error('departments') is-invalid @enderror"
                            id="departments" name="departments[]" multiple required
                            data-placeholder="Pilih jabatan...">
                            @foreach ($departments as $department)
                            <option value="{{ $department->uuid }}"
                                {{ in_array($department->uuid, $selectedDepartments) ? 'selected' : '' }}>
                                {{ $department->name }}
                            </option>
                            @endforeach
                        </select>
                        <small class="text-muted">Dapat memilih lebih dari satu jabatan.</small>
                        @error('departments')
                        <div class="text-danger small mt-1">{{ $message }}</div>
                        @enderror
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="tempat_lahir" class="form-label fw-medium">Tempat Lahir</label>
                        <input type="text" name="tempat_lahir" id="tempat_lahir"
                            value="{{ old('tempat_lahir', $pegawai->tempat_lahir) }}"
                            class="form-control @error('tempat_lahir') is-invalid @enderror">
                        @error('tempat_lahir')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="tanggal_lahir" class="form-label fw-medium">Tanggal Lahir</label>
                        <input type="date" name="tanggal_lahir" id="tanggal_lahir"
                            value="{{ old('tanggal_lahir', $pegawai->tanggal_lahir) }}"
                            class="form-control @error('tanggal_lahir') is-invalid @enderror">
                        @error('tanggal_lahir')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="jenis_kelamin" class="form-label fw-medium">Jenis Kelamin</label>
                        <select name="jenis_kelamin" id="jenis_kelamin"
                            class="form-select @error('jenis_kelamin') is-invalid @enderror">
                            <option value="">-- Pilih --</option>
                            <option value="L" {{ old('jenis_kelamin', $pegawai->jenis_kelamin) == 'L' ? 'selected' : '' }}>Laki-laki</option>
                            <option value="P" {{ old('jenis_kelamin', $pegawai->jenis_kelamin) == 'P' ? 'selected' : '' }}>Perempuan</option>
                        </select>
                        @error('jenis_kelamin')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="agama" class="form-label fw-medium">Agama</label>
                        <select name="agama" id="agama" class="form-select @error('agama') is-invalid @enderror">
                            <option value="">-- Pilih --</option>
                            @foreach (['Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Konghucu', 'Lainnya'] as $agama)
                            <option value="{{ $agama }}"
                                {{ old('agama', $pegawai->agama) == $agama ? 'selected' : '' }}>
                                {{ $agama }}
                            </option>
                            @endforeach
                        </select>
                        @error('agama')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="kecamatan" class="form-label fw-medium">Kecamatan</label>
                        <select class="form-select @error('kecamatan_id') is-invalid @enderror" id="kecamatan" name="kecamatan_id">
                            <option value="">-- Pilih Kecamatan --</option>
                            @foreach ($kecamatans as $kecamatan)
                            <option value="{{ $kecamatan->id }}"
                                {{ old('kecamatan_id', $pegawai->kecamatan_id) == $kecamatan->id ? 'selected' : '' }}>
                                {{ $kecamatan->nama }}
                            </option>
                            @endforeach
                        </select>
                        @error('kecamatan_id')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="kelurahan" class="form-label fw-medium">Kelurahan</label>
                        <select class="form-select @error('kelurahan_id') is-invalid @enderror" id="kelurahan" name="kelurahan_id">
                            <option value="">-- Pilih Kelurahan --</option>
                            @if (!empty($pegawai->kecamatan_id))
                            @php
                            $kelurahans = \App\Models\Kelurahan::where('kecamatan_id', $pegawai->kecamatan_id)->orderBy('nama')->get();
                            @endphp
                            @foreach ($kelurahans as $kelurahan)
                            <option value="{{ $kelurahan->id }}"
                                {{ old('kelurahan_id', $pegawai->kelurahan_id) == $kelurahan->id ? 'selected' : '' }}>
                                {{ $kelurahan->nama }}
                            </option>
                            @endforeach
                            @endif
                        </select>
                        @error('kelurahan_id')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>
                </div>

                <div class="mb-3">
                    <label for="alamat" class="form-label fw-medium">Alamat</label>
                    <textarea name="alamat" id="alamat" rows="2"
                        class="form-control @error('alamat') is-invalid @enderror"
                        placeholder="Alamat tempat tinggal">{{ old('alamat', $pegawai->alamat) }}</textarea>
                    @error('alamat')
                    <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="unit_kerja" class="form-label fw-medium">Unit Kerja</label>
                        <input type="text" name="unit_kerja" id="unit_kerja"
                            value="{{ old('unit_kerja', $pegawai->unit_kerja) }}"
                            class="form-control @error('unit_kerja') is-invalid @enderror"
                            placeholder="Contoh: Bidang Sumber Daya Air">
                        @error('unit_kerja')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-medium d-block">Status</label>
                        <div class="form-check form-switch mb-2">
                            <input class="form-check-input" type="checkbox" role="switch"
                                id="is_pejabat" name="is_pejabat" value="1"
                                {{ old('is_pejabat', $pegawai->is_pejabat) ? 'checked' : '' }}>
                            <label class="form-check-label" for="is_pejabat">Pejabat</label>
                        </div>
                        <div id="urutan-pejabat-wrap" class="{{ old('is_pejabat', $pegawai->is_pejabat) ? '' : 'd-none' }}">
                            <input type="number" name="urutan_pejabat" min="1"
                                value="{{ old('urutan_pejabat', $pegawai->urutan_pejabat) }}"
                                placeholder="Urutan pejabat (mis. 1)"
                                class="form-control @error('urutan_pejabat') is-invalid @enderror">
                            @error('urutan_pejabat')
                            <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>
                        <input type="hidden" name="is_active" value="inactive">
                        <div class="form-check form-switch mt-2">
                            <input class="form-check-input" type="checkbox" role="switch"
                                id="is_active" name="is_active" value="active"
                                {{ old('is_active', $pegawai->is_active ?? 'active') === 'active' ? 'checked' : '' }}>
                            <label class="form-check-label" for="is_active">Akun Aktif</label>
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="riwayat" class="form-label fw-medium">Riwayat</label>
                    <textarea name="riwayat" id="riwayat" rows="4"
                        class="form-control summernote @error('riwayat') is-invalid @enderror"
                        placeholder="Riwayat jabatan / pengalaman...">{{ old('riwayat', $pegawai->riwayat) }}</textarea>
                    @error('riwayat')
                    <div class="text-danger small mt-1">{{ $message }}</div>
                    @enderror
                </div>

                <div class="text-end mt-4">
                    <a href="{{ route('pegawai.index') }}" class="btn btn-secondary me-2">Batal</a>
                    <button type="submit" class="btn btn-primary">Perbarui</button>
                </div>
            </form>
        </div>
    </div>
</section>

@push('after-script')
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Select2 untuk department
        if (window.jQuery && window.jQuery.fn.select2 && window.jQuery('#departments').length) {
            window.jQuery('#departments').select2({
                placeholder: window.jQuery('#departments').data('placeholder') || 'Pilih jabatan...',
                width: '100%',
                closeOnSelect: false
            });
        }

        // Toggle urutan pejabat
        const pejabatSwitch = document.getElementById('is_pejabat');
        const urutanWrap = document.getElementById('urutan-pejabat-wrap');
        if (pejabatSwitch && urutanWrap) {
            pejabatSwitch.addEventListener('change', function() {
                urutanWrap.classList.toggle('d-none', !this.checked);
            });
        }

        // Cascading kecamatan -> kelurahan
        const kecSelect = document.getElementById('kecamatan');
        const kelSelect = document.getElementById('kelurahan');
        const baseUrl = "{{ url('backend/get-kelurahan') }}";
        const selectedKel = "{{ old('kelurahan_id', $pegawai->kelurahan_id) }}";
        if (kecSelect && kelSelect) {
            kecSelect.addEventListener('change', function() {
                const id = this.value;
                kelSelect.innerHTML = '<option value="">-- Pilih Kelurahan --</option>';
                if (!id) return;
                kelSelect.innerHTML = '<option value="">Memuat...</option>';
                fetch(baseUrl + '/' + id, { headers: { 'X-Requested-With': 'XMLHttpRequest' } })
                    .then(function(r) { return r.json(); })
                    .then(function(data) {
                        kelSelect.innerHTML = '<option value="">-- Pilih Kelurahan --</option>';
                        Object.entries(data).forEach(function([val, label]) {
                            const opt = document.createElement('option');
                            opt.value = val;
                            opt.textContent = label;
                            if (String(val) === String(selectedKel)) opt.selected = true;
                            kelSelect.appendChild(opt);
                        });
                    })
                    .catch(function() {
                        kelSelect.innerHTML = '<option value="">Gagal memuat kelurahan</option>';
                    });
            });
        }
    });
</script>
@endpush

@endsection
