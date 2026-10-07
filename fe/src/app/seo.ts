// Utilitas <head> dinamis untuk SEO: title, meta, canonical, JSON-LD.
// Dipakai per rute/halaman agar setiap tampilan punya identitas indexed
// yang benar. Routing memakai URL bersih (history API) sehingga setiap
// halaman adalah URL unik yang bisa dirayapi langsung.

export function setDocumentTitle(title: string): void {
  document.title = title;
}

export function setMetaTag(attr: "name" | "property", key: string, content: string): void {
  const selector = `meta[${attr}="${key}"]`;
  let el = document.head.querySelector<HTMLMetaElement>(selector);
  if (!el) {
    el = document.createElement("meta");
    el.setAttribute(attr, key);
    document.head.appendChild(el);
  }
  el.setAttribute("content", content);
}

export function setCanonical(href: string): void {
  let el = document.head.querySelector<HTMLLinkElement>('link[rel="canonical"]');
  if (!el) {
    el = document.createElement("link");
    el.setAttribute("rel", "canonical");
    document.head.appendChild(el);
  }
  el.setAttribute("href", href);
}

export function setJsonLd(id: string, data: unknown): void {
  document.getElementById(id)?.remove();
  const el = document.createElement("script");
  el.id = id;
  el.type = "application/ld+json";
  el.textContent = JSON.stringify(data);
  document.head.appendChild(el);
}

export function clearJsonLd(id: string): void {
  document.getElementById(id)?.remove();
}

export function setFavicon(href: string): void {
  if (!href) return;
  // paksa reload favicon: hapus semua link icon lama lalu buat baru (bypass cache browser tab)
  document.head.querySelectorAll('link[rel="icon"], link[rel="shortcut icon"]').forEach((el) => el.remove());
  const ext = href.split(".").pop()?.toLowerCase() || "png";
  const type = ext === "ico" ? "image/x-icon" : ext === "svg" ? "image/svg+xml" : "image/png";
  const link = document.createElement("link");
  link.setAttribute("rel", "icon");
  link.setAttribute("type", type);
  link.setAttribute("href", href);
  document.head.appendChild(link);
  // shortcut fallback untuk browser lama
  const shortcut = document.createElement("link");
  shortcut.setAttribute("rel", "shortcut icon");
  shortcut.setAttribute("type", type);
  shortcut.setAttribute("href", href);
  document.head.appendChild(shortcut);
}

export function removeMetaTag(attr: "name" | "property", key: string): void {
  document.head.querySelector(`meta[${attr}="${key}"]`)?.remove();
}

export function ensureGoogleSiteVerification(token: string): void {
  if (!token) {
    removeMetaTag("name", "google-site-verification");
    return;
  }
  setMetaTag("name", "google-site-verification", token);
}

export function ensureGoogleAnalytics(gaId: string): void {
  if (!gaId) return;
  if (document.getElementById("ga-gtag")) return;
  const s1 = document.createElement("script");
  s1.async = true;
  s1.src = `https://www.googletagmanager.com/gtag/js?id=${encodeURIComponent(gaId)}`;
  s1.id = "ga-gtag-src";
  document.head.appendChild(s1);
  const s2 = document.createElement("script");
  s2.id = "ga-gtag";
  s2.textContent = `window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js', new Date());gtag('config','${gaId}');`;
  document.head.appendChild(s2);
}
