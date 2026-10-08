#!/usr/bin/env node
/**
 * sync-umkm.mjs — ambil konten beranda umkm.go.id + semua medianya, lalu tulis
 * sebagai modul data siap impor untuk aplikasi React ini.
 *
 *   node scripts/sync-umkm.mjs                 # tulis src/data/beranda.generated.ts + public/uploads
 *   node scripts/sync-umkm.mjs --no-media      # hanya data teks
 *   node scripts/sync-umkm.mjs --dry-run       # cetak ringkasan, tidak menulis apa pun
 *   node scripts/sync-umkm.mjs --out /path/repo
 *
 * Kenapa lewat browser yang dirender, bukan API-nya langsung: endpoint Strapi
 * (175utx.umkm.go.id/api/*) menolak permintaan lintas origin (HTTP 403), sedangkan
 * DOM hasil render sudah memuat seluruh data yang tampil di beranda.
 *
 * Butuh Playwright + browsernya:
 *   npm i -D playwright && npx playwright install chromium
 */

import { mkdir, readFile, writeFile } from 'node:fs/promises';
import { existsSync } from 'node:fs';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const SITE = 'https://umkm.go.id';
const UA =
  'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36';

const args = process.argv.slice(2);
const has = (f) => args.includes(f);
const opt = (f, d) => {
  const i = args.indexOf(f);
  return i >= 0 && args[i + 1] ? args[i + 1] : d;
};

const OUT = resolve(opt('--out', ROOT));
const CONFIG = {
  dataFile: join(OUT, 'src', 'data', 'beranda.generated.ts'),
  mediaDir: join(OUT, 'public', 'uploads'),
  iconDir: join(OUT, 'public', 'image'),
  sourceMap: join(OUT, 'src', 'data', 'beranda.source.json'),
  dryRun: has('--dry-run'),
  withMedia: !has('--no-media'),
};

const log = (...a) => console.log('[sync-umkm]', ...a);
const die = (msg, hint) => {
  console.error(`[sync-umkm] GAGAL: ${msg}`);
  if (hint) console.error(`[sync-umkm] petunjuk: ${hint}`);
  process.exit(1);
};

// ---------------------------------------------------------------- browser ---
async function openPage() {
  // Nama modul bisa ditimpa lewat env, mis. saat Playwright terpasang global:
  //   PLAYWRIGHT_MODULE=/usr/lib/node_modules/playwright node scripts/sync-umkm.mjs
  const mod = process.env.PLAYWRIGHT_MODULE || 'playwright';
  let chromium;
  try {
    ({ chromium } = await import(mod));
  } catch (e) {
    die(`modul "${mod}" tidak ketemu: ${e.message}`, 'jalankan: npm i -D playwright && npx playwright install chromium');
  }
  const candidates = [
    process.env.CHROME_PATH,
    process.env.CHROMIUM_PATH,
    null, // biarkan Playwright memakai browser bawaannya sendiri
    '/usr/bin/google-chrome',
    '/usr/bin/chromium',
    '/usr/bin/chromium-browser',
  ].filter((p) => p === null || existsSync(p));

  let browser = null;
  let lastError = null;
  for (const executablePath of candidates) {
    try {
      browser = await chromium.launch({ headless: true, ...(executablePath ? { executablePath } : {}) });
      break;
    } catch (e) {
      lastError = e;
    }
  }
  if (!browser) {
    die(
      `browser tidak bisa dijalankan: ${lastError?.message?.split('\n')[0]}`,
      'jalankan `npx playwright install chromium`, atau tunjuk browser yang ada: CHROME_PATH=/usr/bin/chromium node scripts/sync-umkm.mjs',
    );
  }
  const page = await browser.newPage({ userAgent: UA, viewport: { width: 1440, height: 900 } });
  return { browser, page };
}

