import { useEffect, useState } from "react";
import {
  AGENDA_DETAIL_PATH,
  AGENDA_DETAIL_PREFIX,
  AGENDA_PATH,
  ALBUM_DETAIL_PATH,
  ALBUM_DETAIL_PREFIX,
  NEWS_DETAIL_PATH,
  NEWS_DETAIL_PREFIX,
  OFFICIAL_DETAIL_PATH,
  OFFICIAL_DETAIL_PREFIX,
  PAGE_DETAIL_PATH,
  PAGE_DETAIL_PREFIX,
  PHOTO_DETAIL_PATH,
  SEARCH_MAX_LENGTH,
} from "./constants";

const routes = new Set([
  "/", "/visi-misi", "/informasi-pejabat", "/dokumen",
  "/berita", "/galeri", "/album", "/event", AGENDA_PATH,
  "/pengumuman", "/layanan", "/faq", "/teknis-peil-banjir", "/pemanfaatan-ruang-jalan",
  "/informasi-berkala", "/informasi-setiap-saat",
  "/informasi-serta-merta", "/informasi-yang-dikecualikan",
  PHOTO_DETAIL_PATH,
]);

export type Route = { path: string; slug: string; query: string };

// Event internal agar `navigate()` (history.pushState tidak memicu
// popstate) tetap memperbarui semua hook yang sedang dipasang.
export const ROUTE_CHANGE_EVENT = "app:routechange";

// Decode segmen slug secara aman (slug boleh mengandung koma/spasi).
function parseSlug(segment: string): string {
  const raw = segment.trim().slice(0, 200);
  try {
    return decodeURIComponent(raw);
  } catch {
    return raw;
  }
}

// Cocokkan pathname ke rute yang dikenal. Toleran bila aplikasi di-host
// di subpath (mis. `/sub/berita`): segmen depan yang tak dikenal dikupas
// satu per satu sampai ketemu rute yang dikenal.
function matchKey(pathname: string): { path: string; slug: string } {
  const normalized = pathname.length > 1 ? pathname.replace(/\/+$/, "") : pathname;
  if (normalized === "/" || normalized === "/index.html") return { path: "/", slug: "" };
  const segments = normalized.split("/").filter(Boolean);
  for (let start = 0; start < segments.length; start += 1) {
    const candidate = `/${segments.slice(start).join("/")}`;
    if (routes.has(candidate)) return { path: candidate, slug: "" };
    if (candidate.startsWith(NEWS_DETAIL_PREFIX)) {
      // Rute dinamis `/berita/{slug}` untuk halaman detail berita.
      const segment = candidate.slice(NEWS_DETAIL_PREFIX.length);
      if (segment && !segment.includes("/")) {
        return { path: NEWS_DETAIL_PATH, slug: parseSlug(segment) };
      }
      return { path: "/404", slug: "" };
    }
    if (candidate.startsWith(ALBUM_DETAIL_PREFIX)) {
      // Rute dinamis `/album/{uuid}` untuk detail album galeri.
      const segment = candidate.slice(ALBUM_DETAIL_PREFIX.length);
      if (segment && !segment.includes("/")) {
        return { path: ALBUM_DETAIL_PATH, slug: parseSlug(segment) };
      }
      return { path: "/404", slug: "" };
    }
    if (candidate.startsWith(PAGE_DETAIL_PREFIX)) {
      // Rute dinamis `/halaman/{slug}` untuk halaman statis API.
      const segment = candidate.slice(PAGE_DETAIL_PREFIX.length);
      if (segment && !segment.includes("/")) {
        return { path: PAGE_DETAIL_PATH, slug: parseSlug(segment) };
      }
      return { path: "/404", slug: "" };
    }
    if (candidate.startsWith(OFFICIAL_DETAIL_PREFIX)) {
      // Detail pejabat `/informasi-pejabat/{uuid}` — bedakan dari list `/informasi-pejabat`.
      const segment = candidate.slice(OFFICIAL_DETAIL_PREFIX.length);
      if (segment && !segment.includes("/")) {
        return { path: OFFICIAL_DETAIL_PATH, slug: parseSlug(segment) };
      }
      return { path: "/404", slug: "" };
    }
    if (candidate.startsWith(AGENDA_DETAIL_PREFIX)) {
      const segment = candidate.slice(AGENDA_DETAIL_PREFIX.length);
      if (segment && !segment.includes("/")) {
        // `/agenda/:slug` detail, list `/agenda` sudah di routes
        return { path: AGENDA_DETAIL_PATH, slug: parseSlug(segment) };
      }
      return { path: "/404", slug: "" };
    }
  }
  return { path: "/404", slug: "" };
}

function getRoute(): Route {
  // Redirect warisan: bookmark/SEO lama masih berbentuk `#/berita/...`.
  // Dibaca di sini agar render pertama langsung benar; App membersihkan
  // URL-nya via history.replaceState.
  const hash = window.location.hash;
  if (hash.startsWith("#/")) {
    const [rawPath = "/", rawQuery = ""] = hash.slice(1).split("?");
    const query =
      new URLSearchParams(rawQuery).get("q")?.trim().slice(0, SEARCH_MAX_LENGTH) ?? "";
    const matched = matchKey(rawPath || "/");
    const route = { ...matched, query };
    if (route.path !== "/404") window.__lastRoute = route;
    return route;
  }
  const query =
    new URLSearchParams(window.location.search).get("q")?.trim().slice(0, SEARCH_MAX_LENGTH) ?? "";
  const matched = matchKey(window.location.pathname);
  const route = { ...matched, query };
  if (route.path !== "/404") window.__lastRoute = route;
  // Anchor murni (mis. `#main-content` dari skip-link) tidak mengubah
  // pathname, jadi tidak pernah dianggap pindah rute.
  return route.path === "/404" ? { path: "/404", slug: "", query: "" } : route;
}

// Pindah halaman tanpa reload (URL bersih tanpa `#`).
export function navigate(to: string): void {
  window.history.pushState(null, "", to);
  window.dispatchEvent(new Event(ROUTE_CHANGE_EVENT));
}

export function useRoute() {
  const [route, setRoute] = useState(getRoute);
  useEffect(() => {
    const update = () => setRoute(getRoute());
    window.addEventListener("popstate", update);
    window.addEventListener(ROUTE_CHANGE_EVENT, update);
    return () => {
      window.removeEventListener("popstate", update);
      window.removeEventListener(ROUTE_CHANGE_EVENT, update);
    };
  }, []);
  return route;
}
