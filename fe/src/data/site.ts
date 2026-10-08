/**
 * Konstanta situs: tautan resmi, kanal kontak, dan nama berkas chrome UI.
 * Nilainya faktual (alamat, nomor call center, email) dan menjadi cadangan bila
 * hasil sinkronisasi tidak menemukan bagiannya.
 */

export const OFFICIAL_SITE = 'https://umkm.go.id';

export const CONTACT = {
  address:
    'Jl. Gatot Subroto No.Kav. 94, RT.11/RW.3, Pancoran, Kec. Pancoran, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12780',
  phone: '106',
  email: 'persuratan@umkm.go.id',
  whatsapp: 'https://wa.me/62811380280?text=Hello%2C%20UMKM!.',
};

/** Berkas chrome UI yang diunduh `scripts/sync-umkm.mjs` ke public/image. */
export const ICONS = {
  logoColor: '/image/logoUmkm4.svg',
  logoWhite: '/image/logoUmkm4_white.svg',
  flagId: '/image/indonesia.svg',
  whatsapp: '/image/whatsapp.svg',
  author: '/image/user.svg',
  date: '/image/calendar.svg',
} as const;

export const SOCIAL_ICONS: Record<string, string> = {
  instagram: '/image/InstagramCircle.svg',
  facebook: '/image/FacebookCircle.svg',
  youtube: '/image/YoutubeCircle.svg',
  twitter: '/image/TwitterCircle.svg',
};

/** Tautan default per jenis bagian, dipakai kalau hasil sync tidak membawa href. */
export const FALLBACK_LINK = {
  berita: `${OFFICIAL_SITE}/berita`,
  publikasi: `${OFFICIAL_SITE}/publikasi`,
  filosofi: `${OFFICIAL_SITE}/filosofi`,
  kebijakan: `${OFFICIAL_SITE}/arah-kebijakan`,
  home: OFFICIAL_SITE,
} as const;

/** Label tab berita sesuai urutan di beranda situs asal. */
export const BERITA_TABS = ['Siaran Pers', 'Info Tips', 'Warta UMKM'] as const;
export type BeritaTab = (typeof BERITA_TABS)[number];

export const INSTAGRAM = {
  profile: 'https://instagram.com/kementerianumkm',
  handle: '@kementerianumkm',
  tagBase: 'https://www.instagram.com/explore/tags/',
  tags: ['TemanUMKM', 'KitaUMKM', 'SapaUMKM'],
} as const;

/** Sumber daftar "Artikel" — RSS publik yang sama dengan widget di situs asal. */
export const GPR_FEED = 'https://widget.komdigi.go.id/data/covid-19/gpr.xml?v=20250703';