/** Helper yang di-inject ke dalam page.evaluate (harus string-safe). */
const HELPERS = `
  const real = (u) => {
    if (!u) return null;
    if (u.indexOf('/_next/image?url=') >= 0) {
      const q = decodeURIComponent(u.split('url=')[1].split('&')[0]);
      return new URL(q, location.origin).href;
    }
    try { return new URL(u, location.origin).href; } catch (e) { return u; }
  };
  const imgOf = (el) => { const i = el && el.querySelector('img'); return i ? real(i.getAttribute('src')) : null; };
  const bgOf = (el) => {
    const bi = el ? getComputedStyle(el).backgroundImage : '';
    const m = (bi || '').match(/url\\("?([^"')]+)"?\\)/);
    return m ? real(m[1]) : null;
  };
  const textOf = (el, sel) => { const t = el && el.querySelector(sel); return t ? (t.innerText || '').trim() : ''; };
  const linesOf = (el) => (el ? el.innerText || '' : '').split('\\n').map((s) => s.trim()).filter(Boolean);
  const slides = (root) => (root ? Array.prototype.slice.call(root.querySelectorAll('.swiper-slide')) : []);
  const uniq = (arr) => Array.from(new Set(arr.filter(Boolean)));
  const byText = (txt, sel) => Array.prototype.slice.call(document.querySelectorAll(sel || '*'))
    .find((e) => (e.innerText || '').trim().toLowerCase() === txt.toLowerCase() && e.children.length === 0);
  const DATE_RE = /^[0-9]{1,2}\\s[A-Za-z]{3,9}\\s[0-9]{4}$/;
`;

