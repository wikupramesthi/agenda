import { asset } from "../app/assets";
import { API_BASE_URL, fetchJson } from "../app/api";
import type { News } from "./siteData";

// Bentuk mentah satu artikel dari `GET /api/articles` (lihat ArticleResource backend).
export type BackendArticleImage = {
  uuid: string;
  image_path: string;
  caption: string | null;
  sort_order: number | null;
};

export type BackendArticle = {
  uuid: string;
  title: string;
  slug: string;
  excerpt: string | null;
  content: string | null;
  tagging: string | null;
  featured_image: string | null;
  images?: BackendArticleImage[] | null;
  is_featured: boolean;
  is_popular: boolean;
  scheduled_at: string | null;
  views: number;
  link: string | null;
  video: string | null;
  author: string | null;
  category: string | null;
  created_at: string;
};

type Envelope<T> = { status: string; message: string; data: T };

const ID_DAYS = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"];
const ID_MONTHS = [
  "Januari", "Februari", "Maret", "April", "Mei", "Juni",
  "Juli", "Agustus", "September", "Oktober", "November", "Desember",
];

// "2020-11-11 06:12:00" -> "Rabu, 11 November 2020". Gagal parse -> string asal.
export function formatIdDate(value: string): string {
  const normalized = value.includes("T") ? value : value.replace(" ", "T");
  const date = new Date(normalized);
  if (Number.isNaN(date.getTime())) return value;
  return `${ID_DAYS[date.getDay()]}, ${date.getDate()} ${ID_MONTHS[date.getMonth()]} ${date.getFullYear()}`;
}

// Host lokal dev — gambar absolut dari host ini ditulis ulang jadi path
// relatif agar same-origin (lewat proxy) dan lolos CSP `img-src 'self'`.
const LOCAL_HOSTNAMES = new Set(["localhost", "127.0.0.1", "[::1]"]);

function apiHost(): string {
  try {
    return API_BASE_URL ? new URL(API_BASE_URL).host : "";
  } catch {
    return "";
  }
}

