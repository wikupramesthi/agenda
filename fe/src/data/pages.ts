import { fetchJson } from "../app/api";
import { htmlToParagraphs, toSameOriginImage } from "./articles";

// Bentuk mentah satu halaman dari `GET /api/pages` (lihat PageResource backend).
export type BackendPage = {
  uuid: string;
  title: string;
  slug: string;
  excerpt: string | null;
  content: string | null;
  featured_image: string | null;
  is_published: boolean;
  published_at: string | null;
  has_sidebar: boolean;
};

export type StaticPageData = {
  uuid: string;
  title: string;
  slug: string;
  excerpt: string;
  paragraphs: string[];
  blocks: PageBlock[];
  image: string | null;
  publishedAt: string | null;
  hasSidebar: boolean;
};

// ---- Blok konten aman (tanpa dangerouslySetInnerHTML) ----
// HTML admin hanya dipetakan ke struktur teks: heading, paragraf (dengan
// segmen tebal/miring), daftar, dan kutipan. Atribut/style/class asing
// selalu dibuang sehingga bebas HTML injection.

export type InlineSegment = { text: string; bold: boolean; italic: boolean };

export type PageBlock =
  | { kind: "heading"; level: 2 | 3; text: string }
  | { kind: "paragraph"; segments: InlineSegment[] }
  | { kind: "list"; ordered: boolean; items: InlineSegment[][] }
  | { kind: "quote"; segments: InlineSegment[] };

function decodeEntities(value: string): string {
  return value
    .replace(/&nbsp;/gi, " ")
    .replace(/&amp;/g, "&")
    .replace(/&lt;/g, "<")
    .replace(/&gt;/g, ">")
    .replace(/&quot;/g, '"')
    .replace(/&#39;|&apos;/g, "'")
    .replace(/&#(\d+);/g, (_, code: string) => {
      const point = Number.parseInt(code, 10);
      return Number.isFinite(point) ? String.fromCodePoint(point) : "";
    });
}

function cleanText(html: string): string {
  return decodeEntities(html.replace(/<[^>]*>/g, " ")).replace(/\s+/g, " ").trim();
}

// Uraikan inline `<strong>/<b>/<em>/<i>` jadi segmen; tag lain dibuang.
function parseInline(html: string): InlineSegment[] {
  const segments: InlineSegment[] = [];
  const token = /<(strong|b|em|i)(\s[^>]*)?>|<\/\s*(strong|b|em|i)\s*>/gi;
  let bold = 0;
  let italic = 0;
  let last = 0;
  let match: RegExpExecArray | null;
  const push = (raw: string) => {
    // Buang semua tag sisa (span/style/font/...) — token strong/em sudah
    // dikonsumsi regex di atas. Urutan: strip tag dulu, baru decode entitas
    // agar `&lt;` tampil sebagai teks "<" bukan dimakan sebagai tag.
    const text = decodeEntities(raw.replace(/<[^>]*>/g, "")).replace(/\s+/g, " ");
    if (text.trim().length === 0) return;
    segments.push({ text, bold: bold > 0, italic: italic > 0 });
  };
  while ((match = token.exec(html)) !== null) {
    push(html.slice(last, match.index));
    const tag = (match[1] ?? match[3] ?? "").toLowerCase();
    const closing = !match[1];
    if (tag === "strong" || tag === "b") bold = Math.max(0, bold + (closing ? -1 : 1));
    else italic = Math.max(0, italic + (closing ? -1 : 1));
    last = match.index + match[0].length;
  }
  push(html.slice(last));
  return segments;
}

const hasVisibleText = (segments: InlineSegment[]): boolean =>
  segments.some((segment) => segment.text.trim().length > 0);

