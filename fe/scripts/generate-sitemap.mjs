import { writeFile } from "node:fs/promises";

// Base URL untuk <loc> - prioritas: env SITEMAP_BASE_URL > VITE_SITE_URL > default DBMSDA
const BASE_URL = (process.env.SITEMAP_BASE_URL || process.env.VITE_SITE_URL || "https://dbmsda.bekasikota.go.id").replace(/\/+$/, "");
const TODAY = new Date().toISOString().split("T")[0];

// API base untuk fetch dinamis saat build - jika pakai proxy /api di dev, VITE_API_BASE_URL biasanya kosong.
// Saat build di CI, set VITE_API_BASE_URL=http://127.0.0.1:8000 atau SITEMAP_API_BASE.
const API_BASE = (process.env.SITEMAP_API_BASE || process.env.VITE_API_BASE_URL || "http://127.0.0.1:8000").replace(/\/+$/, "");

const STATIC_ROUTES = [
  { path: "/", changefreq: "daily", priority: 1.0 },
  { path: "/visi-misi", changefreq: "monthly", priority: 0.8 },
  { path: "/informasi-pejabat", changefreq: "monthly", priority: 0.7 },
  { path: "/dokumen", changefreq: "weekly", priority: 0.7 },
  { path: "/berita", changefreq: "daily", priority: 0.9 },
  { path: "/galeri", changefreq: "weekly", priority: 0.7 },
  { path: "/album", changefreq: "weekly", priority: 0.7 },
  { path: "/agenda", changefreq: "weekly", priority: 0.7 },
  { path: "/event", changefreq: "weekly", priority: 0.7 },
  { path: "/pengumuman", changefreq: "weekly", priority: 0.7 },
  { path: "/layanan", changefreq: "monthly", priority: 0.8 },
  { path: "/faq", changefreq: "monthly", priority: 0.6 },
  { path: "/teknis-peil-banjir", changefreq: "yearly", priority: 0.5 },
  { path: "/pemanfaatan-ruang-jalan", changefreq: "yearly", priority: 0.5 },
  { path: "/informasi-berkala", changefreq: "monthly", priority: 0.6 },
  { path: "/informasi-setiap-saat", changefreq: "monthly", priority: 0.6 },
  { path: "/informasi-serta-merta", changefreq: "monthly", priority: 0.6 },
  { path: "/informasi-yang-dikecualikan", changefreq: "yearly", priority: 0.5 },
];

async function fetchJson(url, timeoutMs = 30000) {
  const controller = new AbortController();
  const t = setTimeout(() => controller.abort(), timeoutMs);
  try {
    const res = await fetch(url, { headers: { Accept: "application/json" }, signal: controller.signal });
    clearTimeout(t);
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    const ct = res.headers.get("content-type") || "";
    if (!ct.includes("json")) {
      const txt = (await res.text()).slice(0, 120).replace(/\s+/g, " ");
      throw new Error(`Non-JSON ${ct} - ${txt}`);
    }
    return await res.json();
  } catch (e) {
    // Bedakan timeout/abort vs error lain agar pesannya actionable.
    // `php artisan serve` itu single-thread: request paralel antre lama
    // dan gampang kena abort kalau timeout pendek.
    if (e.name === "AbortError") {
      throw new Error(`timeout ${timeoutMs}ms — backend sibuk/lambat (${url})`);
    }
    throw e;
  } finally {
    clearTimeout(t);
  }
}

async function fetchNewsSlugs() {
  try {
    // /api/articles?limit=50 -> max 50, paginasi FE tidak ada, cukup 50 terbaru untuk sitemap static
    const json = await fetchJson(`${API_BASE}/api/articles?limit=50`);
    if (!Array.isArray(json.data)) return [];
    return json.data
      .filter((a) => a.slug)
      .map((a) => ({
        path: `/berita/${encodeURIComponent(a.slug)}`,
        changefreq: "weekly",
        priority: 0.6,
        lastmod: (a.updated_at || a.created_at)
          ? new Date((a.updated_at || a.created_at).replace(" ", "T")).toISOString().split("T")[0]
          : TODAY,
      }));
  } catch (e) {
    console.warn("[sitemap] Gagal ambil berita:", e.message);
    return [];
  }
}

