# AGENTS.md

## Project background

Aplikasi ini adalah **rekonstruksi antarmuka (UI clone) halaman beranda `umkm.go.id`**,
portal publik Kementerian Usaha Mikro, Kecil, dan Menengah RI, yang dibangun ulang sebagai
halaman statis React + TypeScript + Vite + Tailwind CSS.

- **Pengguna sasaran:** developer yang mempelajari struktur dan gaya visual portal
  pemerintahan; bukan pengunjung yang mencari layanan resmi kementerian.
- **Tujuan produk:** mereproduksi tata letak, token desain, dan urutan section beranda
  sedekat mungkin dengan aslinya, dengan kode yang ditulis sendiri (bukan salinan bundel
  produksi situs asal), serta tetap ringan (satu halaman, tanpa server).
- **Batas lingkup:** hanya layar beranda. Setiap tautan berita, menu, situs terkait, dan
  kontak mengarah ke domain resmi `umkm.go.id` / instansi terkait, sehingga tidak ada
  konten detail atau alur layanan yang ditiru di halaman ini.
- **Sifat non-komersial dan non-resmi:** halaman ini tidak memiliki form login, form
  pengumpulan data, pembayaran, atau pengajuan layanan apa pun — tidak ada jalur yang bisa
  dipakai untuk memancing data pengunjung.

## Product shape

- **Kategori Page:** `static`. Semua perilaku berjalan di browser; satu-satunya jaringan
  saat runtime adalah RSS publik Komdigi (`GPR_FEED` di `src/data/site.ts`, CORS terbuka)
  yang dipakai daftar "Artikel", plus Google Fonts.
- **Struktur sumber** (TypeScript strict, alias import `@/*` → `src/*`):
  `src/types` kontrak data hasil sync (`beranda.ts`) dan model tampilan (`view.ts`);
  `src/data` = konstanta situs (`site.ts`), berkas generate (`beranda.generated.ts`,
  `beranda.source.json`) dan adaptor `beranda-view.ts`; `src/lib` = preset Swiper
  (`swiper.ts`) dan util kalender (`calendar.ts`); `src/components` terbagi `layout/`
  (AppHeader, MenuDrawer, AppFooter, UnofficialNotice), `home/` (satu berkas per bagian
  beranda), dan `ui/` (Icon, PillLink/PillTag, SectionHeading, MetaLine, NewsCard,
  MonthCalendar). `src/App.tsx` hanya menyusun urutan section.
  tsconfig: `strict`, `noUnusedLocals`, `noUnusedParameters`, `noFallthroughCasesInSwitch`.
- **Alat bantu:** `tools/compare-layout.mjs` dan probe anchor membandingkan posisi/tinggi
  section klon dengan beranda asal pada viewport 1440×900. Kondisi terakhir: total
  5213px vs 5237px (Δ24px ≈ 0,5%) dan seluruh anchor section dalam ±24px.
- **Susunan layar (atas ke bawah):**
  1. `Header` — bar fixed; transparan dengan logo putih di puncak halaman, menjadi putih
     ber-drop-shadow setelah scroll > 40px; dropdown bahasa Indonesia/English (kosmetik);
     drawer kiri `#244563` berisi Beranda, Profil, Berita, Regulasi, Publikasi, Pengumuman,
     garis pemisah, lalu WA Center.
  2. `Hero` — slideshow `h-screen` (Swiper: loop, autoplay 6s, panah, pagination) dengan
     foto penuh, overlay gradasi navy, judul `text-5xl font-bold line-clamp-2` dan tombol
     outline "Selengkapnya"; di bawahnya `NewsFlash` setinggi 48px (bar `#244563`, badge
     `#FEC01F` `rounded-r-full`, marquee CSS 42s yang jeda saat hover).
  3. `Kenali` — kartu putih `rounded-xl` dua kolom (teks 42% dengan judul berhuruf KoHo
     kapital berwarna `#26295D`, gambar 58%).
  4. `BeritaTerkini` — label kecil + judul kapital 30px, tab Siaran Pers / Info Tips /
     Warta UMKM (aktif `#d8b049`, tidak aktif `#244563`), grid 1/2/3/4 kolom kartu berita
     (`rounded-xl`, `shadow-card`, gambar 205px, baris penulis, judul clamp-2, tanggal).
  5. `Kebijakan` — carousel banner 682px dengan latar foto, overlay navy kiri-mengarah
     transparan, judul 48px putih, ringkasan, tombol pil kuning.
  6. `SitusTerkait` — judul 30px, baris 5 logo mitra (grayscale halus, hover penuh),
     tombol "Lihat Lainnya" `rounded-xl` navy.
  7. `InfoSection` — latar gradasi putih → `#E3B131`, grid 3 kolom: 2 kolom `MediaSosial`
     (judul + chip profil IG + tagar + grid foto 2 kolom) dan 1 kolom berisi `Calendar`,
     `Agenda` (+ banner E-Magz), serta `ArtikelGpr`.
  8. `BannerCarousel` — 4 banner promosi penuh-lebar (640px) dengan panah navy.
  9. `Footer` — panel navy (logo putih, alamat, Call Center 106, email, 4 ikon sosial)
     lalu strip `#132432` bertuliskan bahwa halaman ini rekonstruksi bukan situs resmi.