/** Fungsi utama pembaca DOM beranda (dipakai lewat page.evaluate). */
const READ_HOME = `(function(){ ${HELPERS}
  const out = {};

  const heroWrap = document.querySelector('[class*="h-screen"] .swiper') || document.querySelector('.swiper');
  out.hero = slides(heroWrap).map((s) => ({
    href: (s.querySelector('a') || {}).href || null,
    title: textOf(s, 'h2,h1,[class*="text-5xl"],[class*="text-3xl"]'),
    image: imgOf(s) || bgOf(s),
  })).filter((x) => x.title && x.image);

  const flash = Array.prototype.slice.call(document.querySelectorAll('div')).find((d) => {
    const c = typeof d.className === 'string' ? d.className : '';
    return c.indexOf('h-12') >= 0 && c.indexOf('overflow-hidden') >= 0;
  });
  out.newsFlash = flash
    ? uniq(
        (flash.innerText || '')
          .split('|')
          .map((t) => t.trim())
          .filter((t) => t.length > 12),
      )
        .map((t) => t.replace(/^news flash\s*/i, '').trim())
        .filter((t) => t.length > 12)
        .map((title) => ({ title, href: null }))
    : [];

  const s1 = document.querySelector('.section1');
  if (s1) {
    const s = s1.querySelector('.swiper-slide') || s1;
    const kLines = linesOf(s).filter((l) => l !== 'Lihat Lainnya');
    out.kenali = {
      title: textOf(s, 'h2,h3') || kLines[0] || '',
      excerpt: textOf(s, 'p') || kLines.filter((l) => l !== kLines[0]).sort((a, b) => b.length - a.length)[0] || '',
      href: (s.querySelector('a') || {}).href || null,
      image: imgOf(s) || bgOf(s),
    };
  }

  const bgDeep = (root) => {
    if (!root) return null;
    const list = [root].concat(Array.prototype.slice.call(root.querySelectorAll('*')));
    for (const el of list) { const u = bgOf(el); if (u) return u; }
    return imgOf(root);
  };

  const s2 = document.querySelector('.section2');
  out.kebijakan = slides(s2).map((s) => ({
    title: textOf(s, 'h2,h3') || linesOf(s)[0] || '',
    excerpt:
      textOf(s, 'p') ||
      linesOf(s)
        .filter((l) => l.length > 40 && l !== 'Selengkapnya')
        .sort((a, b) => b.length - a.length)[0] ||
      '',
    href: (s.querySelector('a') || {}).href || null,
    image: imgOf(s) || bgOf(s) || bgDeep(s),
  })).filter((x, i, arr) => x.title && arr.findIndex((y) => y.title === x.title) === i);

  const tabRow = byText('Siaran Pers') ? byText('Siaran Pers').parentElement : null;
  out.tabLabels = tabRow
    ? uniq(Array.prototype.slice.call(tabRow.querySelectorAll('button,a,span')).map((b) => (b.innerText || '').trim()))
        .filter((t) => /^[A-Z][a-z]/.test(t) && t.length < 24)
    : [];

  const situs = byText('Situs Terkait');
  if (situs) {
    const box = situs.closest('div[class*="flex"]') ? situs.parentElement.parentElement : document;
    const logos = [];
    Array.prototype.slice.call(box.querySelectorAll('a[href]')).forEach((a) => {
      const im = a.querySelector('img');
      if (!im) return;
      const src = real(im.getAttribute('src'));
      if (!src || src.indexOf('/uploads/') < 0) return;
      if (logos.some((x) => x.href === a.href)) return;
      logos.push({ name: (a.getAttribute('title') || im.alt || '').trim(), href: a.href, image: src });
    });
    out.situs = logos;
    out.situsLainnya = (Array.prototype.slice.call(box.querySelectorAll('a[href],button')).find((b) =>
      (b.innerText || '').trim() === 'Lihat Lainnya') || {}).href || null;
  }

  const s3 = document.querySelector('.section3');
  out.banners = slides(s3).map((s) => {
    const a = s.querySelector('a[href]') || s;
    return {
      name: (a.getAttribute('aria-label') || a.title || '').trim(),
      href: a.href || null,
      image: bgDeep(s),
    };
  }).filter((x) => !!x.image);

  const emag = Array.prototype.slice.call(document.querySelectorAll('img')).find((i) => /e.?mag/i.test((i.getAttribute('src') || '') + (i.alt || '')));
  out.emag = emag
    ? { image: real(emag.getAttribute('src')), href: (emag.closest('a[href]') || {}).href || null, alt: emag.alt || '' }
    : null;

  const agenda = byText('Agenda UMKM');
  if (agenda) {
    const box = agenda.parentElement;
    out.agenda = {
      message: (linesOf(box).find((l) => /tidak ditemukan/i.test(l)) || '').trim(),
      items: Array.prototype.slice.call(box.querySelectorAll('a[href]'))
        .map((a) => ({ title: (a.innerText || '').trim(), href: a.href }))
        .filter((x) => x.title && x.title !== 'Agenda UMKM' && x.href.indexOf('komdigi.go.id') < 0),
    };
  }

  const aside = document.querySelector('aside, nav');
  const drawer = Array.prototype.slice.call(document.querySelectorAll('nav')).find((n) => /Pengumuman/.test(n.innerText || ''));
  out.menu = drawer
    ? Array.prototype.slice.call(drawer.querySelectorAll('a[href]')).map((a) => ({
        label: (a.innerText || '').trim(),
        href: a.href,
      })).filter((x) => x.label)
    : [];

  const foot = document.querySelector('footer');
  out.footer = foot
    ? {
        lines: linesOf(foot),
        logo: imgOf(foot),
        social: Array.prototype.slice.call(foot.querySelectorAll('a[href]')).map((a) => ({
          label: (a.getAttribute('aria-label') || a.innerText || (a.querySelector('img') || {}).alt || '').trim(),
          href: a.href,
          icon: imgOf(a),
        })).filter((x) => x.href),
      }
    : { lines: [], logo: null, social: [] };

  out.pageTitle = document.title;
  return out;
})()`;

/** Baca kartu berita pada tab yang sedang aktif. */
const READ_CARDS = `(function(){ ${HELPERS}
  const labelEl = byText('Siaran Pers') || byText('Info Tips') || byText('Warta UMKM');
  const scope = labelEl ? labelEl.closest('section') || document : document;
  const grids = Array.prototype.slice.call(scope.querySelectorAll('div[class*="grid-cols"]'));
  const grid = grids.length ? grids[grids.length - 1] : scope;
  const seen = [];
  const cards = [];
  Array.prototype.slice.call(grid.querySelectorAll('a'))
    .filter((a) => (a.innerText || '').trim() === 'Selengkapnya')
    .forEach((a) => {
      let box = a.parentElement;
      while (box && !box.querySelector('img') && box.parentElement) box = box.parentElement;
      if (!box || box.tagName === 'BODY' || box.tagName === 'MAIN' || seen.indexOf(box) >= 0) return;
      seen.push(box);
      const ls = linesOf(box);
      cards.push({
        href: a.href,
        title: textOf(box, 'h3,h2') || ls.slice().sort((x, y) => y.length - x.length)[0] || '',
        author: (ls.find((l) => /^Oleh /i.test(l)) || '').replace(/^Oleh\\s+/i, ''),
        date: ls.find((l) => DATE_RE.test(l)) || '',
        image: imgOf(box),
      });
    });
  return cards.filter((x) => x.title && x.image);
})()`;

