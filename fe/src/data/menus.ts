import { fetchJson } from "../app/api";

export type MenuItem = {
  id: number;
  name: string;
  url: string | null;
  route: string | null;
  link: string | null;
  target_blank: boolean;
  position: number;
  children: MenuItem[];
};

export type Menu = {
  id: number;
  name: string;
  slug: string;
  location: string;
  items: MenuItem[];
};

type Envelope<T> = { status: string; message: string; data: T };

function menuHref(item: MenuItem): string {
  // Prioritas: url eksplisit (/, http, tel:) lalu link hasil backend.
  // Link backend untuk route Laravel (http://... ) dipetakan ke path frontend bila perlu.
  // URL warisan bentuk hash (`#/berita`) dinormalisasi ke path bersih (`/berita`).
  const raw = (item.url ?? item.link ?? "").trim();
  if (raw) {
    if (raw.startsWith("#")) return raw.slice(1) || "/";
    return raw;
  }
  if (item.route) {
    if (item.route === "home") return "/";
    return `/${item.route}`;
  }
  return "/";
}

function sortItems(items: MenuItem[]): MenuItem[] {
  return [...items].sort((a, b) => a.position - b.position);
}

export function toNavHref(item: MenuItem): { href: string; external: boolean } {
  const href = menuHref(item);
  const external = /^https?:\/\//i.test(href) || href.startsWith("tel:") || href.startsWith("mailto:");
  return { href, external };
}

export async function fetchMenus(location?: string): Promise<Menu[]> {
  const qs = location ? `?location=${encodeURIComponent(location)}` : "";
  const json = await fetchJson<Envelope<Menu[]>>(`/api/menus${qs}`);
  if (!Array.isArray(json.data)) throw new Error("Format respons menu tak dikenal");
  return json.data.map((menu) => ({
    ...menu,
    items: sortItems(menu.items ?? []).map((item) => ({
      ...item,
      children: sortItems(item.children ?? []),
    })),
  }));
}

export async function fetchHeaderMenu(): Promise<MenuItem[]> {
  const menus = await fetchMenus("header");
  return menus[0]?.items ?? [];
}