- **`DemoNotice` (wajib dipertahankan):** pil tetap di kiri-bawah yang menyatakan halaman
  ini latihan pengembangan dan bukan portal resmi, dengan tautan ke `umkm.go.id`. Karena
  tampilan meniru situs pemerintahan, penanda asal-usul ini tidak boleh dihapus tanpa
  konfirmasi bahwa pemiliknya berhak atas merek/instansi tersebut.
- **Pipeline data:** `npm run sync` menjalankan `scripts/sync-umkm.mjs` (Playwright):
  membuka beranda situs asal, menggulir agar semua lazy-load termuat, membaca DOM
  (5 slide hero, bar news flash, 3 tab berita masing-masing 4 kartu, banner arah kebijakan,
  4 banner promosi, 5 situs terkait, menu drawer, kontak footer), mengklik tab berita tanpa
  mengklik ulang tab yang sedang aktif, lalu mengunduh media (opsi `--resize 1400` memakai
  `sharp`) dan menulis hasilnya ke `src/data/beranda.generated.ts` +
  `src/data/beranda.source.json`. Yang disimpan hanya data indeks yang memang tampil di
  beranda (judul, tanggal, penulis, tautan) dan berkas media — bukan teks artikel.
  `scripts/sync-umkm.mjs --dry-run` mencetak hasil tanpa menulis; `--no-media` melewatkan
  unduhan; `--out <dir>` mengarahkan ke proyek lain.
  Endpoint API situs asal (Strapi) menolak permintaan lintas origin (HTTP 403), karena itu
  pembacaan lewat DOM yang dirender.
- **`src/data/beranda-view.ts` adalah adaptor bertipe** di atas berkas generate: ia menyeleksi
  bidang yang benar-benar dipakai komponen, memberi nilai cadangan bila suatu bagian gagal
  terbaca, memakai kembali teks deskriptif buatan sendiri (`kenaliExcerpt`,
  `kebijakanExcerpt`), dan menyediakan konstanta kontak institution (`official`).
  Jangan mengedit `beranda.generated.ts` manual; ubah lewat script atau adaptor.
- **Aset:** logo, ikon, foto berita, dan banner disimpan di `public/` (disalin dari aset
  publik situs asal lalu diperkecil) agar pratinjau tampil identik dan berjalan luring.
- **Token desain** (`tailwind.config.js`): `cust-blue #244563`, `cust-orange #d8b049`,
  `cust-black #212121`, `cust-gray #ededed`, `cust-silver #f8f8f8`, `gold #E3B131`,
  `flash #FEC01F`, `ink #26295D`, `night #132432`; font `Ubuntu` (teks isi) dan `KoHo`
  (judul tertentu), diukur dari computed style situs asli.
- **Batas lain:** tidak ada routing (satu layar), tidak ada penyimpanan data pengunjung,
  `meta robots: noindex,nofollow` agar tidak terindeks sebagai duplikat portal pemerintah.

## Working in this repo

- `npm run dev -- --port 3000` untuk pengembangan; `npm run typecheck` dan `npm test`
  (build + validasi artefak `dist/`) sebelum checkpoint/publish.
- `npm run sync` butuh Playwright + browsernya (`npx playwright install chromium`) dan
  opsional `sharp` untuk `--resize`; browser bisa ditunjuk lewat `CHROME_PATH=...`.
  Setelah sync, jalankan `npm run typecheck && npm test` ulang karena berkas generate berubah.
- Jangan meng-commit `dist/` atau `node_modules/`; jangan mengganti Vite/npm/React
  template dengan toolchain lain.
