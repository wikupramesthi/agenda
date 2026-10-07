import { useEffect, useState } from "react";
import { ApiError } from "../../app/api";
import { setCanonical, setDocumentTitle, setJsonLd, setMetaTag, clearJsonLd } from "../../app/seo";
import { useApiData } from "../../app/useApiData";
import { useWebsiteIdentity } from "../../app/WebsiteIdentityContext";
import { fetchAlbumDetail } from "../../data/albums";
import { DataError } from "../common/DataError";
import { ShareButtons } from "../common/ShareButtons";

export function AlbumDetailPage({ uuid }: { uuid: string }) {
  const { data: album, loading, failed, error, reload } = useApiData(() => fetchAlbumDetail(uuid), [uuid], "album-detail");
  const { identity } = useWebsiteIdentity();
  const [lightbox, setLightbox] = useState<number | null>(null);
  const siteName = identity?.site_title || identity?.site_name || "DBMSDA Kota Bekasi";

  useEffect(() => {
    if (!album) return;
    const title = `${album.nama} | Album | ${siteName}`;
    const desc = (album.deskripsi || `Album ${album.nama} berisi ${album.foto_count} foto kegiatan DBMSDA Kota Bekasi.`).slice(0, 160);
    const canonical = `${window.location.origin}${window.location.pathname}`;
    // cover cukup 1 foto pertama
    const img = album.fotos[0]?.gambar || album.cover_url || "";
    const absImg = img ? new URL(img, window.location.origin).href : "";
    setDocumentTitle(title);
    setMetaTag("name", "description", desc);
    setMetaTag("property", "og:type", "article");
    setMetaTag("property", "og:url", canonical);
    setMetaTag("property", "og:title", title);
    setMetaTag("property", "og:description", desc);
    if (absImg) {
      setMetaTag("property", "og:image", absImg);
      setMetaTag("name", "twitter:image", absImg);
    }
    setMetaTag("name", "twitter:card", "summary_large_image");
    setMetaTag("name", "twitter:title", title);
    setMetaTag("name", "twitter:description", desc);
    setCanonical(canonical);
    setJsonLd("album-detail", {
      "@context": "https://schema.org",
      "@type": "ImageGallery",
      name: album.nama,
      description: desc,
      url: canonical,
      ...(absImg ? { image: album.fotos.slice(0, 5).map((f) => new URL(f.gambar, window.location.origin).href) } : {}),
    });
    return () => clearJsonLd("album-detail");
  }, [album, siteName]);

  useEffect(() => {
    if (lightbox === null) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setLightbox(null);
      if (!album) return;
      if (e.key === "ArrowRight") setLightbox((v) => (v === null ? v : (v + 1) % album.fotos.length));
      if (e.key === "ArrowLeft") setLightbox((v) => (v === null ? v : (v - 1 + album.fotos.length) % album.fotos.length));
    };
    window.addEventListener("keydown", onKey);
    document.body.style.overflow = "hidden";
    return () => {
      window.removeEventListener("keydown", onKey);
      document.body.style.overflow = "";
    };
  }, [lightbox, album]);

  if (loading) {
    return (
      <div className="ui-wrap news-loading" role="status">
        <p>Memuat album…</p>
      </div>
    );
  }
  if (failed || !album) {
    const notFound = error instanceof ApiError && error.status === 404;
    return (
      <section className="ui-section">
        <div className="ui-wrap">
          <div className="empty-state" role="status">
            <h3>{notFound ? "Album tidak ditemukan" : "Album tidak dapat dimuat"}</h3>
            <p>{notFound ? "Tautan yang Anda buka tidak mengarah ke album mana pun." : "Periksa koneksi lalu coba lagi."}</p>
            <div className="ui-btn">
              <a href="/album">
                <span className="ui-btn-text">KEMBALI KE ALBUM</span>
                <i aria-hidden="true">›</i>
              </a>
            </div>
          </div>
          {!notFound && <DataError onRetry={reload} />}
        </div>
      </section>
    );
  }

  const active = lightbox !== null ? album.fotos[lightbox] : null;

  return (
    <>
      <section className="ui-section ui-section-top album-detail">
        <div className="ui-wrap">
          <nav className="album-breadcrumb" aria-label="Breadcrumb">
            <a href="/">Beranda</a>
            <span aria-hidden="true">›</span>
            <a href="/album">Album</a>
            <span aria-hidden="true">›</span>
            <span aria-current="page">{album.nama}</span>
          </nav>
          <span className="album-kicker">Album · {album.foto_count} foto</span>
          <h1 className="album-h1-detail">{album.nama}</h1>
          {album.deskripsi ? <p className="album-sub">{album.deskripsi}</p> : null}
          <ShareButtons title={album.nama} />

          {album.fotos.length === 0 ? (
            <div className="empty-state" role="status">
              <h3>Belum ada foto</h3>
              <p>Album ini belum berisi foto.</p>
            </div>
          ) : (
            <div className="album-photo-grid">
              {album.fotos.map((f, i) => (
                <button key={f.uuid} type="button" className="album-photo" onClick={() => setLightbox(i)} aria-label={`Perbesar foto ${i + 1}: ${f.nama}`}>
                  <img src={f.gambar} alt={f.nama} loading="lazy" />
                  <span className="album-photo-cap">{f.nama}</span>
                </button>
              ))}
            </div>
          )}
        </div>
      </section>

      {active && (
        <div className="album-lightbox" role="dialog" aria-modal="true" aria-label={`Foto ${active.nama}`} onClick={() => setLightbox(null)}>
          <div className="album-lightbox-inner" onClick={(e) => e.stopPropagation()}>
            <img src={active.gambar} alt={active.nama} />
            <div className="album-lightbox-bar">
              <span>
                {(lightbox ?? 0) + 1} / {album.fotos.length} · {active.nama}
              </span>
              <div>
                <button type="button" onClick={() => setLightbox(((lightbox ?? 0) - 1 + album.fotos.length) % album.fotos.length)} aria-label="Foto sebelumnya">
                  ‹
                </button>
                <button type="button" onClick={() => setLightbox((((lightbox ?? 0) + 1) % album.fotos.length))} aria-label="Foto berikutnya">
                  ›
                </button>
                <button type="button" onClick={() => setLightbox(null)} aria-label="Tutup">
                  ✕
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
