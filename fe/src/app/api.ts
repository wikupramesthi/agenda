// Lapisan HTTP terpusat untuk backend DBMSDA.
// Strategi default: relatif + same-origin (disarankan, cocok dengan CSP
// `connect-src 'self'` dan bebas CORS).
// - Dev/lokal tanpa env: path relatif (`/api/...`) yang diproxy vite ke
//   backend, sehingga same-origin dan bebas masalah CORS dari origin
//   mana pun (localhost, 127.0.0.1, IP LAN).
// - Production via nginx: `VITE_API_BASE_URL=/be` agar `/be/api/...`
//   diproxy nginx ke backend (strip prefix /be).
// - QW Pages langsung ke API absolut (tanpa nginx):
//   `VITE_API_BASE_URL=https://api.domain.tld npm run build`, dengan syarat
//   origin masuk `allowed_origins` backend DAN origin ditambahkan ke
//   `connect-src` CSP di index.html (nilai VITE_* di-bake saat build).
export const API_BASE_URL =
  import.meta.env.VITE_API_BASE_URL?.replace(/\/+$/, "") || "";

export class ApiError extends Error {
  status: number;

  constructor(message: string, status: number) {
    super(message);
    this.name = "ApiError";
    this.status = status;
  }
}

// GET JSON dengan timeout. Melempar ApiError (HTTP != 2xx) atau Error/DOMException (jaringan/timeout).
export async function fetchJson<T>(path: string, timeoutMs = 10_000): Promise<T> {
  const controller = new AbortController();
  const timer = window.setTimeout(() => controller.abort(), timeoutMs);
  try {
    const response = await fetch(`${API_BASE_URL}${path}`, {
      headers: {
        Accept: "application/json",
      },
      signal: controller.signal,
    });
    if (!response.ok) {
      throw new ApiError(`API ${response.status} untuk ${path}`, response.status);
    }
    // Guard: backend harus mengembalikan JSON. Kalau yang datang HTML
    // (mis. index.html SPA / halaman parkir), response.json() hanya
    // melempar "Unexpected token '<'" yang membingungkan — tampilkan
    // pesan yang jelas beserta cuplikan isi.
    const contentType = response.headers.get("content-type") || "";
    if (!contentType.includes("json")) {
      const snippet = (await response.text()).slice(0, 80).replace(/\s+/g, " ");
      throw new ApiError(
        `API ${path} mengembalikan non-JSON (${contentType || "tanpa content-type"}): ${snippet}`,
        response.status,
      );
    }
    return (await response.json()) as T;
  } finally {
    window.clearTimeout(timer);
  }
}
