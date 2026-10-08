/**
 * Adaptor data: mengubah hasil generate `beranda.generated.ts` (data indeks:
 * judul, tanggal, penulis, tautan, berkas media) menjadi model tampilan bertipe
 * ketat yang dipakai komponen, plus nilai cadangan supaya tidak ada bagian yang bolong.
 *
 * Kalimat deskriptif ditulis ulang sendiri (lihat DESKRIPSI) dan tidak diambil dari
 * teks situs asal.
 */
import gen from './beranda.generated';
import { BERITA_TABS, CONTACT, FALLBACK_LINK, ICONS, INSTAGRAM, OFFICIAL_SITE, SOCIAL_ICONS } from './site';
import type {
  AgendaView,
  BannerView,
  NavItem,
  NewsCardView,
  NewsLinkView,
  SiteLinkView,
  SlideView,
  SocialLinkView,
} from '@/types/view';

const DESKRIPSI = {
  kenali: 'Kenali makna di balik logo Kementerian UMKM sebagai gambaran identitas dan semangat pelayanan kami.',
  kebijakan:
    'Rencana lima tahun ke depan menitikberatkan digitalisasi, pembiayaan, dan penguatan ekosistem usaha agar UMKM lebih berdaya saing.',
} as const;

const or = (value: string | null | undefined, fallback: string): string => value || fallback;
const idOf = (href: string | null, fallback: string): string =>
  (href || '').split('/').filter(Boolean).pop() || fallback;

function slideList<T extends { title: string; image: string | null; href: string | null; id?: string }>(
  items: T[] | undefined,
  fallbackHref: string,
): SlideView[] {
  return (items || [])
    .filter((x) => Boolean(x.image))
    .map((x) => ({
      id: idOf(x.href, x.title.slice(0, 24)),
      title: x.title,
      image: x.image as string,
      href: or(x.href, fallbackHref),
    }));
}

export const scrapedAt = gen.scrapedAt;
export const dataOrigin = or(gen.origin, OFFICIAL_SITE);

export const heroSlides: SlideView[] = slideList(gen.hero, `${OFFICIAL_SITE}/berita`);

export const kebijakanSlides: SlideView[] = slideList(gen.kebijakan, FALLBACK_LINK.kebijakan).map((s) => ({
  ...s,
  id: 'arah-kebijakan',
}));

/** Satu kalimat ringkas tulisan sendiri, bukan teks yang disalin. */
export const kebijakanExcerpt = DESKRIPSI.kebijakan;

export const newsFlash: NewsLinkView[] = (gen.newsFlash || []).map((n) => ({
  title: n.title,
  href: or(n.href, FALLBACK_LINK.berita),
}));

const readTab = (name: string): NewsCardView[] =>
  (gen.tabs?.[name] || [])
    .filter((c) => Boolean(c.image))
    .slice(0, 4)
    .map((c) => ({
      title: c.title,
      author: or(c.author, 'Humas Kementerian UMKM'),
      date: c.date || '',
      image: c.image as string,
      href: or(c.href, FALLBACK_LINK.berita),
    }));

export const beritaTabs = Object.fromEntries(
  BERITA_TABS.map((t) => [t, readTab(t)]).filter(([, list]) => (list as NewsCardView[]).length),
) as Record<string, NewsCardView[]>;

export const beritaTabNames = Object.keys(beritaTabs);

export const kenali = {
  title: or(gen.kenali?.title, 'Kenali Lebih Dekat'),
  excerpt: DESKRIPSI.kenali,
  image: or(gen.kenali?.image, ICONS.logoColor),
  href: or(gen.kenali?.href, FALLBACK_LINK.filosofi),
};

export const situsTerkait: SiteLinkView[] = (gen.situs || [])
  .filter((s) => Boolean(s.image))
  .map((s) => ({ name: or(s.name, 'Situs Terkait'), image: s.image as string, href: or(s.href, OFFICIAL_SITE) }));

export const bannerSlides: BannerView[] = (gen.banners || [])
  .filter((b) => Boolean(b.image))
  .map((b, i) => ({ name: or(b.name, `Banner ${i + 1}`), image: b.image as string, href: or(b.href, OFFICIAL_SITE) }));

export const agendaItems: AgendaView[] = (gen.agenda?.items || []).map((a) => ({
  title: a.title,
  date: '',
  href: a.href,
}));

export const agendaMessage = or(gen.agenda?.message, 'Data Tidak Ditemukan');

export const eMag = {
  image: or(gen.emag?.image, ICONS.logoColor),
  href: or(gen.emag?.href, FALLBACK_LINK.publikasi),
};

/** Foto untuk grid media sosial: ambil dari slide hero lalu dilengkapi kartu berita. */
export const socialImages: string[] = Array.from(
  new Set([
    ...heroSlides.map((h) => h.image),
    ...Object.values(beritaTabs).flatMap((list) => list.map((c) => c.image)),
  ]),
).slice(0, 4);

export const socialLinks = {
  profile: INSTAGRAM.profile,
  handle: INSTAGRAM.handle,
  avatar: kenali.image,
  tags: [...INSTAGRAM.tags],
};

/** Ikon media sosial: tautan hasil sync dipasangkan dengan berkas ikon lokal. */
/** Empat akun sosial resmi: tautan diambil dari footer hasil sync, ikonnya berkas lokal. */
const SOCIAL_ORDER = [
  { label: 'Instagram', match: /instagram/i, fallback: 'https://instagram.com/kementerianumkm', icon: SOCIAL_ICONS.instagram },
  { label: 'Facebook', match: /facebook/i, fallback: 'https://www.facebook.com/kementerianumkm', icon: SOCIAL_ICONS.facebook },
  { label: 'YouTube', match: /youtube/i, fallback: 'https://www.youtube.com/@kementerianumkm', icon: SOCIAL_ICONS.youtube },
  { label: 'Twitter/X', match: /twitter|x\.com/i, fallback: 'https://x.com/kementerianumkm', icon: SOCIAL_ICONS.twitter },
] as const;

export const socialAccounts: SocialLinkView[] = SOCIAL_ORDER.map(({ label, match, fallback, icon }) => {
  const found = (gen.footer?.social || []).find((s) => match.test(`${s.label} ${s.href}`));
  return { label, href: found?.href || fallback, icon };
});

/** Menu drawer; entri WA Center dirender terpisah oleh Header. */
export const menuItems: NavItem[] = (gen.menu || [])
  .filter((m) => m.label && !/wa center/i.test(m.label))
  .map((m) => ({ label: m.label, href: m.href, external: !m.href.startsWith(OFFICIAL_SITE) }));

const footerText = (gen.footer?.lines || []).join(' ');

export const official = {
  site: OFFICIAL_SITE,
  logo: gen.footer?.logo || null,
  address: (gen.footer?.lines || []).find((l) => /^Jl\./i.test(l)) || CONTACT.address,
  phone: footerText.match(/Call Center\s*:?\s*(\d{3,6})/i)?.[1] || CONTACT.phone,
  email: footerText.match(/[\w.+-]+@[\w-]+\.[\w.-]+/i)?.[0] || CONTACT.email,
  whatsapp: (gen.menu || []).find((m) => /wa center/i.test(m.label))?.href || CONTACT.whatsapp,
};