/** Label tab berita yang sedang aktif (dipakai agar tidak klik tab aktif). */
const READ_ACTIVE_TAB = `(function(){ ${HELPERS}
  const el = ['Siaran Pers', 'Info Tips', 'Warta UMKM'].map((t) => byText(t, 'button,div,span,a')).find(Boolean);
  if (!el) return '';
  const row = el.parentElement;
  const act = Array.prototype.slice.call(row.querySelectorAll('button,div,a,span')).find((b) =>
    /cust-orange/.test(typeof b.className === 'string' ? b.className : ''));
  return act ? (act.innerText || '').trim() : (el.innerText || '').trim();
})()`;

/**_muat beranda, gulirkan supaya lazy-load jalan, lalu kumpulkan per tab. */
async function collect() {
  const { browser, page } = await openPage();
  const failed = [];
  page.on('requestfailed', (r) => failed.push(r.url()));

  log('membuka', SITE);
  await page.goto(SITE, { waitUntil: 'domcontentloaded', timeout: 90_000 });
  await page.waitForTimeout(6000);

  const max = await page.evaluate(() => document.body.scrollHeight);
  for (let y = 0; y < max; y += 650) {
    await page.evaluate((v) => window.scrollTo(0, v), y);
    await page.waitForTimeout(700);
  }
  await page.evaluate(() => window.scrollTo(0, 0));
  await page.waitForTimeout(1500);

  const home = await page.evaluate(READ_HOME);

  const tabs = home.tabLabels.length ? home.tabLabels : ['Siaran Pers', 'Info Tips', 'Warta UMKM'];
  home.tabData = {};

  // Tab yang sedang aktif jangan diklik lagi: di situs asal, klik pada tab aktif
  // justru mengosongkan grid.
  const activeLabel = await page.evaluate(READ_ACTIVE_TAB);
  log('tab aktif saat muat:', activeLabel || '(tidak terdeteksi)');

  const readCards = async () => {
    for (let i = 0; i < 5; i += 1) {
      const c = await page.evaluate(READ_CARDS);
      if (c.length) return c;
      await page.waitForTimeout(1200);
    }
    return [];
  };

  let current = null;
  for (const t of tabs) {
    if (current === null && (!activeLabel || activeLabel === t)) {
      current = await readCards();
      home.tabData[t] = current;
      log(`tab "${t}" (aktif) ->`, current.length, 'kartu');
      continue;
    }
    const clicked = await page.evaluate((label) => {
      const el = Array.prototype
        .slice.call(document.querySelectorAll('button,a,span,div,li'))
        .find((e) => (e.innerText || '').trim() === label && e.children.length <= 1);
      if (!el) return false;
      el.scrollIntoView({ block: 'center' });
      const target = el.closest('button,[role="button"],a') || el.parentElement || el;
      target.click();
      return true;
    }, t);
    await page.waitForTimeout(clicked ? 900 : 300);
    const cards = clicked ? await readCards() : [];
    home.tabData[t] = cards;
    log(`tab "${t}" ->`, cards.length, 'kartu', cards.length && current && cards.map((c) => c.href).join() === current.map((c) => c.href).join() ? '(sama dengan sebelumnya)' : '');
    if (cards.length) current = cards;
  }
  if ((!home.tabData['Siaran Pers'] || !home.tabData['Siaran Pers'].length) && current) {
    log('tab pertama kosong, memakai kartu dari tab terakhir yang terbaca');
  }

  await browser.close();
  if (failed.length > 12) log('catatan:', failed.length, 'permintaan aset gagal (biasanya widget pihak ketiga)');
  return home;
}

