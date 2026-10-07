import { ApiError, fetchJson } from "../app/api";
import { htmlToParagraphs } from "./articles";

export type BackendOfficial = {
  uuid: string;
  name: string;
  position: string;
  departments: string[];
  unit_kerja: string | null;
  avatar: string | null;
  avatar_url: string | null;
  urutan_pejabat: number | null;
  riwayat?: string | null;
  nip?: string | null;
  email?: string | null;
};

type Envelope<T> = { status: string; message: string; data: T };

function toSameOriginImage(url: string | null): string | null {
  if (!url) return null;
  if (!/^https?:\/\//i.test(url)) return url;
  try {
    const parsed = new URL(url);
    // same-origin avatar via /storage, biarkan relative jika sudah /storage
    if (parsed.pathname.startsWith("/storage/")) return parsed.pathname;
    return url;
  } catch {
    return url;
  }
}

export type Official = {
  uuid: string;
  name: string;
  role: string;
  image: string | null;
};

function mapOfficial(item: BackendOfficial): Official {
  const raw = item.avatar_url || (item.avatar ? `/storage/${String(item.avatar).replace(/^\/+/, "")}` : null);
  const img = raw ? toSameOriginImage(raw) : null;
  // fallback ikon inisial bila tanpa foto — image null nanti dirender placeholder
  return {
    uuid: item.uuid,
    name: item.name,
    role: item.position || "Pejabat DBMSDA",
    image: img,
  };
}

export async function fetchOfficials(): Promise<Official[]> {
  const json = await fetchJson<Envelope<BackendOfficial[]>>("/api/officials");
  if (!Array.isArray(json.data)) throw new Error("Format respons pejabat tak dikenal");
  return json.data.map(mapOfficial);
}

// helper fallback bila API kosong/error — jangan tampilkan data palsu, hanya empty
export function officialImageOrNull(official: Official): string | null {
  return official.image && official.image.trim().length > 0 ? official.image : null;
}

export type OfficialDetail = Official & {
  riwayat: string | null;
  paragraphs: string[];
  nip: string | null;
  email: string | null;
  departments: string[];
};

export async function fetchOfficialDetail(uuid: string): Promise<OfficialDetail> {
  const clean = uuid.trim().slice(0, 100);
  const json = await fetchJson<Envelope<BackendOfficial>>(`/api/officials/${encodeURIComponent(clean)}`);
  if (!json.data || Array.isArray(json.data)) throw new ApiError("Pejabat tidak ditemukan", 404);
  const base = mapOfficial(json.data);
  return {
    ...base,
    riwayat: json.data.riwayat ?? null,
    paragraphs: htmlToParagraphs(json.data.riwayat ?? null),
    nip: json.data.nip && json.data.nip !== "aaa" ? json.data.nip : null,
    email: json.data.email ?? null,
    departments: json.data.departments ?? [],
  };
}

export function officialDetailHref(official: Pick<Official, "uuid">): string {
  return official.uuid ? `/informasi-pejabat/${encodeURIComponent(official.uuid)}` : "/informasi-pejabat";
}
