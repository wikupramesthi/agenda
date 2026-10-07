@php
    $agenda = $agenda ?? null;
    $featuredImage = $agenda->featured_image ?? null;
@endphp

<form action="{{ $action }}" method="post" enctype="multipart/form-data">
    @csrf
    @if (($method ?? 'POST') !== 'POST')
        @method($method)
    @endif

    <div class="row g-4">
        {{-- Konten Utama --}}
        <div class="col-lg-8">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="card-title mb-0">Konten Agenda</h5>
                </div>
                <div class="card-body">
                    <div class="form-group mb-3">
                        <label for="title" class="form-label">Judul Agenda <span class="text-danger">*</span></label>
                        <input type="text" name="title" id="title"
                            class="form-control @error('title') is-invalid @enderror"
                            value="{{ old('title', $agenda->title ?? '') }}" placeholder="Tulis judul agenda" required>
                        @error('title')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="form-group mb-3">
                        <label for="excerpt" class="form-label">Ringkasan Singkat</label>
                        <input type="text" name="excerpt" id="excerpt"
                            class="form-control @error('excerpt') is-invalid @enderror"
                            value="{{ old('excerpt', $agenda->excerpt ?? '') }}"
                            placeholder="Ringkasan yang tampil pada kartu agenda (opsional)">
                        @error('excerpt')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="form-group mb-3" id="videoForm" style="display: none;">
                        <label for="video" class="form-label">Link YouTube
                            <span class="text-muted">(contoh: PlNOD--gPQU)</span>
                        </label>
                        <input type="text" name="video" id="video" class="form-control"
                            value="{{ old('video', $agenda->video ?? '') }}" placeholder="Masukkan link YouTube">
                    </div>

                    <div class="form-group mb-0">
                        <label for="deskripsi" class="form-label">Isi Agenda <span class="text-danger">*</span></label>
                        <textarea name="content" id="deskripsi" cols="30" rows="8"
                            class="form-control summernote @error('content') is-invalid @enderror">{{ old('content', $agenda->content ?? '') }}</textarea>
                        @error('content')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="card-title mb-0">Gambar Utama</h5>
                </div>
                <div class="card-body">
                    <div class="form-group mb-0">
                        <label for="featured_image" class="form-label">Featured Image
                            <span class="text-muted">(maks 2 MB)</span>
                        </label>
                        <input type="file" name="featured_image" id="featured_image" accept="image/*"
                            class="form-control @error('featured_image') is-invalid @enderror">
                        @error('featured_image')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror

                        @if ($featuredImage)
                            <img src="{{ asset('storage/' . $featuredImage) }}" alt="Featured"
                                class="img-fluid rounded-3 mt-3">
                        @endif
                        <div class="form-text"><i class="bi bi-info-circle"></i> Kosongkan jika tidak ingin mengubah gambar.</div>
                    </div>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0">Foto Slider Agenda</h5>
                    <span class="badge bg-primary-subtle text-primary"><i class="bi bi-images"></i> Bisa lebih dari 1 foto</span>
                </div>
                <div class="card-body">
                    <p class="text-muted small mb-3">
                        Foto-foto ini akan tampil sebagai <strong>slider</strong> pada halaman detail agenda.
                        Foto pertama (urutan paling atas) akan dipakai sebagai gambar utama bila Featured Image kosong.
                    </p>

                    @if ($agenda && $agenda->images->isNotEmpty())
                        <div class="agenda-photo-grid mb-3">
                            @foreach ($agenda->images as $image)
                                <div class="agenda-photo-item">
                                    <img src="{{ $image->url() }}" alt="Foto agenda">
                                    <button type="button" class="agenda-photo-remove" title="Hapus foto">
                                        <i class="bi bi-x-lg"></i>
                                    </button>
                                    <input type="checkbox" name="remove_images[]" value="{{ $image->uuid }}"
                                        class="agenda-photo-remove-input" hidden>
                                </div>
                            @endforeach
                        </div>
                    @endif

                    <input type="file" name="images[]" id="agendaImages" accept="image/*" multiple
                        class="form-control @error('images') is-invalid @enderror @error('images.*') is-invalid @enderror">
                    @error('images')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                    @error('images.*')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                    <div class="form-text"><i class="bi bi-info-circle"></i> Format JPG, PNG, WEBP. Maks 2 MB per foto. Bisa pilih beberapa sekaligus.</div>

                    <div class="agenda-photo-grid mt-3" id="agendaImagesPreview"></div>
                </div>
            </div>
        </div>

        {{-- Sidebar Meta --}}
        <div class="col-lg-4">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="card-title mb-0">Publikasi</h5>
                </div>
                <div class="card-body">
                    <div class="form-group mb-3">
                        <label for="status" class="form-label">Status <span class="text-danger">*</span></label>
                        @if(auth()->user()->hasAnyRole(['super-admin', 'admin']))
                        <select name="status" id="status" class="form-select @error('status') is-invalid @enderror" required>
                            <option value="published" @selected(old('status', $agenda->status ?? 'published') === 'published')>Published</option>
                            <option value="pending" @selected(old('status', $agenda->status ?? '') === 'pending')>Pending (menunggu approval)</option>
                            <option value="draft" @selected(old('status', $agenda->status ?? '') === 'draft')>Draft</option>
                            <option value="scheduled" @selected(old('status', $agenda->status ?? '') === 'scheduled')>Scheduled</option>
                        </select>
                        @else
                        <input type="hidden" name="status" value="pending">
                        <div class="alert alert-warning mb-0 py-2 px-3 small">
                            <i class="bi bi-hourglass-split me-1"></i>
                            Agenda yang Anda kirim otomatis berstatus <strong>Pending</strong> dan menunggu persetujuan admin sebelum dipublikasikan.
                        </div>
                        @endif
                        @error('status')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="form-group mb-3">
                        <label for="scheduled_at" class="form-label">Tanggal Terbit</label>
                        <input type="date" name="scheduled_at" id="scheduled_at"
                            class="form-control @error('scheduled_at') is-invalid @enderror"
                            value="{{ old('scheduled_at', optional($agenda->scheduled_at ?? null)->format('Y-m-d') ?? now()->format('Y-m-d')) }}">
                        @error('scheduled_at')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="form-group mb-3">
                        <label for="search_engine" class="form-label">Search Engine <span class="text-danger">*</span></label>
                        <select name="search_engine" id="search_engine"
                            class="form-select @error('search_engine') is-invalid @enderror" required>
                            <option value="index" @selected(old('search_engine', $agenda->search_engine ?? 'index') === 'index')>Index</option>
                            <option value="noindex" @selected(old('search_engine', $agenda->search_engine ?? '') === 'noindex')>No Index</option>
                        </select>
                        @error('search_engine')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <hr>

                    <div class="form-check form-switch mb-2">
                        <input class="form-check-input" type="checkbox" role="switch" name="is_featured"
                            id="is_featured" value="1" @checked(old('is_featured', $agenda->is_featured ?? false))>
                        <label class="form-check-label" for="is_featured">
                            <i class="bi bi-star-fill text-warning"></i> Agenda <strong>Featured</strong>
                        </label>
                    </div>
                    <div class="form-check form-switch mb-0">
                        <input class="form-check-input" type="checkbox" role="switch" name="is_popular"
                            id="is_popular" value="1" @checked(old('is_popular', $agenda->is_popular ?? false))>
                        <label class="form-check-label" for="is_popular">
                            <i class="bi bi-fire text-danger"></i> Agenda <strong>Populer</strong>
                        </label>
                    </div>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="card-title mb-0">Kategori & Tag</h5>
                </div>
                <div class="card-body">
                    <div class="form-group mb-3">
                        <label for="category_uuid" class="form-label">Kategori <span class="text-danger">*</span></label>
                        <select name="category_uuid" id="category_uuid"
                            class="form-select @error('category_uuid') is-invalid @enderror" required>
                            <option value="">-- Pilih Kategori --</option>
                            @foreach ($categories as $category)
                                <option value="{{ $category->uuid }}"
                                    data-name="{{ strtolower(str_replace(' ', '-', $category->name)) }}"
                                    @selected(old('category_uuid', $agenda->category_uuid ?? '') == $category->uuid)>
                                    {{ $category->name }}
                                </option>
                            @endforeach
                        </select>
                        @error('category_uuid')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="form-group mb-0">
                        <label for="tagging" class="form-label">Tags</label>
                        <input type="text" name="tagging" id="tagging"
                            class="form-control @error('tagging') is-invalid @enderror"
                            value="{{ old('tagging', $agenda->tagging ?? '') }}"
                            placeholder="Pisahkan dengan koma: agenda, kota bekasi">
                        @error('tagging')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>
                </div>
            </div>

            <div class="d-flex justify-content-end gap-2">
                <a href="{{ route('agendas.index') }}" class="btn btn-light">Batal</a>
                <button class="btn btn-primary" type="submit">
                    <i class="bi bi-save"></i> {{ $submitLabel }}
                </button>
            </div>
        </div>
    </div>
