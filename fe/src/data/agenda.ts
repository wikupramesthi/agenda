import { ApiError, fetchJson } from "../app/api";
import { htmlToParagraphs } from "./articles";

export type BackendAgenda = {
  uuid: string;
  judul: string;
  slug: string;
  deskripsi: string | null;
  gambar: string | null;
  tanggal: string | null; // "23-09-2026"
  waktu_mulai: string | null;
  waktu_selesai: string | null;
  lokasi: string | null;
  kapasitas: number | null;
  status: string;
};

type Envelope<T> = { status: string; message: string; data: T };
type PaginatedEnvelope<T> = Envelope<T> & { meta: { current_page: number; per_page: number; total: number; last_page: number; from: number | null; to: number | null } };

function toSameOriginImage(url: string | null): string | null {
  if (!url) return null;
  if (!/^https?:\/\//i.test(url)) return url;
  try {
    const u = new URL(url);
    if (u.pathname.startsWith("/storage/")) return u.pathname;
    return url;
  } catch {
    return url;
  }
}

export type AgendaItem = {
  uuid: string;
  title: string;
  slug: string;
  description: string;
  image: string | null;
  date: string | null; // raw "23-09-2026"
  dateLabel: string; // "23 SEP 2026" atau tanggal asli
  timeStart: string | null;
  timeEnd: string | null;
  location: string | null;
  status: string;
};

function formatAgendaDate(raw: string | null): string {
  if (!raw) return "";
  // raw "23-09-2026" -> "23 SEP 2026"
  const parts = raw.split("-");
  if (parts.length === 3) {
    const months = ["JAN","FEB","MAR","APR","MEI","JUN","JUL","AGU","SEP","OKT","NOV","DES"];
    const d = parts[0].padStart(2,"0");
    const m = parseInt(parts[1],10);
    const y = parts[2];
    if (m >= 1 && m <= 12) return `${d} ${months[m-1]} ${y}`;
  }
  return raw;
}

function mapAgenda(item: BackendAgenda): AgendaItem {
  // deskripsi dari API berisi HTML <p>…<br> — ubah jadi teks polos tanpa tag
  const plain = htmlToParagraphs(item.deskripsi).join(" ");
  return {
    uuid: item.uuid,
    title: item.judul,
    slug: item.slug,
    description: plain,
    image: toSameOriginImage(item.gambar),
    date: item.tanggal,
    dateLabel: formatAgendaDate(item.tanggal),
    timeStart: item.waktu_mulai,
    timeEnd: item.waktu_selesai,
    location: item.lokasi,
    status: item.status,
  };
}

export async function fetchAgendaList(params?: { search?: string; page?: number; perPage?: number }): Promise<{ items: AgendaItem[]; meta: PaginatedEnvelope<BackendAgenda[]>["meta"] }> {
  const qs = new URLSearchParams();
  if (params?.search?.trim()) qs.set("search", params.search.trim().slice(0, 100));
  if (params?.page) qs.set("page", String(params.page));
  if (params?.perPage) qs.set("per_page", String(params.perPage));
  const url = `/api/agenda${qs.toString() ? `?${qs.toString()}` : ""}`;
  const json = await fetchJson<PaginatedEnvelope<BackendAgenda[]>>(url);
  if (!Array.isArray(json.data)) throw new Error("Format agenda tak dikenal");
  return { items: json.data.map(mapAgenda), meta: json.meta };
}

export async function fetchAgendaDetail(slug: string): Promise<AgendaItem & { paragraphs: string[] }> {
  const clean = slug.trim().slice(0, 200);
  const json = await fetchJson<Envelope<BackendAgenda>>(`/api/agenda/${encodeURIComponent(clean)}`);
  if (!json.data || Array.isArray(json.data)) throw new ApiError("Agenda tidak ditemukan", 404);
  const base = mapAgenda(json.data);
  const paragraphs = htmlToParagraphs(json.data.deskripsi);
  return { ...base, paragraphs };
}

export function agendaDetailHref(item: Pick<AgendaItem, "slug">): string {
  return item.slug ? `/agenda/${encodeURIComponent(item.slug)}` : "/agenda";
}
