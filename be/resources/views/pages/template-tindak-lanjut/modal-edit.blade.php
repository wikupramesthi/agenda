<div id="modal-form-edit-template-{{ $item->uuid }}" class="modal fade modal-form-template-edit" tabindex="-1"
    aria-labelledby="modal-form-edit-template-{{ $item->uuid }}-label" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <form action="{{ route('templates.update', $item->uuid) }}" method="post">
                @csrf
                @method('PUT')

                <div class="modal-header">
                    <h5 class="modal-title" id="modal-form-edit-template-{{ $item->uuid }}-label">Edit Template Respons</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"> </button>
                </div>

                <div class="modal-body">
                    <div class="form-group mb-3">
                        <label for="judul" class="mb-2">Judul <span class="text-danger">*</span></label>
                        <input type="text" class="form-control @error('judul') is-invalid @enderror"
                            id="judul" placeholder="Judul template" name="judul"
                            value="{{ $item->judul ?? old('judul') }}" required maxlength="150">
                        @error('judul')
                        <div class="invalid-feedback">
                            {{ $message }}
                        </div>
                        @enderror
                    </div>

                    <div class="form-group mb-3">
                        <label for="isi" class="mb-2">Isi Template <span class="text-danger">*</span></label>
                        <textarea class="form-control summernote @error('isi') is-invalid @enderror" id="isi"
                            name="isi" rows="6" required>{{ $item->isi ?? old('isi') }}</textarea>
                        @error('isi')
                        <div class="invalid-feedback">
                            {{ $message }}
                        </div>
                        @enderror
                        <div class="form-text">
                            Gunakan placeholder: <code>{nomor_aduan}</code>, <code>{judul_aduan}</code>, <code>{nama_pelapor}</code>
                        </div>
                    </div>

                    <div class="form-group mb-3 form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="is_active" name="is_active"
                            value="1" {{ (isset($item) && $item->is_active) || old('is_active', false) ? 'checked' : '' }}>
                        <label class="form-check-label" for="is_active">Aktif (tersedia untuk dipakai petugas)</label>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>