// `http://127.0.0.1:8000/storage/x.jpg` -> `/storage/x.jpg` (dev/proxy atau
// production satu origin). URL relatif dan host eksternal dibiarkan utuh.
export function toSameOriginImage(url: string | null): string {
  if (!url) return asset("assets/logo.png");
  if (!/^https?:\/\//i.test(url)) return url;
  let parsed: URL;
  try {
    parsed = new URL(url);
  } catch {
    return url;
  }
  const host = apiHost();
  const sameApi = host ? parsed.host === host : LOCAL_HOSTNAMES.has(parsed.hostname);
  if (sameApi) return `${parsed.pathname}${parsed.search}${parsed.hash}`;
  return url;
}

// "2020-11-11 06:12:00" (WIB) -> "2020-11-11T06:12:00+07:00".
// Sudah ISO (berakhir Z/offset) dibiarkan utuh.
function toIsoDateTime(value: string): string {
  const normalized = value.includes("T") ? value : value.replace(" ", "T");
  return /([+-]\d{2}:?\d{2}|Z)$/.test(normalized) ? normalized : `${normalized}+07:00`;
}

// Petakan artikel backend ke bentuk `News` yang dipakai komponen.
export function mapArticleToNews(article: BackendArticle): News {
  return {
    title: article.title,
    excerpt: article.excerpt ?? "",
    image: toSameOriginImage(article.featured_image),
    date: formatIdDate(article.created_at),
    dateTime: toIsoDateTime(article.created_at),
    category: article.category ?? "Berita",
    slug: article.slug,
  };
}

// Slug kategori untuk headline beranda. Saat kategori lain (kegiatan,
// pembangunan, ...) mulai terisi, endpoint umum di semua artikel tetap
// utuh — seksi beranda sengaja dikunci ke kategori berita saja.
export const NEWS_CATEGORY_SLUG = "berita";
export const KEGIATAN_CATEGORY_SLUG = "kegiatan";

// Urutkan artikel mentah paling baru dulu (berdasar `created_at`).
function sortNewestFirst(list: BackendArticle[]): BackendArticle[] {
  return [...list].sort((a, b) => (a.created_at < b.created_at ? 1 : a.created_at > b.created_at ? -1 : 0));
}

// Pastikan amplop API berisi larik artikel sebelum dipetakan.
function expectArticleList(json: Envelope<BackendArticle[]>): BackendArticle[] {
  if (!Array.isArray(json.data)) throw new Error("Format respons API tak dikenal");
  return json.data;
}

// Ambil artikel per kategori (slug), urut paling baru dulu.
// Tanpa `limit` seluruh artikel dikembalikan (untuk daftar + paginasi lokal).
export async function fetchArticlesByCategory(slug: string, limit?: number): Promise<News[]> {
  const base = `/api/articles/category/${encodeURIComponent(slug)}`;
  const json = await fetchJson<Envelope<BackendArticle[]>>(
    limit && limit > 0 ? `${base}?limit=${limit}` : base,
  );
  return sortNewestFirst(expectArticleList(json)).map(mapArticleToNews);
}

// Ambil seluruh artikel (semua kategori), urut paling baru dulu.
// Dipakai halaman daftar berita agar bisa difilter per kategori.
export async function fetchAllArticles(limit?: number): Promise<News[]> {
  const json = await fetchJson<Envelope<BackendArticle[]>>(
    limit && limit > 0 ? `/api/articles?limit=${limit}` : "/api/articles",
  );
  return sortNewestFirst(expectArticleList(json)).map(mapArticleToNews);
}

// Kategori dari `GET /api/categories` (lihat CategoryResource backend).
export type Category = {
  uuid: string;
  name: string;
  slug: string;
};

export async function fetchCategories(): Promise<Category[]> {
  const json = await fetchJson<Envelope<Category[]>>("/api/categories");
  if (!Array.isArray(json.data)) throw new Error("Format respons kategori tak dikenal");
  return json.data;
}

// Ambil 8 berita terbaru kategori berita untuk headline beranda
// (5 slider + 3 grid).
export async function fetchLatestArticles(): Promise<News[]> {
  return fetchArticlesByCategory(NEWS_CATEGORY_SLUG, 8);
}

// Ambil berita populer (`is_popular`) untuk seksi detail.
export async function fetchPopularArticles(limit = 6): Promise<News[]> {
  const json = await fetchJson<Envelope<BackendArticle[]>>(
    `/api/articles?popular=1&limit=${limit}`,
  );
  return sortNewestFirst(expectArticleList(json)).map(mapArticleToNews);
}

export type Headlines = { slider: News[]; grid: News[] };

// Bagi daftar urut-terbaru: 5 untuk slider besar, 3 berikutnya untuk grid
// bawah — tanpa duplikat antara keduanya.
export function splitHeadlines(items: News[]): Headlines {
  const seen = new Set<string>();
  const unique = items.filter((item) => {
    if (seen.has(item.title)) return false;
    seen.add(item.title);
    return true;
  });
  return { slider: unique.slice(0, 5), grid: unique.slice(5, 8) };
}

// Tautan halaman detail `/berita/{slug}`; tanpa slug kembali ke daftar.
export function newsDetailHref(item: News): string {
  return item.slug ? `/berita/${encodeURIComponent(item.slug)}` : "/berita";
}

// Konten backend berupa HTML admin. Ubah jadi paragraf teks polos agar
// aman dirender tanpa `dangerouslySetInnerHTML` (bebas HTML injection).
export function htmlToParagraphs(html: string | null): string[] {
  if (!html) return [];
  const text = html
    .replace(/<br\s*\/?>/gi, "\n")
    .replace(/<\/p\s*>/gi, "\n\n")
    .replace(/<\/h[1-6]\s*>/gi, "\n\n")
    .replace(/<\/li\s*>/gi, "\n")
    .replace(/<[^>]*>/g, "")
    .replace(/&nbsp;/gi, " ")
    .replace(/&amp;/g, "&")
    .replace(/&lt;/g, "<")
    .replace(/&gt;/g, ">")
    .replace(/&quot;/g, '"')
    .replace(/&#39;|&apos;/g, "'");
  return text
    .split(/\n+/)
    .map((line) => line.replace(/\s+/g, " ").trim())
    .filter((line) => line.length > 0);
}

export type ArticleDetail = News & {
  paragraphs: string[];
  author: string;
  views: number;
  tags: string[];
  gallery: string[];
};

// Kolom `tagging` API berupa string koma ("taman, lampu, bekasi").
// Uraikan jadi daftar tag bersih untuk ditampilkan (tanpa tautan).
function parseTags(value: string | null): string[] {
  if (!value) return [];
  return value
    .split(",")
    .map((tag) => tag.trim())
    .filter((tag) => tag.length > 0)
    .slice(0, 10);
}

// Ambil satu artikel via `GET /api/articles/{slug}`.
// Melempar Error/ApiError (404 bila slug tak dikenal).
export async function fetchArticleDetail(slug: string): Promise<ArticleDetail> {
  const json = await fetchJson<Envelope<BackendArticle | null>>(
    `/api/articles/${encodeURIComponent(slug)}`,
  );
  if (!json.data || Array.isArray(json.data)) throw new Error("Artikel tidak ditemukan");
  const base = mapArticleToNews(json.data);
  const slider = [...(json.data.images ?? [])].sort(
    (a, b) => (a.sort_order ?? 0) - (b.sort_order ?? 0),
  );
  const gallery = [
    base.image,
    ...slider.map((item) => toSameOriginImage(item.image_path)),
  ].filter((src, index, list) => src.length > 0 && list.indexOf(src) === index);
  return {
    ...base,
    paragraphs: htmlToParagraphs(json.data.content),
    author: json.data.author ?? "Admin",
    views: json.data.views ?? 0,
    tags: parseTags(json.data.tagging),
    gallery: gallery.length > 0 ? gallery : [base.image],
  };
}
