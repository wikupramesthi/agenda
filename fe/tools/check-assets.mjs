/**
 * Pastikan setiap aset /uploads/* dan /image/* yang direferensikan hasil build
 * benar-benar ada di dalam dist — penjaga terhadap 404 seperti nama berkas ikon
 * yang salah susun. Jalankan setelah build: node tools/check-assets.mjs
 */
import { readFile, readdir, stat } from 'node:fs/promises';
import { existsSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const dist = join(dirname(fileURLToPath(import.meta.url)), '..', 'dist');

if (!existsSync(dist)) {
  console.error('[check-assets] dist belum ada — jalankan `npm run build` dulu.');
  process.exit(1);
}

const walk = async (dir) => {
  const out = [];
  for (const entry of await readdir(dir, { withFileTypes: true })) {
    const p = join(dir, entry.name);
    if (entry.isDirectory()) out.push(...(await walk(p)));
    else out.push(p);
  }
  return out;
};

const files = await walk(dist);
const assets = files.filter((f) => /\.(js|css|html)$/.test(f));
const PATTERN = /\/(?:uploads|image)\/[A-Za-z0-9._%\- ]+/g;

const missing = new Set();
for (const file of assets) {
  const text = await readFile(file, 'utf8');
  for (const ref of new Set(text.match(PATTERN) || [])) {
    const clean = decodeURIComponent(ref);
    if (!existsSync(join(dist, clean.slice(1)))) missing.add(clean);
  }
}

if (missing.size) {
  console.error(`[check-assets] ${missing.size} aset direferensikan tapi tidak ada di dist:`);
  for (const m of [...missing].sort()) console.error('  -', m);
  process.exit(1);
}

const count = files.filter((f) => /\/(uploads|image)\//.test(f)).length;
console.log(`[check-assets] ok — ${count} berkas aset, semua referensi resolve.`);
