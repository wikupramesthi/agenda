// Helper URL aset statis (`public/assets/...`).
//
// Masalah yang diatasi: `src="./assets/logo.png"` di JSX diselesaikan
// browser relatif terhadap URL dokumen. Di beranda (`/`) hasilnya benar
// (`/assets/logo.png`), tetapi di rute bersarang (`/berita/{slug}`,
// `/foto/6591/...`) menjadi `/berita/assets/...` sehingga logo/gambar
// tidak tampil (404). Karena itu seluruh referensi aset di kode harus
// lewat `asset()` yang mengembalikan path absolut dari root aplikasi.
//
// Subpath-safe: root aplikasi diturunkan dari URL `<script type="module">`
// yang sudah diselesaikan browser saat parse (`/sub/assets/index-*.js`
// -> root `/sub/`), sehingga tetap benar bila di-host di subpath.
// Tanpa itu (mis. dev `/src/main.tsx`) dipakai `BASE_URL` bila absolut,
// kalau tidak jatuh ke `/`.
let cachedRoot: string | null = null;

function appRoot(): string {
  if (cachedRoot !== null) return cachedRoot;
  try {
    const script = document.querySelector<HTMLScriptElement>(
      'script[type="module"]',
    );
    const src = script?.src ?? "";
    if (src) {
      const pathname = new URL(src, document.baseURI).pathname;
      const root = pathname.replace(/\/assets\/[^/]*$/, "/");
      if (root !== pathname && root.startsWith("/")) {
        cachedRoot = root;
        return root;
      }
    }
  } catch {
    // Abaikan dan pakai fallback di bawah.
  }
  const base = import.meta.env.BASE_URL ?? "/";
  cachedRoot =
    base.startsWith("/") && base.length > 1
      ? base.endsWith("/")
        ? base
        : `${base}/`
      : "/";
  return cachedRoot;
}

// `asset("assets/logo.png")` -> `/assets/logo.png` (atau `/sub/assets/...`
// bila di-host di subpath). Menerima input `./assets/...`, `assets/...`,
// atau `/assets/...`.
export function asset(path: string): string {
  const clean = path.replace(/^\.\/+/, "").replace(/^\/+/, "");
  return `${appRoot()}${clean}`;
}
