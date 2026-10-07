// Konstanta terpusat agar tidak ada magic number/string tersebar di komponen.
// Palet mengikuti tema situs (public/vendor/css/main.css).
export const SEARCH_MAX_LENGTH = 100;

export const CAROUSEL_INTERVAL_MS = 6500;
export const COUNTDOWN_INTERVAL_MS = 60_000;

export const MS_PER_DAY = 86_400_000;
export const MS_PER_HOUR = 3_600_000;
export const MS_PER_MINUTE = 60_000;

export const COPY_FEEDBACK_MS = 1800;
export const TOUCH_DISMISS_PX = 28;
export const WHEEL_DISMISS_DELTA = 5;

// Floating countdown Porprov Jabar XV (7–20 November 2026).
// Target = pembukaan; setelah hari-H terlewati floating otomatis hilang.
export const PORPROV_TARGET = "2026-11-07T08:00:00+07:00";
export const PORPROV_RANGE_LABEL = "7 November 2026 – 20 November 2026";
export const PORPROV_DISMISS_KEY = "site:porprov:dismissed";

export const PHOTO_DETAIL_PATH =
  "/foto/6591/menpora-erick-dampingi-presiden-prabowo-lepas-432-atlet-indonesia";

// Kunci rute untuk halaman detail berita dinamis `/berita/{slug}`.
// Slug aktual dibawa di `Route.slug`, bukan di `path`.
export const NEWS_DETAIL_PATH = "/berita/:slug";
export const NEWS_DETAIL_PREFIX = "/berita/";

// Album galeri dinamis `/album/{uuid}` (uuid dari API).
export const ALBUM_DETAIL_PATH = "/album/:uuid";
export const ALBUM_DETAIL_PREFIX = "/album/";

// Halaman statis dinamis `/halaman/{slug}` (slug dari `GET /api/pages`).
export const PAGE_DETAIL_PATH = "/halaman/:slug";
export const PAGE_DETAIL_PREFIX = "/halaman/";

// Pejabat detail `/informasi-pejabat/{uuid}` (uuid dari `GET /api/officials`).
export const OFFICIAL_DETAIL_PATH = "/informasi-pejabat/:uuid";
export const OFFICIAL_DETAIL_PREFIX = "/informasi-pejabat/";

// Agenda `/agenda` dan detail `/agenda/:slug` (slug dari `GET /api/agenda`).
export const AGENDA_PATH = "/agenda";
export const AGENDA_DETAIL_PATH = "/agenda/:slug";
export const AGENDA_DETAIL_PREFIX = "/agenda/";

// Splash intro: tampil maksimal 1x per sesi tab, minimal berjarak
// INTRO_COOLDOWN_MS antar tampil, atau tiap INTRO_EVERY_N_VISITS kunjungan.
// Semua kunci hanya di penyimpanan lokal perangkat (bukan data bersama).
export const INTRO_SESSION_KEY = "site:intro:shown";
export const INTRO_COUNT_KEY = "site:intro:visits";
export const INTRO_LAST_KEY = "site:intro:last";
export const INTRO_COOLDOWN_MS = 5 * 60_000;
export const INTRO_EVERY_N_VISITS = 5;
