import { fetchJson } from "../app/api";

export type WebsiteIdentity = {
  uuid: string;
  site_name: string | null;
  site_title: string | null;
  tagline: string | null;
  description: string | null;
  email: string | null;
  phone: string | null;
  address: string | null;
  facebook_url: string | null;
  instagram_url: string | null;
  youtube_url: string | null;
  tiktok_url: string | null;
  meta_title: string | null;
  meta_description: string | null;
  meta_keywords: string | null;
  og_image: string | null;
  google_analytics_id: string | null;
  google_site_verification: string | null;
  logo: string | null;
  favicon: string | null;
  logo_url: string | null;
  favicon_url: string | null;
  og_image_url: string | null;
  created_at: string | null;
  updated_at: string | null;
};

type Envelope<T> = {
  status: string;
  message: string;
  data: T;
};

function normalizeStorageUrl(url: string | null): string | null {
  if (!url) return null;
  // backend lama bisa kirim absolut http://127.0.0.1:8000/storage/... -> ubah ke relatif agar via proxy nginx/vite
  if (url.startsWith("http")) {
    try {
      const u = new URL(url);
      if (u.pathname.startsWith("/storage/")) return u.pathname;
    } catch {
      // biarkan apa adanya
    }
  }
  return url;
}

export async function fetchWebsiteIdentity(): Promise<WebsiteIdentity> {
  const json = await fetchJson<Envelope<WebsiteIdentity>>("/api/website-identity");
  if (!json.data || typeof json.data !== "object" || Array.isArray(json.data)) {
    throw new Error("Format identitas website tak dikenal");
  }
  const d = json.data;
  // normalisasi url agar tidak mixed-content di https
  d.logo_url = normalizeStorageUrl(d.logo_url);
  d.favicon_url = normalizeStorageUrl(d.favicon_url);
  d.og_image_url = normalizeStorageUrl(d.og_image_url);
  return d;
}
