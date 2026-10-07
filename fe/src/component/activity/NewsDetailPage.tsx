import { useEffect, useRef, useState } from "react";
import { ApiError } from "../../app/api";
import {
  clearJsonLd,
  setCanonical,
  setDocumentTitle,
  setJsonLd,
  setMetaTag,
} from "../../app/seo";
import { useApiData } from "../../app/useApiData";
import {
  fetchArticleDetail,
  fetchPopularArticles,
  type ArticleDetail,
} from "../../data/articles";
import type { News } from "../../data/siteData";
import { NewsCard } from "../blog/BlogCard";
import { ShareButtons } from "../common/ShareButtons";

const SITE_SUFFIX = "DBMSDA Kota Bekasi";

export function NewsDetailPage({ slug }: { slug: string }) {
  const { data, loading, failed, error } = useApiData(
    () =>
      Promise.all([
        fetchArticleDetail(slug),
        // Ambil 7 agar setelah mengeluarkan artikel aktif tersisa 6.
        fetchPopularArticles(7).catch((): News[] => []),
      ]).then(([detail, list]) => ({
        detail,
        popular: list
          .filter((item) => item.slug !== detail.slug && item.title !== detail.title)
          .slice(0, 6),
      })),
    [slug],
    "berita-detail",
  );
  const trackRef = useRef<HTMLDivElement>(null);
  const [activePhoto, setActivePhoto] = useState(0);

  const article: ArticleDetail | null = data?.detail ?? null;
  const popular: News[] = data?.popular ?? [];
  const notFound = error instanceof ApiError && error.status === 404;
  const gallery = article?.gallery?.length ? article.gallery : article ? [article.image] : [];
  const hasSlider = gallery.length > 1;
  const selectPhoto = (index: number) =>
    setActivePhoto(((index % gallery.length) + gallery.length) % gallery.length);

  // Kembali ke foto pertama setiap ganti artikel.
  useEffect(() => {
    setActivePhoto(0);
  }, [slug, article?.slug]);

  useEffect(() => {
    if (!article) return;
    // Head + structured data per artikel (sinyal Google Berita/Publisher).
    // Crawler share (WA/FB/X) tidak mengeksekusi JS — mereka dilayani
    // snapshot server (SeoSnapshotController via nginx). Meta di sini
    // untuk browser + parity: og:image WAJIB absolut (relatif diabaikan
    // crawler sehingga gambar tidak nongol), jadi relatif seperti
    // `/storage/...` atau `./assets/...` diabsolutkan ke origin.
    const pageTitle = `${article.title} | ${SITE_SUFFIX}`;
    const description = (article.excerpt || article.paragraphs[0] || article.title).slice(0, 160);
    const canonical = `${window.location.origin}${window.location.pathname}`;
    const absoluteImage = article.image
      ? new URL(article.image, `${window.location.origin}/`).href
      : "";
    setDocumentTitle(pageTitle);
    setMetaTag("name", "description", description);
    setMetaTag("property", "og:type", "article");
    setMetaTag("property", "og:url", canonical);
    setMetaTag("property", "og:title", article.title);
    setMetaTag("property", "og:description", description);
    if (absoluteImage) {
      setMetaTag("property", "og:image", absoluteImage);
      setMetaTag("property", "og:image:alt", article.title);
      setMetaTag("name", "twitter:card", "summary_large_image");
      setMetaTag("name", "twitter:title", article.title);
      setMetaTag("name", "twitter:description", description);
      setMetaTag("name", "twitter:image", absoluteImage);
    }
    if (article.dateTime) setMetaTag("property", "article:published_time", article.dateTime);
    if (article.category) setMetaTag("property", "article:section", article.category);
    setMetaTag("property", "article:author", article.author);
    setCanonical(canonical);
    setJsonLd("news-article", {
      "@context": "https://schema.org",
      "@type": "NewsArticle",
      headline: article.title,
      description,
      ...(article.dateTime ? { datePublished: article.dateTime } : {}),
      author: { "@type": "Organization", name: article.author },
      publisher: {
        "@type": "Organization",
        name: "DBMSDA Kota Bekasi",
        logo: { "@type": "ImageObject", url: `${window.location.origin}/assets/logo.png` },
      },
      mainEntityOfPage: canonical,
    });
    return () => {
      clearJsonLd("news-article");
    };
  }, [article]);

  const slidePopular = (direction: 1 | -1) => {
    const track = trackRef.current;
    if (!track) return;
    const card = track.querySelector<HTMLElement>(".related-card");
    const step = card ? card.offsetWidth + 22 : 320;
    track.scrollBy({
      left: direction * step,
      behavior: window.matchMedia("(prefers-reduced-motion: reduce)").matches ? "auto" : "smooth",
    });
  };

  if (!article) {
    const failedLoad = failed || !loading;
    return (
      <>
        {failedLoad ? (
          <section className="ui-section">
            <div className="ui-wrap">
              <div className="empty-state" role="status">
                <h3>{notFound ? "Berita tidak ditemukan" : "Berita tidak dapat dimuat"}</h3>
                <p>
                  {notFound
                    ? "Tautan yang Anda buka tidak mengarah ke artikel mana pun."
                    : "Periksa koneksi ke server API, lalu coba lagi."}
                </p>
                <div className="ui-btn">
                  <a href="/berita">
                    <span className="ui-btn-text">KEMBALI KE BERITA</span>
                    <i aria-hidden="true">›</i>
                  </a>
                </div>
              </div>
            </div>
          </section>
        ) : (
          <div className="ui-wrap news-loading" role="status">
            <p>Memuat berita…</p>
          </div>
        )}
      </>
    );
  }

  const body = article.paragraphs.length > 0
    ? article.paragraphs
    : article.excerpt
      ? [article.excerpt]
      : [];
  const [lead, ...rest] = body;

  return (
    <>
      <article className="news-detail ui-section">
        <div className="ui-wrap news-detail-shell">
          <div className="news-detail-kicker">
            <span className="photo-kicker">{article.category ?? "Berita"}</span>
          </div>
          <h1 className="news-detail-title">{article.title}</h1>
          <div className="news-detail-meta">
            <time dateTime={article.dateTime ?? article.date}>{article.date}</time>
            <span aria-hidden="true">•</span>
            <span>Oleh {article.author}</span>
            <span aria-hidden="true">•</span>
            <span>{article.views.toLocaleString("id-ID")} kali dibaca</span>
          </div>
          <ShareButtons title={article.title} />
          {hasSlider ? (
            <div className="photo-viewer">
              <div className="photo-stage" aria-live="polite">
                <img
                  alt={`${article.title}, foto ${activePhoto + 1} dari ${gallery.length}`}
                  src={gallery[activePhoto]}
                />
                <button className="photo-arrow photo-arrow-prev" aria-label="Foto sebelumnya" onClick={() => selectPhoto(activePhoto - 1)} type="button">‹</button>
                <button className="photo-arrow photo-arrow-next" aria-label="Foto berikutnya" onClick={() => selectPhoto(activePhoto + 1)} type="button">›</button>
              </div>
              <div className="photo-thumbs" role="tablist" aria-label="Daftar foto berita">
                {gallery.map((photo, index) => <button role="tab" aria-selected={activePhoto === index} aria-label={`Tampilkan foto ${index + 1}`} aria-current={activePhoto === index || undefined} className={activePhoto === index ? "is-active" : ""} key={`${photo}-${index}`} onClick={() => selectPhoto(index)} type="button"><img alt="" src={photo} loading="lazy" /></button>)}
              </div>
            </div>
          ) : (
            <figure className="news-detail-hero">
              <img src={article.image} alt={article.title} />
            </figure>
          )}
          {body.length > 0 && (
            <div className="news-detail-body">
              {lead && <p className="news-lead">{lead}</p>}
              {rest.map((paragraph, index) => (
                <p key={index}>{paragraph}</p>
              ))}
            </div>
          )}
          {article.tags.length > 0 && (
            <div className="news-detail-tags">
              <span>Tag:</span>
              {article.tags.map((tag) => (
                <span className="news-tag" key={tag}>{tag}</span>
              ))}
            </div>
          )}
        </div>
      </article>
      {popular.length > 0 && (
        <section className="ui-stories ui-section" aria-label="Berita populer">
          <div className="ui-wrap">
            <div className="ui-sec-head related-head">
              <h2 className="ui-sec-title">BERITA POPULER</h2>
              <div className="related-nav">
                <button type="button" onClick={() => slidePopular(-1)} aria-label="Geser berita populer ke kiri">‹</button>
                <button type="button" onClick={() => slidePopular(1)} aria-label="Geser berita populer ke kanan">›</button>
              </div>
            </div>
            <div className="related-track" ref={trackRef}>
              {popular.map((item) => (
                <div className="related-card" key={item.title}>
                  <NewsCard item={item} />
                </div>
              ))}
            </div>
          </div>
        </section>
      )}
    </>
  );
}
