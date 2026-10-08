/**
 * Perbandingan geometri antara klon (URL 2) dan beranda situs asal (URL 1).
 * Dipakai saat memverifikasi kepersisan tata letak; bukan bagian dari aplikasi.
 *
 *   node tools/compare-layout.mjs [urlKlon]
 */
import { chromium } from 'playwright';

const REF = 'https://umkm.go.id/';
const CLONE = process.argv[2] || 'http://localhost:3000/';

const MARKERS = [
  ['hero', '[class*="h-screen"]'],
  ['berita-section', 'section'],
  ['grid-berita', '[class*="grid-cols"][class*="gap-5"], [class*="xl:grid-cols-4"]'],
  ['gradasi-medos', 'section[class*="to-gold"], section[class*="E3B131"]'],
  ['kalender', '[class*="rounded-t-lg"]'],
  ['footer', 'footer'],
];

const probe = async (page) => {
  const scroll = await page.evaluate(() => document.body.scrollHeight);
  for (let y = 0; y < scroll; y += 600) {
    await page.evaluate((v) => window.scrollTo(0, v), y);
    await page.waitForTimeout(350);
  }
  await page.evaluate(() => window.scrollTo(0, 0));
  await page.waitForTimeout(900);

  return page.evaluate((markers) => {
    const geo = (sel) => {
      const el = document.querySelector(sel);
      if (!el) return null;
      const r = el.getBoundingClientRect();
      return { y: Math.round(r.top + window.scrollY), h: Math.round(r.height) };
    };
    return {
      total: document.body.scrollHeight,
      found: Object.fromEntries(markers.map(([name, sel]) => [name, geo(sel)])),
    };
  }, MARKERS);
};

const browser = await chromium.launch({
  headless: true,
  ...(process.env.CHROME_PATH ? { executablePath: process.env.CHROME_PATH } : {}),
});

const results = {};
for (const url of [REF, CLONE]) {
  const page = await browser.newPage({ viewport: { width: 1440, height: 900 } });
  await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 90_000 });
  await page.waitForTimeout(7000);
  results[url] = await probe(page);
  await page.close();
}
await browser.close();

const [ref, clone] = [results[REF], results[CLONE]];
console.log('total halaman :', ref.total, 'vs', clone.total, 'selisih', clone.total - ref.total, 'px');
for (const [name] of MARKERS) {
  const a = ref.found[name];
  const b = clone.found[name];
  if (!a || !b) {
    console.log(`${name.padEnd(16)}: ref=${a ? 'y' + a.y : '-'} clone=${b ? 'y' + b.y : '-'}  (tidak terukur di salah satu sisi)`);
    continue;
  }
  console.log(`${name.padEnd(16)}: y ${String(a.y).padStart(5)} → ${String(b.y).padStart(5)} (Δ${b.y - a.y}) | h ${String(a.h).padStart(5)} → ${String(b.h).padStart(5)} (Δ${b.h - a.h})`);
}
