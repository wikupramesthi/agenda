import { fetchJson } from "../app/api";
import { formatIdDate } from "./articles";

// Bentuk mentah satu dokumen dari `GET /api/documents`
// (lihat DocumentResource backend).
export type BackendDocument = {
  uuid: string;
  title: string;
  slug: string;
  excerpt: string | null;
  published_at: string | null;
  file: string | null;
  thumbnail: string | null;
  category: string | null;
  category_slug: string | null;
  created_at: string | null;
};

export type BackendDocumentCategory = {
  uuid: string;
  name: string;
  slug: string;
  description: string | null;
};

type Envelope<T> = { status: string; message: string; data: T };

// Dokumen siap tampil di halaman kategori (tampilan seperti `/dokumen`).
export type PublicDocument = {
  uuid: string;
  title: string;
  excerpt: string;
  date: string;
  file: string | null;
  thumbnail: string | null;
  category: string;
  categorySlug: string;
};

// "2021-09-21" -> "Selasa, 21 September 2021". Kosong -> string kosong.
function formatDocDate(value: string | null): string {
  if (!value) return "";
  return formatIdDate(value.includes("T") ? value : `${value} 00:00:00`);
}

// Petakan dokumen backend ke bentuk tampil.
export function mapDocumentToPublic(item: BackendDocument): PublicDocument {
  return {
    uuid: item.uuid,
    title: item.title,
    excerpt: item.excerpt ?? "",
    date: formatDocDate(item.published_at ?? item.created_at),
    file: item.file,
    thumbnail: item.thumbnail,
    category: item.category ?? "Dokumen",
    categorySlug: item.category_slug ?? "",
  };
}

// Pastikan amplop API berisi larik dokumen sebelum dipetakan.
function expectDocumentList(json: Envelope<BackendDocument[]>): BackendDocument[] {
  if (!Array.isArray(json.data)) throw new Error("Format respons dokumen tak dikenal");
  return json.data;
}

// Ambil seluruh dokumen publik (`GET /api/documents`). Berhasil tapi
// kosong -> larik kosong (pemanggil menampilkan status kosong, bukan error).
export async function fetchDocuments(): Promise<PublicDocument[]> {
  const json = await fetchJson<Envelope<BackendDocument[]>>("/api/documents");
  return expectDocumentList(json).map(mapDocumentToPublic);
}

// Ambil dokumen satu kategori PPID via slug kategori backend
// (mis. `ppid-informasi-berkala`). Berhasil tapi kosong -> larik kosong
// (pemanggil menampilkan status kosong, bukan error).
export async function fetchDocumentsByCategory(slug: string): Promise<PublicDocument[]> {
  const json = await fetchJson<Envelope<BackendDocument[]>>(
    `/api/documents/category/${encodeURIComponent(slug)}`,
  );
  return expectDocumentList(json).map(mapDocumentToPublic);
}

// Ambil dokumen terbaru yang memiliki thumbnail (`GET /api/documents`,
// backend sudah mengurutkan paling baru dulu). Dipakai sorotan beranda
// agar kartu selalu bergambar (bukan logo fallback).
export async function fetchLatestDocumentsWithThumbnails(limit = 4): Promise<PublicDocument[]> {
  const all = await fetchDocuments();
  return all.filter((item) => item.thumbnail).slice(0, Math.max(1, limit));
}

// Ambil daftar kategori dokumen aktif (`GET /api/document-categories`).
// Gagal / kosong -> larik kosong (pemanggil fallback ke kategori di data).
export async function fetchDocumentCategories(): Promise<BackendDocumentCategory[]> {
  const json = await fetchJson<Envelope<BackendDocumentCategory[]>>(
    "/api/document-categories",
  );
  if (!Array.isArray(json.data)) throw new Error("Format respons kategori dokumen tak dikenal");
  return json.data;
}