async function fetchAgendaSlugs() {
  try {
    const json = await fetchJson(`${API_BASE}/api/agenda?per_page=50`);
    const list = Array.isArray(json.data) ? json.data : [];
    return list
      .filter((a) => a.slug)
      .map((a) => ({
        path: `/agenda/${encodeURIComponent(a.slug)}`,
        changefreq: "weekly",
        priority: 0.5,
        lastmod: a.updated_at ? new Date(a.updated_at).toISOString().split("T")[0] : TODAY,
      }));
  } catch (e) {
    console.warn("[sitemap] Gagal ambil agenda:", e.message);
    return [];
  }
}

function buildUrlSet(routes) {
  const urls = routes
    .map(
      (r) => `  <url>
    <loc>${BASE_URL}${r.path}</loc>
    <lastmod>${r.lastmod || TODAY}</lastmod>
    <changefreq>${r.changefreq}</changefreq>
    <priority>${r.priority}</priority>
  </url>`
    )
    .join("\n");
  return `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls}
</urlset>`;
}

function buildRobotsTxt() {
  return `User-agent: *
Allow: /
Sitemap: ${BASE_URL}/sitemap.xml
`;
}

async function fetchAlbumSlugs() {
  try {
    const json = await fetchJson(`${API_BASE}/api/albums?per_page=24`);
    const list = Array.isArray(json.data) ? json.data : [];
    return list
      .filter((a) => a.uuid)
      .map((a) => ({
        path: `/album/${encodeURIComponent(a.uuid)}`,
        changefreq: "monthly",
        priority: 0.5,
        lastmod: a.updated_at ? new Date(a.updated_at).toISOString().split("T")[0] : TODAY,
      }));
  } catch (e) {
    console.warn("[sitemap] Gagal ambil album:", e.message);
    return [];
  }
}

async function fetchPageSlugs() {
  try {
    const json = await fetchJson(`${API_BASE}/api/pages`);
    const list = Array.isArray(json.data) ? json.data : [];
    return list
      .filter((a) => a.slug && a.is_published !== false)
      .map((a) => ({
        path: `/halaman/${encodeURIComponent(a.slug)}`,
        changefreq: "monthly",
        priority: 0.6,
        lastmod: TODAY,
      }));
  } catch (e) {
    console.warn("[sitemap] Gagal ambil halaman:", e.message);
    return [];
  }
}

export async function collectRoutes() {
  // Sekuensial (bukan Promise.all): `php artisan serve` single-thread,
  // request paralel antre dan gampang abort/timeout + kena throttle 60/menit
  // saat digabung dengan beban prerender.
  const newsRoutes = await fetchNewsSlugs();
  const agendaRoutes = await fetchAgendaSlugs();
  const albumRoutes = await fetchAlbumSlugs();
  const pageRoutes = await fetchPageSlugs();
  const allRoutes = [...STATIC_ROUTES, ...newsRoutes, ...agendaRoutes, ...albumRoutes, ...pageRoutes];
  const seen = new Set();
  return allRoutes.filter((r) => {
    if (seen.has(r.path)) return false;
    seen.add(r.path);
    return true;
  });
}

async function main() {
  // collectRoutes() sudah fetch semuanya — jangan fetch dua kali
  // (kode lama: fetch 4x lalu collectRoutes fetch 4x lagi = 8 request).
  const deduped = await collectRoutes();
  const newsCount = deduped.filter((r) => r.path.startsWith("/berita/")).length;
  const agendaCount = deduped.filter((r) => r.path.startsWith("/agenda/")).length;
  const albumCount = deduped.filter((r) => r.path.startsWith("/album/")).length;
  const pageCount = deduped.filter((r) => r.path.startsWith("/halaman/")).length;
  const xml = buildUrlSet(deduped);
  await writeFile(new URL("../dist/sitemap.xml", import.meta.url), xml, "utf-8");
  // robots.txt untuk SEO rapih (discover sitemap)
  try {
    await writeFile(new URL("../dist/robots.txt", import.meta.url), buildRobotsTxt(), "utf-8");
  } catch {}
  console.log(`[sitemap] Generated dist/sitemap.xml with ${deduped.length} URLs (${newsCount} berita, ${agendaCount} agenda, ${albumCount} album, ${pageCount} halaman) -> ${BASE_URL}`);
}

import { pathToFileURL } from "node:url";

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  main().catch((e) => {
    console.error("[sitemap] Failed:", e);
    process.exit(1);
  });
}