/* ------------------------------------------------------------------ media --- */

const EXT_BY_TYPE = {
  'image/jpeg': 'jpg',
  'image/png': 'png',
  'image/webp': 'webp',
  'image/svg+xml': 'svg',
  'image/gif': 'gif',
  'image/avif': 'avif',
};

const slug = (s) =>
  s
    .toLowerCase()
    .replace(/\.[a-z0-9]+$/, '')
    .replace(/[-_ ]?[0-9a-f]{8,}$/, '') // buang hash CMS di ujung
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .slice(0, 48) || 'asset';

const sniff = (buf, fallback) => {
  if (!buf || buf.length < 12) return fallback;
  if (buf[0] === 0xff && buf[1] === 0xd8) return 'jpg';
  if (buf.subarray(0, 4).toString() === 'RIFF' && buf.subarray(8, 12).toString() === 'WEBP') return 'webp';
  if (buf.subarray(0, 8).toString('hex') === '89504e470d0a1a0a') return 'png';
  if (buf.subarray(0, 6).toString().startsWith('GIF8')) return 'gif';
  if (buf.subarray(0, 200).toString().includes('<svg')) return 'svg';
  return fallback;
};

/** Kumpulkan semua URL media yang muncul di hasil pembacaan. */
function mediaUrls(home) {
  const urls = new Set();
  const SKIP = new Set(UI_ASSETS.map(([p]) => SITE + p));
  const add = (u) => u && /^https?:/.test(u) && !SKIP.has(u) && urls.add(u);
  home.hero.forEach((s) => add(s.image));
  Object.values(home.tabData || {}).forEach((arr) => arr.forEach((c) => add(c.image)));
  home.kebijakan.forEach((s) => add(s.image));
  home.banners.forEach((s) => add(s.image));
  add(home.kenali && home.kenali.image);
  add(home.emag && home.emag.image);
  (home.situs || []).forEach((s) => add(s.image));
  add(home.footer && home.footer.logo);
  (home.footer && home.footer.social || []).forEach((s) => add(s.icon));
  (home.menu || []).forEach((m) => {
    const img = m.href;
    if (/whatsapp/i.test(img)) add(`${SITE}/whatsapp.svg`);
  });
  return [...urls];
}

async function maybeResize(buf, width) {
  if (!width) return buf;
  let sharp;
  try {
    ({ default: sharp } = await import('sharp'));
  } catch {
    return buf; // sharp tidak terpasang -> simpan berkas apa adanya
  }
  const info = await sharp(buf).metadata();
  if (!info.width || info.width <= width) return buf;
  return sharp(buf)
    .resize({ width, withoutEnlargement: true })
    .jpeg({ quality: 78, mozjpeg: true })
    .toBuffer();
}

async function download(url, dir, taken, resizeTo, filename) {
  const res = await fetch(url, { headers: { 'User-Agent': UA, Referer: `${SITE}/` } });
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  let buf = Buffer.from(await res.arrayBuffer());
  const hint = (res.headers.get('content-type') || '').split(';')[0];
  let ext = EXT_BY_TYPE[hint] || sniff(buf, 'jpg');
  const base = slug(decodeURIComponent(new URL(url).pathname.split('/').pop() || ''));

  if (resizeTo && ['jpg', 'png', 'webp'].includes(ext)) {
    buf = await maybeResize(buf, resizeTo);
    ext = 'jpg';
  }

  let name = filename || `${base}.${ext}`;
  let n = 2;
  while (taken.has(name)) name = `${(filename || base).replace(/\.[^.]+$/, '')}-${n++}.${ext}`;
  taken.add(name);
  await writeFile(join(dir, name), buf);
  return { file: name, bytes: buf.length, source: url };
}

/** Ikon & logo chrome UI yang dirujuk komponen; nama berkasnya ditetapkan di sini
    supaya hasilnya deterministik dan tidak perlu disalin manual. */
