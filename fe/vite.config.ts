import react from "@vitejs/plugin-react";
import { defineConfig } from "vite";

// Backend Laravel lokal. JANGAN hardcode URL tunnel publik di sini — URL
// tunnel berubah-ubah. Traffic browser normal lewat nginx (/be/*, /api/*,
// /storage/*); proxy di bawah hanya untuk akses langsung ke vite (:5173).
const BACKEND = "http://127.0.0.1:8000";

export default defineConfig({
  // Base absolut "/": dengan base relatif "./", aset di halaman fallback
  // (index.html yang disajikan untuk rute tanpa file prerender) ikut
  // relatif terhadap URL permintaan (/berita/foo -> /berita/assets/...)
  // sehingga JS tidak pernah jalan dan halaman "kosong". Subpath hosting
  // tidak lagi didukung — deploy di root domain.
  base: "/",
  // SPA dengan URL bersih (history.pushState). Fallback hosting statis
  // disediakan via dist/404.html (lihat scripts/copy-404.mjs).
  appType: "spa",
  plugins: [react()],

  server: {
    host: "0.0.0.0",
    port: 5173,
    strictPort: true,
    // Dev sengaja `true` (izinkan semua host): IP LAN (192.168.x.x, dsb.)
    // dan domain tunnel publik selalu berubah sehingga allowlist statis selalu
    // ketinggalan dan bikin "Blocked request. This host is not allowed".
    // Risiko DNS-rebinding terbatas untuk dev lokal; jangan expose dev
    // server ke internet publik tanpa firewall.
    allowedHosts: true,

    proxy: {
      // PENTING: key proxy string dicocokkan Vite secara prefix
      // (`url.startsWith(key)`), jadi key "/be" ikut menangkap rute SPA
      // seperti `/berita/...` dan meneruskannya ke backend (404 Laravel).
      // Key diawali `^` diperlakukan sebagai regex (lihat
      // doesProxyContextMatchUrl di vite), sehingga `^/be($|/)` hanya
      // cocok dengan `/be` persis atau apapun di bawah `/be/...`
      // (samakan dengan nginx: strip /be/).
      "^/be($|/)": {
        target: BACKEND,
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/be/, ""),
      },
      "^/api($|/)": {
        target: BACKEND,
        changeOrigin: true,
      },
      "^/storage($|/)": {
        target: BACKEND,
        changeOrigin: true,
      },
    },
  },

  preview: {
    host: "0.0.0.0",
    port: 4173,
    strictPort: true,
    // Sama seperti dev: preview lokal dibuka via IP LAN / domain tunnel
    // yang selalu berubah, jadi jangan pakai allowlist statis di sini.
    // Proteksi host yang sesungguhnya ada di nginx / hosting produksi.
    allowedHosts: true,
    // Prerender (scripts/prerender.mjs) render halaman lewat `vite preview`,
    // jadi proxy API yang sama perlu ada di sini agar fetch /api/... berhasil.
    proxy: {
      "^/be($|/)": {
        target: BACKEND,
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/be/, ""),
      },
      "^/api($|/)": {
        target: BACKEND,
        changeOrigin: true,
      },
      "^/storage($|/)": {
        target: BACKEND,
        changeOrigin: true,
      },
    },
  },

  build: {
    emptyOutDir: true,
    outDir: "dist",
    // Eksplisit: tanpa sourcemap di artefak publik.
    sourcemap: false,
    // Jangan inline aset <4KB sebagai data: — CSP memakai `font-src 'self'`
    // tanpa `data:`, jadi font inline akan diblokir browser.
    assetsInlineLimit: 0,
  },
});
