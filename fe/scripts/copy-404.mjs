import { copyFile } from "node:fs/promises";

// Salin index.html -> 404.html agar hosting statis (QW Pages, GitHub Pages,
// Netlify tanpa redirect rule, dsb) tetap menyajikan SPA history-router
// (URL bersih tanpa `#`) saat pengguna me-refresh di URL dalam atau
// membuka path langsung.
// Catatan: bila memakai nginx sendiri, tambahkan fallback setara:
// `try_files $uri $uri/ /index.html;` agar path seperti /berita atau
// /galeri tidak 404 saat dibuka langsung.
await copyFile(new URL("../dist/index.html", import.meta.url), new URL("../dist/404.html", import.meta.url));
console.log("copied dist/index.html -> dist/404.html");
