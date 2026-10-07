import { fetchJson } from "../app/api";
import { htmlToParagraphs } from "./articles";

export type BackendFaq = {
  uuid: string;
  id: string;
  question: string;
  answer: string;
  kategori?: string | null;
  category?: string | null;
  status: string;
  urutan: number;
};

export type Faq = {
  id: string;
  uuid: string;
  question: string;
  answer: string;
  // paragraf aman tanpa HTML injection
  paragraphs: string[];
  kategori: string | null;
  urutan: number;
};

type Envelope<T> = { status: string; message: string; data: T };

function normalizeCategory(raw: unknown): string | null {
  if (typeof raw !== "string") return null;
  const v = raw.trim().toLowerCase();
  if (!v) return null;
  // backend memakai `kategori` enum: informasi-umum, layanan, infrastruktur-pemeliharaan, pengaduan-permohonan, program-kegiatan
  const allowed = new Set(["informasi-umum", "layanan", "infrastruktur-pemeliharaan", "pengaduan-permohonan", "program-kegiatan"]);
  return allowed.has(v) ? v : null;
}

function toParagraphs(answer: string): string[] {
  if (!answer) return [];
  // Jika jawaban mengandung tag HTML, pakai util aman yang sama dengan artikel
  if (/<[^>]+>/.test(answer)) {
    const p = htmlToParagraphs(answer);
    if (p.length > 0) return p;
  }
  // Fallback: pecah baris ganda
  return answer
    .split(/\n+/)
    .map((s) => s.trim())
    .filter((s) => s.length > 0);
}

export async function fetchFaqs(): Promise<Faq[]> {
  const json = await fetchJson<Envelope<BackendFaq[]>>("/api/faqs");
  if (!Array.isArray(json.data)) throw new Error("Format respons FAQ tak dikenal");
  return json.data
    .filter((item) => item.status === "active")
    .sort((a, b) => a.urutan - b.urutan)
    .map((item) => ({
      id: item.uuid ?? item.id ?? String(item.urutan),
      uuid: item.uuid ?? item.id ?? String(item.urutan),
      question: item.question?.trim() ?? "",
      answer: item.answer?.trim() ?? "",
      paragraphs: toParagraphs(item.answer ?? ""),
      kategori: normalizeCategory(item.kategori ?? item.category ?? null),
      urutan: item.urutan ?? 0,
    }))
    .filter((item) => item.question.length > 0 && item.answer.length > 0);
}
