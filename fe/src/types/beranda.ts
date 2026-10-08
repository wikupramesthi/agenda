/**
 * Kontrak data mentah hasil `scripts/sync-umkm.mjs` (lihat beranda.generated.ts).
 * Isinya hanya data indeks yang memang tampil di beranda: judul, tanggal, penulis,
 * tautan, dan jalur berkas media. Tidak memuat teks artikel.
 */

export type ScrapedSlide = {
  id?: string;
  title: string;
  image: string | null;
  href: string | null;
};

export type ScrapedNews = {
  title: string;
  author?: string;
  date?: string;
  image: string | null;
  href: string | null;
};

export type ScrapedItem = {
  name?: string;
  title?: string;
  label?: string;
  image?: string | null;
  href?: string | null;
};

export type Beranda = {
  scrapedAt: string;
  origin: string;
  pageTitle: string;
  hero: ScrapedSlide[];
  newsFlash: { title: string; href: string | null }[];
  tabs: Record<string, ScrapedNews[]>;
  kebijakan: (ScrapedSlide & { excerpt?: string })[];
  kenali: { title: string; excerpt: string; image: string | null; href: string | null };
  situs: { name: string; image: string | null; href: string | null }[];
  situsLainnya: string | null;
  banners: { name: string; image: string | null; href: string | null }[];
  emag: { image: string | null; href: string | null; alt: string } | null;
  agenda: { message: string; items: { title: string; href: string }[] };
  footer: {
    logo: string | null;
    social: { label: string; href: string; icon: string | null }[];
    lines: string[];
  };
  menu: { label: string; href: string }[];
};
