import { Suspense, lazy, useEffect } from "react";
import { AGENDA_DETAIL_PATH, AGENDA_PATH, ALBUM_DETAIL_PATH, NEWS_DETAIL_PATH, OFFICIAL_DETAIL_PATH, PAGE_DETAIL_PATH, PHOTO_DETAIL_PATH } from "./app/constants";
import { ensureGoogleAnalytics, ensureGoogleSiteVerification, setCanonical, setDocumentTitle, setFavicon, setJsonLd, setMetaTag } from "./app/seo";
import { ROUTE_CHANGE_EVENT, navigate, useRoute } from "./app/useRoute";
import { useWebsiteIdentity } from "./app/WebsiteIdentityContext";
import { SiteLayout } from "./component/layout/SiteLayout";
import { informationCategorySlugs, pageTitles, policyPages } from "./data/siteData";

// Code-splitting per halaman agar unduhan awal ringan: setiap rute
// dimuat terpisah saat pertama dibuka, dengan indikator loading.
const HomePage = lazy(() => import("./component/layout/HomePage").then((m) => ({ default: m.HomePage })));
const AboutPage = lazy(() => import("./component/about/AboutPage").then((m) => ({ default: m.AboutPage })));
const OfficialPage = lazy(() => import("./component/official/OfficialPage").then((m) => ({ default: m.OfficialPage })));
const ActivityPage = lazy(() => import("./component/activity/ActivityPage").then((m) => ({ default: m.ActivityPage })));
const NewsDetailPage = lazy(() => import("./component/activity/NewsDetailPage").then((m) => ({ default: m.NewsDetailPage })));
const GalleryPage = lazy(() => import("./component/gallery/GalleryPage").then((m) => ({ default: m.GalleryPage })));
const AlbumPage = lazy(() => import("./component/album/AlbumPage").then((m) => ({ default: m.AlbumPage })));
const AlbumDetailPage = lazy(() => import("./component/album/AlbumDetailPage").then((m) => ({ default: m.AlbumDetailPage })));
const PhotoDetailPage = lazy(() => import("./component/gallery/PhotoDetailPage").then((m) => ({ default: m.PhotoDetailPage })));
const ServicePage = lazy(() => import("./component/service/ServicePage").then((m) => ({ default: m.ServicePage })));
const PolicyPage = lazy(() => import("./component/policy/PolicyPage").then((m) => ({ default: m.PolicyPage })));
const DocumentPage = lazy(() => import("./component/policy/DocumentPage").then((m) => ({ default: m.DocumentPage })));
const DocumentCategoryPage = lazy(() => import("./component/policy/DocumentCategoryPage").then((m) => ({ default: m.DocumentCategoryPage })));
const FaqPage = lazy(() => import("./component/faq/FaqPage").then((m) => ({ default: m.FaqPage })));
const PeilBanjirPage = lazy(() => import("./component/technical/PeilBanjirPage").then((m) => ({ default: m.PeilBanjirPage })));
const PemanfaatanRuangJalanPage = lazy(() => import("./component/technical/PemanfaatanRuangJalanPage").then((m) => ({ default: m.PemanfaatanRuangJalanPage })));
const StaticPage = lazy(() => import("./component/page/StaticPage").then((m) => ({ default: m.StaticPage })));
const OfficialDetailPage = lazy(() => import("./component/official/OfficialDetailPage").then((m) => ({ default: m.OfficialDetailPage })));
const AgendaPage = lazy(() => import("./component/agenda/AgendaPage").then((m) => ({ default: m.AgendaPage })));
const AgendaDetailPage = lazy(() => import("./component/agenda/AgendaDetailPage").then((m) => ({ default: m.AgendaDetailPage })));
const ErrorPage = lazy(() => import("./component/error/ErrorPage").then((m) => ({ default: m.ErrorPage })));

const FALLBACK_SITE_NAME = "DBMSDA Kota Bekasi";