const UI_ASSETS = [
  ['/image/logoUmkm4.svg', 'logoUmkm4.svg'],
  ['/image/logoUmkm4_white.svg', 'logoUmkm4_white.svg'],
  ['/image/indonesia.svg', 'indonesia.svg'],
  ['/image/InstagramCircle.svg', 'InstagramCircle.svg'],
  ['/image/FacebookCircle.svg', 'FacebookCircle.svg'],
  ['/image/YoutubeCircle.svg', 'YoutubeCircle.svg'],
  ['/image/TwitterCircle.svg', 'TwitterCircle.svg'],
  ['/whatsapp.svg', 'whatsapp.svg'],
  ['/user.svg', 'user.svg'],
  ['/calendar.svg', 'calendar.svg'],
];

async function fetchUiAssets() {
  const taken = new Set();
  for (const [path, name] of UI_ASSETS) {
    try {
      const r = await download(SITE + path, CONFIG.iconDir, taken, 0, name);
      if (r) log('ikon', `/image/${name}`);
    } catch (e) {
      log('ikon lewat', path, e.message);
    }
  }
}

/** Unduh media ke public/uploads (gambar) dan public/image (ikon/logo svg situs). */
async function fetchMedia(home, resizeTo) {
  await mkdir(CONFIG.mediaDir, { recursive: true });
  await mkdir(CONFIG.iconDir, { recursive: true });
  await fetchUiAssets();
  const map = new Map();
  const taken = new Set(
    existsSync(CONFIG.mediaDir) ? (await import('node:fs')).readdirSync(CONFIG.mediaDir) : [],
  );
  const icons = new Set(taken);

  let ok = 0;
  let skip = 0;
  for (const url of mediaUrls(home)) {
    const isSiteIcon = url.startsWith(`${SITE}/`) && !url.includes('/uploads/');
    const dir = isSiteIcon ? CONFIG.iconDir : CONFIG.mediaDir;
    const bucket = isSiteIcon ? icons : taken;
    try {
      const r = await download(url, dir, bucket, isSiteIcon ? 0 : resizeTo);
      if (!r) {
        skip += 1;
        continue;
      }
      map.set(url, `/${isSiteIcon ? 'image' : 'uploads'}/${r.file}`);
      ok += 1;
      log('media', `${ok}:${skip}`, `${map.get(url)} (${Math.round(r.bytes / 1024)} KB)`);
    } catch (e) {
      skip += 1;
      log('lewati', url, `->`, e.message);
    }
  }
  log('media selesai:', ok, 'berkas diunduh,', skip, 'dilewati');
  return map;
}

/* ------------------------------------------------------------------ emit --- */

const clip = (s, n = 160) => (s || '').replace(/\s+/g, ' ').trim().slice(0, n);
const nameFromUrl = (u) => {
  if (!u) return 'Banner';
  const f = decodeURIComponent(new URL(u).pathname.split('/').pop()).replace(/\.[^.]+$/, '');
  return f.replace(/[-_ ]?[0-9a-f]{8,}$/i, '').replace(/[_-]+/g, ' ').trim().slice(0, 40) || 'Banner';
};
const idFrom = (href) => (href || '').split('/').filter(Boolean).pop() || String(Math.random()).slice(2, 10);

