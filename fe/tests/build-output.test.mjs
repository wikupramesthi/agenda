import assert from "node:assert/strict";
import { readFile, readdir, stat } from "node:fs/promises";
import test from "node:test";

const projectRoot = new URL("../", import.meta.url);

test("build emits a publishable static QW Page", async () => {
  const html = await readFile(new URL("dist/index.html", projectRoot), "utf8");
  const assets = await readdir(new URL("dist/assets/", projectRoot));

  // Setelah prerender, #root berisi HTML hasil render (bukan kosong).
  assert.match(html, /<div id="root">/);
  assert.doesNotMatch(html, /\/src\/main\.tsx/);
  assert.ok(assets.some((file) => file.endsWith(".js")));
  assert.ok(assets.some((file) => file.endsWith(".css")));
});

test("production paths are absolute from domain root", async () => {
  const html = await readFile(new URL("dist/index.html", projectRoot), "utf8");

  // Vendor CSS + entry aset harus relatif agar aman di hosting subpath.
  // Cek bagian head/entry saja — konten body hasil render boleh memakai
  // URL absolut (/storage/..., /assets/... dari data API).
  const head = html.slice(0, html.indexOf("<body"));
  assert.match(html, /href="\/vendor\/css\/main\.css"/);
  assert.doesNotMatch(head, /href="\.\/vendor\//);
  const entry = html.match(/<script type="module"[^>]*src="([^"]+)"/);
  assert.ok(entry && (entry[1].startsWith("/") || entry[1].startsWith("http")), `entry script harus absolut, got ${entry && entry[1]}`);
});

test("static fallback and vendor assets are published", async () => {
  // 404.html untuk fallback SPA di hosting statis.
  const fallback = await readFile(new URL("dist/404.html", projectRoot), "utf8");
  assert.match(fallback, /<div id="root"><\/div>/);

  await stat(new URL("dist/vendor/css/main.css", projectRoot));
  const photos = await readdir(new URL("dist/assets/photo-detail/", projectRoot));
  assert.ok(photos.length >= 7, `expected 7 photos, got ${photos.length}`);
});

test("SEO basics are published", async () => {
  const html = await readFile(new URL("dist/index.html", projectRoot), "utf8");

  // Default OG/Twitter untuk crawler + robots terbuka.
  assert.match(html, /property="og:type" content="website"/);
  assert.match(html, /property="og:site_name"/);
  assert.match(html, /name="twitter:card"/);
  await stat(new URL("dist/robots.txt", projectRoot));
});