const ROUTE_DESCRIPTIONS: Record<string, string> = {
  "/": "Portal informasi Dinas Bina Marga dan Sumber Daya Air Kota Bekasi.",
  "/berita": "Berita terbaru pembangunan jalan, drainase, dan sumber daya air Kota Bekasi.",
  "/event": "Kalender kegiatan infrastruktur dan sumber daya air Kota Bekasi.",
  "/galeri": "Galeri foto kegiatan DBMSDA Kota Bekasi.",
  "/album": "Album dokumentasi kegiatan DBMSDA Kota Bekasi.",
  "/pengumuman": "Pengumuman resmi Dinas Bina Marga dan Sumber Daya Air Kota Bekasi.",
  "/dokumen": "Dokumen publik Dinas Bina Marga dan Sumber Daya Air Kota Bekasi.",
  "/layanan": "Layanan publik DBMSDA Kota Bekasi.",
  "/faq": "Pertanyaan yang sering diajukan seputar layanan DBMSDA Kota Bekasi.",
  "/teknis-peil-banjir": "Dokumen teknis Peil Banjir DBMSDA Kota Bekasi sebagai acuan perencanaan drainase dan pengendalian banjir.",
  "/pemanfaatan-ruang-jalan": "Pedoman pemanfaatan ruang milik jalan dan ruang manfaat jalan di Kota Bekasi.",
  [PAGE_DETAIL_PATH]: "Halaman informasi Dinas Bina Marga dan Sumber Daya Air Kota Bekasi.",
  [OFFICIAL_DETAIL_PATH]: "Profil pejabat DBMSDA Kota Bekasi.",
  [AGENDA_DETAIL_PATH]: "Detail agenda DBMSDA Kota Bekasi.",
  [AGENDA_PATH]: "Daftar agenda kegiatan DBMSDA Kota Bekasi.",
  "/informasi-berkala": "Daftar Informasi Publik berkala.",
  "/informasi-setiap-saat": "Daftar Informasi Publik setiap saat.",
  "/informasi-serta-merta": "Daftar Informasi Publik serta merta.",
  "/informasi-yang-dikecualikan": "Daftar Informasi Publik yang dikecualikan.",
};

function PageLoading() {
  return (
    <div className="page-loading" role="status" aria-label="Memuat halaman">
      <div className="ui-wrap">
        <span className="loader-orbit" aria-hidden="true">
          <span className="loader-core" />
        </span>
        <div className="loader-track" aria-hidden="true">
          <span className="loader-fill" />
        </div>
        <p>Memuat halaman…</p>
      </div>
    </div>
  );
}

function RoutedPage({ path, slug, query }: { path: string; slug: string; query: string }) {
  if (path === "/") return <HomePage />;
  if (path === "/visi-misi") return <AboutPage />;
  if (path === "/informasi-pejabat") return <OfficialPage />;
  if (path === OFFICIAL_DETAIL_PATH) return <OfficialDetailPage uuid={slug} />;
  if (path === AGENDA_PATH) return <AgendaPage />;
  if (path === AGENDA_DETAIL_PATH) return <AgendaDetailPage slug={slug} />;
  if (path === "/berita") return <ActivityPage variant="news" query={query} />;
  if (path === NEWS_DETAIL_PATH) return <NewsDetailPage slug={slug} />;
  if (path === "/event") return <ActivityPage variant="event" />;
  if (path === "/pengumuman") return <ActivityPage variant="announcement" />;
  if (path === "/galeri") return <GalleryPage />;
  if (path === "/album") return <AlbumPage />;
  if (path === ALBUM_DETAIL_PATH) return <AlbumDetailPage uuid={slug} />;
  if (path === PHOTO_DETAIL_PATH) return <PhotoDetailPage />;
  if (path === "/layanan") return <ServicePage />;
  if (path === "/faq") return <FaqPage />;
  if (path === "/teknis-peil-banjir") return <PeilBanjirPage />;
  if (path === "/pemanfaatan-ruang-jalan") return <PemanfaatanRuangJalanPage />;
  if (path === PAGE_DETAIL_PATH) return <StaticPage slug={slug} />;
  if (path === "/dokumen") return <DocumentPage />;
  if (policyPages[path]) return <PolicyPage content={policyPages[path]} />;
  if (informationCategorySlugs[path]) {
    return <DocumentCategoryPage title={(pageTitles[path] ?? "Informasi").toUpperCase()} categorySlug={informationCategorySlugs[path]} />;
  }
  return <ErrorPage />;
}

