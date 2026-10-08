/** Model tampilan yang dipakai komponen: bidang wajib sudah terisi (tanpa null). */

export type NavItem = { label: string; href: string; external?: boolean };

export type SlideView = { id: string; title: string; image: string; href: string };

export type NewsLinkView = { title: string; href: string };

export type NewsCardView = {
  title: string;
  author: string;
  date: string;
  image: string;
  href: string;
};

export type SiteLinkView = { name: string; image: string; href: string };

export type BannerView = { name: string; image: string; href: string };

export type AgendaView = { title: string; date: string; href: string };

export type SocialLinkView = { label: string; href: string; icon: string };