</form>

@push('after-script')
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const categorySelect = document.getElementById('category_uuid');
            const videoForm = document.getElementById('videoForm');
            const videoInput = document.getElementById('video');

            function toggleVideoForm() {
                if (!categorySelect) return;
                const selected = categorySelect.options[categorySelect.selectedIndex];
                const categoryName = selected?.getAttribute('data-name')?.toLowerCase() || '';

                if (categoryName.includes('video-galeri')) {
                    videoForm.style.display = 'block';
                } else {
                    videoForm.style.display = 'none';
                    if (videoInput) videoInput.value = '';
                }
            }

            if (categorySelect) {
                categorySelect.addEventListener('change', toggleVideoForm);
                toggleVideoForm();
            }

            // Hapus foto yang sudah tersimpan
            document.querySelectorAll('.agenda-photo-remove').forEach(function (button) {
                button.addEventListener('click', function () {
                    const item = this.closest('.agenda-photo-item');
                    const checkbox = item.querySelector('.agenda-photo-remove-input');
                    checkbox.checked = !checkbox.checked;
                    item.classList.toggle('is-removed', checkbox.checked);
                });
            });

            // Preview foto yang baru dipilih (akumulatif: tiap pilih bisa nambah terus)
            const input = document.getElementById('agendaImages');
            const preview = document.getElementById('agendaImagesPreview');

            if (input && preview) {
                let pendingFiles = [];

                function syncInputFiles() {
                    const dt = new DataTransfer();
                    pendingFiles.forEach(function (file) {
                        dt.items.add(file);
                    });
                    input.files = dt.files;
                }

                function renderPreview() {
                    preview.innerHTML = '';

                    if (pendingFiles.length === 0) return;

                    pendingFiles.forEach(function (file, index) {
                        const reader = new FileReader();
                        reader.onload = function (event) {
                            const item = document.createElement('div');
                            item.className = 'agenda-photo-item';
                            item.innerHTML = '<img src="' + event.target.result + '" alt="preview">' +
                                '<button type="button" class="agenda-photo-remove" title="Batalkan foto">' +
                                '<i class="bi bi-x-lg"></i></button>';

                            item.querySelector('.agenda-photo-remove').addEventListener('click', function () {
                                pendingFiles.splice(index, 1);
                                syncInputFiles();
                                renderPreview();
                            });

                            preview.appendChild(item);
                        };
                        reader.readAsDataURL(file);
                    });
                }

                input.addEventListener('change', function () {
                    Array.from(this.files).forEach(function (file) {
                        if (!file.type.startsWith('image/')) return;
                        pendingFiles.push(file);
                    });

                    syncInputFiles();
                    renderPreview();
                });
            }
        });
    </script>
@endpush
