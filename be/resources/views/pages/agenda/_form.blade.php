<div class="row">
    <div class="col-md-8">
        <div class="mb-3">
            <label class="form-label">Nama Agenda <span class="text-danger">*</span></label>
            <input type="text" name="judul" class="form-control @error('judul') is-invalid @enderror" value="{{ old('judul', $item->judul ?? '') }}" required>
            @error('judul')<div class="invalid-feedback">{{ $message }}</div>@enderror
        </div>
        <div class="mb-3">
            <label class="form-label">Deskripsi <span class="text-danger">*</span></label>
            <textarea name="deskripsi" rows="6" class="form-control summernote @error('deskripsi') is-invalid @enderror" required>{{ old('deskripsi', $item->deskripsi ?? '') }}</textarea>
            @error('deskripsi')<div class="invalid-feedback">{{ $message }}</div>@enderror
        </div>
    </div>
    <div class="col-md-4">
        <div class="mb-3">
            <label class="form-label">Gambar @if(!isset($item))<span class="text-danger">*</span>@endif</label>
            <input type="file" name="gambar" class="form-control @error('gambar') is-invalid @enderror" accept="image/*">
            @error('gambar')<div class="invalid-feedback">{{ $message }}</div>@enderror
            @if(isset($item) && $item->gambar)<div class="mt-2"><img src="{{ asset('storage/'.$item->gambar) }}" style="max-width:100%; height:auto;" class="rounded"></div>@endif
        </div>
        <div class="mb-3"><label class="form-label">Tanggal *</label><input type="date" name="tanggal" class="form-control @error('tanggal') is-invalid @enderror" value="{{ old('tanggal', isset($item) ? $item->tanggal?->format('Y-m-d') : '') }}" required>@error('tanggal')<div class="invalid-feedback">{{ $message }}</div>@enderror</div>
        <div class="row g-2">
            <div class="col-6"><label class="form-label">Waktu Mulai</label><input type="time" name="waktu_mulai" class="form-control" value="{{ old('waktu_mulai', $item->waktu_mulai ?? '') }}"></div>
            <div class="col-6"><label class="form-label">Waktu Selesai</label><input type="time" name="waktu_selesai" class="form-control" value="{{ old('waktu_selesai', $item->waktu_selesai ?? '') }}"></div>
        </div>
        <div class="mb-3 mt-3"><label class="form-label">Lokasi</label><input type="text" name="lokasi" class="form-control" value="{{ old('lokasi', $item->lokasi ?? '') }}"></div>
        <div class="mb-3"><label class="form-label">Status *</label><select name="status" class="form-select" required><option value="draft" @selected(old('status', $item->status ?? 'draft')=='draft')>Draft</option><option value="published" @selected(old('status', $item->status ?? '')=='published')>Published</option><option value="cancelled" @selected(old('status', $item->status ?? '')=='cancelled')>Cancelled</option><option value="completed" @selected(old('status', $item->status ?? '')=='completed')>Completed</option></select></div>
    </div>
</div>
