# beranda-umkm-react

Rekonstruksi antarmuka beranda **umkm.go.id** sebagai Page statis (React 18 + TypeScript +
Vite + Tailwind CSS 3 + Swiper 11). Hanya layar beranda; semua tautan menunjuk ke situs resmi.

Dipublikasikan sebagai Page Qwenwork: `app-fd5a6387-4ed153f9` (versi V1).

## Menjalankan

```bash
npm install
npm run dev -- --port 3000    # pengembangan
npm run typecheck && npm test # cek tipe + build + validasi artefak dist/
```

## Menyegarkan konten dari situs asal

```bash
npm run sync                  # tulis src/data/beranda.generated.ts + unduh media ke public/
npm run sync:check            # dry-run: cetak hasil pembacaan, tidak menulis apa pun
```

`scripts/sync-umkm.mjs` membuka beranda di browser yang dirender (Playwright), menggulir
sampai semua bagian termuat, lalu membaca:

| Bagian | Yang diambil |
| --- | --- |
| Hero (5 slide) | judul, gambar, URL berita |
| News Flash | teks running text |
| Berita Terkini | 3 tab × 4 kartu: judul, penulis, tanggal, gambar, URL |
| Arah Kebijakan | judul, gambar latar, URL |
| Kenali Lebih Dekat | judul, gambar, URL |
| Situs Terkait | 5 logo + URL |
| Banner promosi | 4 gambar + URL |
| Agenda | isian "Data Tidak Ditemukan" / daftar agenda |
| E-Magz, menu drawer, kontak footer | gambar/URL/nomor telepon/email |

Yang ditulis ke berkas **hanya data indeks yang memang tampil di beranda** (judul, tanggal,
penulis, tautan) dan berkas media — tidak ada teks artikel. Kalimat deskriptif yang dibaca
layar ditulis ulang sendiri di `src/data/beranda-view.ts`.

Kenapa lewat DOM, bukan API: endpoint CMS situs asal (`175utx.umkm.go.id/api/*`) menolak
permintaan lintas origin (HTTP 403), termasuk dari dalam tab situs itu sendiri.

Prasyarat sekali jalan:

```bash
npx playwright install chromium          # browser untuk renderer
npm i -D sharp                           # opsional, untuk --resize 1400
CHROME_PATH=/usr/bin/chromium npm run sync   # kalau browser sistem dipakai
```

Flag lain: `--no-media` (tanpa unduh gambar), `--out <dir>` (proyek lain), `--resize <px>`.

## Alur data

```
situs asal ──(Playwright baca DOM)──▶ scripts/sync-umkm.mjs
                                          ├─▶ public/uploads/*, public/image/*
                                          ├─▶ src/data/beranda.generated.ts   (hasil generate, jangan diedit)
                                          └─▶ src/data/beranda.source.json    (ringkasan jumlah item)
                                    src/data/beranda-view.ts (adaptor bertipe + teks sendiri)
                                          └─▶ src/components/{layout,home,ui}/*.tsx
```

## Struktur sumber

```
src/
  App.tsx                    menyusun urutan section beranda
  main.tsx                   mount React
  styles.css                 Tailwind + chrome Swiper + marquee + kalender
  types/    beranda.ts (kontrak data hasil sync), view.ts (model tampilan)
  data/     site.ts (konstanta situs & kontak), beranda.generated.ts (hasil generate),
            beranda.source.json, beranda-view.ts (adaptor: generate → model tampilan)
  lib/      swiper.ts (preset carousel), calendar.ts (grid bulan, tanggal, nama hari)
  components/
    layout/  AppHeader, MenuDrawer, AppFooter, UnofficialNotice
    home/    HeroSection, NewsFlashBar, KenaliSection, BeritaSection,
             KebijakanSection, SitusTerkaitSection, MediaSocialSection,
             InstagramFeed, AgendaPanel, ArticleFeed, PromoBannerCarousel
    ui/      Icon, PillLink (+ PillTag), SectionHeading, MetaLine, NewsCard, MonthCalendar
tools/      compare-layout.mjs (bandingkan geometri dengan beranda asal)
```

Import memakai alias `@/*` → `src/*` (tsconfig `paths` + Vite `resolve.alias`).

Kalau `sync` gagal membaca satu bagian, adaptor di `src/data/beranda-view.ts` tetap menyediakan
nilai cadangan sehingga halaman tidak bolong. Jalankan ulang `npm run typecheck && npm test`
setelah setiap sinkronisasi.

## Isi arsip source

Berkas `beranda-umkm-react.tar.gz` berisi kode sumber, konfigurasi, dan data indeks hasil
`sync` (`src/data/beranda.generated.ts`: judul, tanggal, penulis, tautan). **Berkas media
situs asal (`public/image/*`, `public/uploads/*`) tidak ikut disertakan** — ambil dengan
`npm run sync` di mesin Anda (script yang sama mengunduh logo, ikon, foto, dan banner ke
dua folder itu). Setelahnya jalankan `npm run check:assets` untuk memastikan tidak ada
referensi aset yang bocor.

## Catatan

- Penanda "rekonstruksi antarmuka, bukan situs resmi" (`src/components/DemoNotice.tsx` dan
  strip footer) sengaja dipertahankan karena tampilan meniru portal pemerintah.
- Indexing dicegah lewat `meta robots: noindex,nofollow` di `index.html`.
- Konteks produk dan keputusan teknis ada di `AGENTS.md`.
