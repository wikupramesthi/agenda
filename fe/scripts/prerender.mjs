import { spawn } from "node:child_process";
import { existsSync } from "node:fs";
import { mkdir, writeFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import puppeteer from "puppeteer-core";
import { collectRoutes } from "./generate-sitemap.mjs";

// Prerender statis: render setiap rute di headless Chrome, lalu simpan HTML
// hasilnya ke dist/<route>/index.html. Hasilnya: crawler (Google, FB,
// WhatsApp) melihat <title>, meta, OG, dan konten tanpa harus menjalankan JS.
// React tetap jalan di atas HTML tsb (createRoot) sehingga interaktivitas
// tidak hilang; saat API mati halaman tetap me-render cangkang seperti biasa.

const ROOT = fileURLToPath(new URL("..", import.meta.url));
const DIST = path.join(ROOT, "dist");
const PORT = process.env.PRERENDER_PORT || "4173";
const BASE = `http://127.0.0.1:${PORT}`;

const CHROME_CANDIDATES = [
  process.env.CHROME_PATH,
  "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe",
  "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe",
  "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe",
  "C:\\Program Files\\Microsoft\\Edge\\Application\\msedge.exe",
  "/usr/bin/google-chrome",
  "/usr/bin/chromium",
  "/usr/bin/chromium-browser",
].filter(Boolean);

function findChrome() {
  for (const p of CHROME_CANDIDATES) {
    if (existsSync(p)) return p;
  }
  throw new Error("Chrome/Edge tidak ditemukan. Set env CHROME_PATH.");
}

async function waitForServer(url, timeoutMs = 20_000) {
  const start = Date.now();
  while (Date.now() - start < timeoutMs) {
    try {
      const res = await fetch(url);
      if (res.ok) return;
    } catch {}
    await new Promise((r) => setTimeout(r, 400));
  }
  throw new Error(`Server preview tidak merespons di ${url}`);
}

function filePathForRoute(routePath) {
  const decoded = decodeURIComponent(routePath.split("?")[0]);
  const segments = decoded.split("/").filter(Boolean);
  if (segments.length === 0) return path.join(DIST, "index.html");
  return path.join(DIST, ...segments, "index.html");
}

async function main() {
  if (!existsSync(path.join(DIST, "index.html"))) {
    throw new Error("dist/index.html belum ada. Jalankan `vite build` dulu.");
  }

  const routes = await collectRoutes();
  console.log(`[prerender] ${routes.length} rute akan dirender`);

  // Buang hasil prerender sebelumnya: preview akan menyajikan file stale,
  // React melihat #root sudah berisi HTML lama, fetch judul/meta halaman
  // tidak keburu selesai — hasil tangkapan jadi duplikat halaman lama.
  // Dist/404.html selalu berisi app-shell mentah (disalin SEBELUM prerender),
  // jadi bisa dipakai untuk mengembalikan index.html shell.
  const { copyFile, rm } = await import("node:fs/promises");
  await copyFile(path.join(DIST, "404.html"), path.join(DIST, "index.html"));
  const removed = new Set();
  for (const route of routes) {
    if (route.path === "/") continue;
    const dir = path.dirname(filePathForRoute(route.path));
    if (removed.has(dir) || !dir.startsWith(DIST)) continue;
    removed.add(dir);
    await rm(dir, { recursive: true, force: true });
  }
  const preview = spawn(
    process.execPath,
    [path.join(ROOT, "node_modules", "vite", "bin", "vite.js"), "preview", "--port", PORT, "--strictPort"],
    { cwd: ROOT, stdio: "ignore" },
  );

  let browser;
  try {
    await waitForServer(BASE);
    browser = await puppeteer.launch({
      executablePath: findChrome(),
      headless: "new",
      args: ["--no-sandbox", "--disable-dev-shm-usage", "--window-size=1366,768"],
    });

    const page = await browser.newPage();
    await page.setViewport({ width: 1366, height: 768 });

    let done = 0;
    let failed = 0;
    // Kumpulkan hasil render di memori; tulis ke disk SETELAH semua rute
    // selesai. Kalau ditulis saat loop berjalan, dist/index.html berubah
    // jadi hasil render home, lalu rute berikutnya fallback ke file itu
    // (bukan app-shell) dan tangkapan jadi duplikat home.
    const captures = [];
    for (const route of routes) {
      const url = `${BASE}${route.path}`;
      try {
        await page.goto(url, { waitUntil: "networkidle2", timeout: 30_000 });
        await page
          .waitForFunction(() => document.querySelector("#root")?.children.length > 0, { timeout: 15_000 })
          .catch(() => {});
        // beri waktu efek SEO (title/meta) & data API selesai
        await new Promise((r) => setTimeout(r, 1500));
        // URL yang tertangkap memakai origin preview lokal (canonical, og:url,
        // og:image, JSON-LD, modulepreload). Ganti ke origin publik agar
        // hasil statis benar saat dihosting produksi.
        const PUBLIC_ORIGIN = (
          process.env.PRERENDER_PUBLIC_ORIGIN ||
          process.env.VITE_SITE_URL ||
          "https://dbmsda.bekasikota.go.id"
        ).replace(/\/+$/, "");
        captures.push({ url: route.path, out: filePathForRoute(route.path), html: (await page.content()).replaceAll(BASE, PUBLIC_ORIGIN) });
        done++;
        if (done % 10 === 0) console.log(`[prerender] ${done}/${routes.length}`);
      } catch (e) {
        failed++;
        console.warn(`[prerender] Gagal ${route.path}: ${e.message}`);
      }
    }

    // Slug dengan karakter ilegal di nama file Windows (:, *, dsb)
    // tidak bisa disimpan sebagai direktori — tetap shell SPA.
    for (const c of captures) {
      if (/[<>:"|?*]/.test(decodeURIComponent(c.url))) {
        console.warn(`[prerender] Dilewati (nama path ilegal di Windows): ${c.url}`);
        continue;
      }
      await mkdir(path.dirname(c.out), { recursive: true });
      await writeFile(c.out, c.html, "utf-8");
    }
    console.log(`[prerender] Selesai: ${done} rute ditulis, ${failed} gagal`);
  } finally {
    if (browser) await browser.close();
    preview.kill();
  }
}

main().catch((e) => {
  console.error("[prerender] Failed:", e);
  process.exit(1);
});
