import { fetchJson } from "../app/api";
import { toSameOriginImage } from "./articles";

// Bentuk mentah satu banner dari `GET /api/banners` (lihat BannerResource).
export type BackendBanner = {
  uuid: string;
  nama: string;
  deskripsi: string | null;
  link: string | null;
  gambar: string | null;
  posisi: string;
  tipe: string;
  status: string;
};

type Envelope<T> = { status: string; message: string; data: T };

export type BannerItem = { image: string; link: string | null; name: string };

// Ambil 1 banner terakhir pada posisi tertentu (mis. "pengumuman").
// Backend mengurutkan tertua dulu, jadi data terakhir = paling baru.
// Kembalikan null bila kosong agar pemanggil pakai fallback statis.
export async function fetchLatestBannerByPosisi(posisi: string): Promise<BannerItem | null> {
  const json = await fetchJson<Envelope<BackendBanner[]>>(
    `/api/banners?kategori=${encodeURIComponent(posisi)}`,
  );
  if (!Array.isArray(json.data) || json.data.length === 0) return null;
  const latest = json.data[json.data.length - 1];
  return {
    image: toSameOriginImage(latest.gambar),
    link: latest.link,
    name: latest.nama,
  };
}

// Slider banner: posisi "slider" atau alias "banner", limit 5 (default BE)
// Kembalikan max 5 banner terbaru (urutan created_at asc di BE, jadi ambil semua yg dikirim)
export async function fetchBannersByPosisi(posisi: string, limit = 5): Promise<BannerItem[]> {
  const qs = new URLSearchParams({ kategori: posisi, limit: String(limit) });
  const json = await fetchJson<Envelope<BackendBanner[]>>(`/api/banners?${qs.toString()}`);
  if (!Array.isArray(json.data)) return [];
  return json.data.map((b) => ({
    image: toSameOriginImage(b.gambar),
    link: b.link,
    name: b.nama,
  }));
}