// HTML admin -> daftar blok aman untuk dirender sebagai elemen React.
export function htmlToBlocks(html: string | null): PageBlock[] {
  if (!html) return [];
  const source = html.replace(/<br\s*\/?>/gi, " ");
  const blocks: PageBlock[] = [];
  const blockRe = /<(h[1-4]|p|blockquote|ul|ol)[^>]*>([\s\S]*?)<\/\1>/gi;
  let last = 0;
  let match: RegExpExecArray | null;

  const pushStrayText = (raw: string) => {
    const text = cleanText(raw);
    if (!text) return;
    text
      .split(/(?<=[.!?])\s+(?=[A-Z0-9"])/)
      .map((line) => line.trim())
      .filter(Boolean)
      .forEach((line) =>
        blocks.push({ kind: "paragraph", segments: [{ text: line, bold: false, italic: false }] }),
      );
  };

  while ((match = blockRe.exec(source)) !== null) {
    pushStrayText(source.slice(last, match.index));
    const tag = match[1].toLowerCase();
    const inner = match[2] ?? "";
    if (tag.startsWith("h")) {
      const text = cleanText(inner).slice(0, 200);
      // Abaikan heading yang sama persis berurutan (mis. duplikat sr-only).
      const prev = blocks[blocks.length - 1];
      if (text && !(prev?.kind === "heading" && prev.text === text)) {
        blocks.push({ kind: "heading", level: tag === "h3" || tag === "h4" ? 3 : 2, text });
      }
    } else if (tag === "blockquote") {
      const segments = parseInline(inner);
      if (hasVisibleText(segments)) blocks.push({ kind: "quote", segments });
    } else if (tag === "ul" || tag === "ol") {
      const items: InlineSegment[][] = [];
      const itemRe = /<li[^>]*>([\s\S]*?)<\/li>/gi;
      let item: RegExpExecArray | null;
      while ((item = itemRe.exec(inner)) !== null) {
        const segments = parseInline(item[1] ?? "");
        if (hasVisibleText(segments)) items.push(segments);
      }
      if (items.length > 0) blocks.push({ kind: "list", ordered: tag === "ol", items: items.slice(0, 50) });
    } else {
      const segments = parseInline(inner);
      if (hasVisibleText(segments)) blocks.push({ kind: "paragraph", segments });
    }
    last = match.index + match[0].length;
  }
  pushStrayText(source.slice(last));
  return blocks;
}

type Envelope<T> = { status: string; message: string; data: T };

function normalizePage(page: BackendPage): StaticPageData {
  const paragraphs = htmlToParagraphs(page.content);
  return {
    uuid: page.uuid,
    title: page.title,
    slug: page.slug,
    excerpt: page.excerpt ?? "",
    paragraphs,
    blocks: htmlToBlocks(page.content),
    image: page.featured_image ? toSameOriginImage(page.featured_image) : null,
    publishedAt: page.published_at,
    hasSidebar: page.has_sidebar,
  };
}

// Ambil seluruh halaman statis (`GET /api/pages`).
// Backend mengembalikan semua baris tanpa filter publikasi, jadi saring
// di sini agar draf tak bocor ke navigasi publik.
export async function fetchPages(): Promise<StaticPageData[]> {
  const json = await fetchJson<Envelope<BackendPage[]>>("/api/pages");
  if (!Array.isArray(json.data)) throw new Error("Format respons halaman tak dikenal");
  return json.data.filter((page) => page.is_published).map(normalizePage);
}

// Ambil satu halaman via `GET /api/pages/{slug}`.
// Melempar Error/ApiError (404 bila slug tak dikenal / belum terbit).
export async function fetchPageDetail(slug: string): Promise<StaticPageData> {
  const clean = slug.trim().slice(0, 200);
  const json = await fetchJson<Envelope<BackendPage | null>>(
    `/api/pages/${encodeURIComponent(clean)}`,
  );
  if (!json.data || Array.isArray(json.data)) throw new Error("Halaman tidak ditemukan");
  return normalizePage(json.data);
}

// Tautan halaman detail `/halaman/{slug}`; tanpa slug kembali ke beranda.
export function staticPageHref(page: Pick<StaticPageData, "slug">): string {
  return page.slug ? `/halaman/${encodeURIComponent(page.slug)}` : "/";
}
