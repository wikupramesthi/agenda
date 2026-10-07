import { fetchJson } from "../app/api";
import { toSameOriginImage } from "./articles";

export type AlbumFoto = {
  uuid: string;
  nama: string;
  gambar: string;
  deskripsi: string | null;
};

export type Album = {
  uuid: string;
  nama: string;
  deskripsi: string | null;
  status: string;
  foto_count: number;
  cover_uuid: string | null;
  cover_url: string | null;
  cover_nama: string | null;
  fotos: AlbumFoto[];
  created_at: string | null;
  updated_at: string | null;
};

type Envelope<T> = { status: string; message: string; data: T };
type EnvelopePaginated<T> = Envelope<T> & {
  meta?: { current_page: number; per_page: number; total: number; last_page: number };
};

function normalizeFoto(f: AlbumFoto): AlbumFoto {
  return { ...f, gambar: toSameOriginImage(f.gambar) };
}

function normalizeAlbum(a: Album): Album {
  return {
    ...a,
    cover_url: a.cover_url ? toSameOriginImage(a.cover_url) : null,
    fotos: Array.isArray(a.fotos) ? a.fotos.map(normalizeFoto) : [],
  };
}

export async function fetchAlbums(params?: { search?: string; page?: number; perPage?: number }): Promise<{
  items: Album[];
  meta: { current_page: number; per_page: number; total: number; last_page: number };
}> {
  const qs = new URLSearchParams();
  if (params?.search?.trim()) qs.set("search", params.search.trim());
  qs.set("per_page", String(params?.perPage ?? 9));
  if (params?.page) qs.set("page", String(params.page));
  const json = await fetchJson<EnvelopePaginated<Album[]>>(`/api/albums?${qs.toString()}`);
  if (!Array.isArray(json.data)) throw new Error("Format album tak dikenal");
  return {
    items: json.data.map(normalizeAlbum),
    meta: json.meta ?? { current_page: 1, per_page: 9, total: json.data.length, last_page: 1 },
  };
}

export async function fetchAlbumDetail(uuid: string): Promise<Album> {
  const json = await fetchJson<Envelope<Album>>(`/api/albums/${encodeURIComponent(uuid)}`);
  if (!json.data || Array.isArray(json.data)) throw new Error("Album tidak ditemukan");
  return normalizeAlbum(json.data);
}

export function albumHref(a: Pick<Album, "uuid">): string {
  return `/album/${encodeURIComponent(a.uuid)}`;
}