export function App() {
  const { path, slug, query } = useRoute();
  const { identity } = useWebsiteIdentity();
  const siteName = identity?.site_title || identity?.site_name || FALLBACK_SITE_NAME;
  const siteDescription = identity?.meta_description || identity?.description || null;

  // Redirect warisan satu kali: `#/berita/x` -> `/berita/x` tanpa reload.
  useEffect(() => {
    if (window.location.hash.startsWith("#/")) {
      const clean = window.location.hash.slice(1) || "/";
      window.history.replaceState(null, "", clean);
      window.dispatchEvent(new Event(ROUTE_CHANGE_EVENT));
    }
  }, []);

  // Redirect legacy /pelayanan-publik -> /layanan (URL baru dari API service)
  useEffect(() => {
    if (path === "/layanan") {
      window.history.replaceState(null, "", "/layanan");
      window.dispatchEvent(new Event(ROUTE_CHANGE_EVENT));
    }
  }, [path]);

  // Intersepsi klik tautan internal agar pindah halaman tanpa reload
  // (SPA dengan URL bersih). Tautan backend (/be, /api, /storage),
  // eksternal, tab baru, dan unduhan dibiarkan ke browser.
  useEffect(() => {
    const onClick = (event: MouseEvent) => {
      if (event.defaultPrevented || event.button !== 0) return;
      if (event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return;
      const anchor = (event.target as HTMLElement).closest?.("a[href]");
      if (!anchor) return;
      const href = anchor.getAttribute("href") ?? "";
      if (!href.startsWith("/") || href.startsWith("//")) return;
      const clean = href.split("?")[0].split("#")[0];
      if (
        clean === "/be" || clean.startsWith("/be/") ||
        clean === "/api" || clean.startsWith("/api/") ||
        clean === "/storage" || clean.startsWith("/storage/")
      ) {
        return;
      }
      if (anchor.getAttribute("target") === "_blank" || anchor.hasAttribute("download")) return;
      event.preventDefault();
      navigate(href);
    };
    document.addEventListener("click", onClick);
    return () => document.removeEventListener("click", onClick);
  }, []);

  // SEO global dari website_identities: favicon, og, twitter, json-ld organisasi
  useEffect(() => {
    if (!identity) return;
    if (identity.favicon_url) {
      // bust cache bila admin ganti favicon
      const v = identity.updated_at ? `?v=${encodeURIComponent(identity.updated_at)}` : "";
      setFavicon(`${identity.favicon_url}${v}`);
    } else if (identity.logo_url) {
      // fallback pakai logo bila favicon belum diupload
      setFavicon(identity.logo_url);
    }
    if (identity.og_image_url) {
      setMetaTag("property", "og:image", identity.og_image_url);
      setMetaTag("name", "twitter:image", identity.og_image_url);
    }
    setMetaTag("property", "og:site_name", siteName);
    setMetaTag("name", "twitter:card", "summary_large_image");
    setMetaTag("name", "twitter:site", identity.instagram_url || "");
    if (identity.meta_keywords) setMetaTag("name", "keywords", identity.meta_keywords);
    if (identity.google_site_verification) ensureGoogleSiteVerification(identity.google_site_verification);
    if (identity.google_analytics_id) ensureGoogleAnalytics(identity.google_analytics_id);

    // JSON-LD Organization / GovernmentOrganization untuk Knowledge Graph
    const sameAs = [identity.facebook_url, identity.instagram_url, identity.youtube_url, identity.tiktok_url].filter(Boolean) as string[];
    const logoAbs = identity.logo_url ? new URL(identity.logo_url, window.location.origin).href : `${window.location.origin}/assets/logo.png`;
    setJsonLd("org-website", {
      "@context": "https://schema.org",
      "@type": "GovernmentOrganization",
      name: siteName,
      alternateName: identity.site_name || undefined,
      url: window.location.origin,
      logo: logoAbs,
      description: siteDescription || identity.tagline || undefined,
      address: identity.address
        ? { "@type": "PostalAddress", streetAddress: identity.address }
        : undefined,
      telephone: identity.phone || undefined,
      email: identity.email || undefined,
      sameAs: sameAs.length ? sameAs : undefined,
    });
  }, [identity, siteName, siteDescription]);

  useEffect(() => {
    window.scrollTo({ top: 0, behavior: "auto" });
    // Head halaman detail dikelola NewsDetailPage / AlbumDetailPage / StaticPage / OfficialDetailPage / AgendaDetailPage setelah data dimuat.
    if (path === NEWS_DETAIL_PATH || path === ALBUM_DETAIL_PATH || path === PAGE_DETAIL_PATH || path === OFFICIAL_DETAIL_PATH || path === AGENDA_DETAIL_PATH) return;
    const title = `${pageTitles[path] ?? "Halaman"} | ${siteName}`;
    const description = ROUTE_DESCRIPTIONS[path] ?? siteDescription ?? ROUTE_DESCRIPTIONS["/"];
    const canonical = `${window.location.origin}${window.location.pathname}`;
    setDocumentTitle(title);
    setMetaTag("name", "description", description);
    setMetaTag("property", "og:type", "website");
    setMetaTag("property", "og:url", canonical);
    setMetaTag("property", "og:title", title);
    setMetaTag("property", "og:description", description);
    setMetaTag("property", "og:site_name", siteName);
    setMetaTag("name", "twitter:card", "summary_large_image");
    setMetaTag("name", "twitter:title", title);
    setMetaTag("name", "twitter:description", description);
    const ogImg = identity?.og_image_url || identity?.logo_url;
    if (ogImg) {
      const absImg = new URL(ogImg, window.location.origin).href;
      setMetaTag("property", "og:image", absImg);
      setMetaTag("name", "twitter:image", absImg);
    }
    if (identity?.meta_title) setMetaTag("name", "title", identity.meta_title);
    setCanonical(canonical);
  }, [path, slug, siteName, siteDescription, identity]);

  return (
    <SiteLayout path={path} showIntro={path === "/"}>
      <Suspense fallback={<PageLoading />}>
        <RoutedPage path={path} slug={slug} query={query} />
      </Suspense>
    </SiteLayout>
  );
}
