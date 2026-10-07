## Project background

Rekonstruksi frontend portal resmi Dinas Bina Marga dan Sumber Daya Air (DBMSDA) Kota Bekasi berdasarkan referensi `dbmsda.bekasikota.go.id` dan aset React yang diberikan pengguna. Sasaran utamanya masyarakat Kota Bekasi yang mencari berita, layanan, agenda, profil dinas, serta informasi infrastruktur dan sumber daya air.

## Product shape

- Static React + TypeScript + Vite single-page experience yang dapat dipublikasikan melalui QW Pages.
- Halaman beranda responsif dengan navigasi history URL-bersih (dengan redirect warisan `#/...`), hero institusional, berita, layanan, agenda, jurnal, galeri, inspirasi, profil singkat, dan footer kontak.
- Interaksi utama mencakup splash yang dapat ditutup dengan scroll/keyboard, menu desktop/mobile dengan focus trap, pencarian berita lokal, carousel berita utama, countdown agenda, dan navigasi history tanpa reload.
- Arah visual mengikuti identitas situs resmi: biru-navy DBMSDA, aksen merah-putih, tipografi KoHo, komposisi editorial, dan aset institusional dari arsip pengguna.
- Cangkang statis dapat dipublikasikan via QW Pages tanpa server; data dinamis (berita, banner, menu) dimuat same-origin dari backend (`/be/*`, `/api/*`, `/storage/*`) dan halaman tetap me-render cangkang saat API gagal.
- Beranda mengikuti urutan referensi resmi: hero, dua countdown, berita utama, kartu berita, banner ISS 2026, kategori, layanan, pengumuman, jurnal, galeri, inspirasi, pembaruan sosial, dan footer.
- Galeri pertama terhubung ke halaman detail foto berbasis path yang memuat metadata, kontrol berbagi, carousel tujuh foto lokal, deskripsi, berita terkait, inspirasi, galeri, pembaruan sosial, dan banner agenda.
- Kode harus aman untuk browser, bebas HTML injection, tidak memakai `dangerouslySetInnerHTML`, membatasi input, menerapkan CSP, memiliki fokus keyboard yang jelas, dan menghormati preferensi reduced motion.