/** Bangun objek data final: URL media sudah dipetakan ke berkas lokal. */
function buildData(home, media) {
  const m = (u) => (u && media.has(u) ? media.get(u) : u || null);

  return {
    scrapedAt: new Date().toISOString(),
    origin: SITE,
    pageTitle: clip(home.pageTitle, 80),
    hero: home.hero.map((s) => ({
      id: idFrom(s.href),
      title: clip(s.title),
      image: m(s.image),
      href: s.href,
    })),
    newsFlash: home.newsFlash.map((n) => ({ title: clip(n.title, 200), href: n.href })),
    tabs: Object.fromEntries(
      Object.entries(home.tabData || {}).map(([k, arr]) => [
        k,
        arr.map((c) => ({
          title: clip(c.title),
          author: clip(c.author, 60) || 'Humas Kementerian UMKM',
          date: clip(c.date, 20),
          image: m(c.image),
          href: c.href,
        })),
      ]),
    ),
    kebijakan: home.kebijakan.map((s) => ({
      id: idFrom(s.href),
      title: clip(s.title),
      excerpt: clip(s.excerpt, 260),
      image: m(s.image),
      href: s.href,
    })),
    kenali: {
      title: clip(home.kenali && home.kenali.title),
      excerpt: clip(home.kenali && home.kenali.excerpt, 260),
      image: m(home.kenali && home.kenali.image),
      href: (home.kenali && home.kenali.href) || null,
    },
    situs: (home.situs || []).map((s) => ({ name: clip(s.name, 40), image: m(s.image), href: s.href })),
    situsLainnya: home.situsLainnya || null,
    banners: home.banners.map((b) => ({
      name: clip(b.name, 40) || nameFromUrl(b.image),
      image: m(b.image),
      href: b.href,
    })),
    emag: home.emag ? { image: m(home.emag.image), href: home.emag.href, alt: clip(home.emag.alt, 60) } : null,
    agenda: home.agenda || { message: 'Data Tidak Ditemukan', items: [] },
    footer: {
      logo: m(home.footer && home.footer.logo),
      social: ((home.footer && home.footer.social) || []).filter((x) => x.icon),
      lines: ((home.footer && home.footer.lines) || []).map((l) => clip(l, 260)),
    },
    menu: home.menu || [],
  };
}

const HEADER_NOTE = `/**
 * BERKAS HASIL GENERATE — jangan diedit manual.
 * Dibuat oleh: node scripts/sync-umkm.mjs
 * Sumber: DOM beranda ${SITE}; yang disimpan hanya data indeks yang memang tampil di
 * beranda (judul, tanggal, penulis, tautan) plus berkas media yang diunduh ke public/.
 * Jalankan ulang scriptnya untuk menyegarkan, dan atur tampilan teks lewat src/data/home.ts.
 */
import type { Beranda } from '@/types/beranda';
`;

async function emit(data) {
  await mkdir(dirname(CONFIG.dataFile), { recursive: true });
  const mod = `${HEADER_NOTE}
export const beranda: Beranda = ${JSON.stringify(data, null, 2)};

export default beranda;
`;
  await writeFile(CONFIG.dataFile, mod);
  await writeFile(
    CONFIG.sourceMap,
    JSON.stringify({ generatedAt: data.scrapedAt, origin: data.origin, counts: {
      hero: data.hero.length,
      newsFlash: data.newsFlash.length,
      tabs: Object.fromEntries(Object.entries(data.tabs).map(([k, v]) => [k, v.length])),
      kebijakan: data.kebijakan.length,
      situs: data.situs.length,
      banners: data.banners.length,
      menu: data.menu.length,
    } }, null, 2),
  );
  log('ditulis:', CONFIG.dataFile);
  log('ditulis:', CONFIG.sourceMap);
}

/* ------------------------------------------------------------------ main --- */

async function main() {
  log('target proyek:', OUT);
  const home = await collect();

  const summary = {
    hero: home.hero.length,
    newsFlash: home.newsFlash.length,
    tabs: Object.fromEntries(Object.entries(home.tabData || {}).map(([k, v]) => [k, v.length])),
    kebijakan: home.kebijakan.length,
    banners: home.banners.length,
    situs: (home.situs || []).length,
    menu: (home.menu || []).length,
    emag: !!home.emag,
    kenali: !!(home.kenali && home.kenali.title),
  };
  log('hasil pembacaan:', JSON.stringify(summary));

  if (!home.hero.length) {
    die('slide hero tidak ada satu pun.', 'kemungkinan struktur DOM situs asal berubah atau halaman diblokir; buka dengan --headed untuk memeriksa.');
  }

  if (CONFIG.dryRun) {
    console.log(JSON.stringify(buildData(home, new Map()), null, 2));
    log('--dry-run: tidak ada berkas yang ditulis');
    return;
  }

  const media = CONFIG.withMedia ? await fetchMedia(home, Number(opt('--resize', 0)) || 0) : new Map();
  await emit(buildData(home, media));
  log('selesai.');
}

main().catch((e) => die(e.stack || e.message));
