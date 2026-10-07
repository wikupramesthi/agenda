import { useEffect } from "react";
import { ApiError } from "../../app/api";
import { clearJsonLd, setCanonical, setDocumentTitle, setJsonLd, setMetaTag } from "../../app/seo";
import { useApiData } from "../../app/useApiData";
import { useWebsiteIdentity } from "../../app/WebsiteIdentityContext";
import { formatIdDate } from "../../data/articles";
import {
  fetchPageDetail,
  fetchPages,
  staticPageHref,
  type InlineSegment,
  type PageBlock,
  type StaticPageData,
} from "../../data/pages";
import { DataError } from "../common/DataError";
import { ShareButtons } from "../common/ShareButtons";

const SITE_SUFFIX = "DBMSDA Kota Bekasi";

// "2026-09-25 00:00:00" (WIB) -> "2026-09-25T00:00:00+07:00" untuk <time dateTime>.
function toIsoDateTime(value: string): string {
  const normalized = value.includes("T") ? value : value.replace(" ", "T");
  return /([+-]\d{2}:?\d{2}|Z)$/.test(normalized) ? normalized : `${normalized}+07:00`;
}

function renderInline(segments: InlineSegment[], keyPrefix: string) {
  return segments.map((segment, index) => {
    const key = `${keyPrefix}-${index}`;
    if (segment.bold && segment.italic) {
      return (
        <strong key={key}>
          <em>{segment.text}</em>
        </strong>
      );
    }
    if (segment.bold) return <strong key={key}>{segment.text}</strong>;
    if (segment.italic) return <em key={key}>{segment.text}</em>;
    return <span key={key}>{segment.text}</span>;
  });
}

function renderBlock(block: PageBlock, index: number) {
  if (block.kind === "heading") {
    return block.level === 3 ? (
      <h3 className="static-h3" key={index}>
        {block.text}
      </h3>
    ) : (
      <h2 className="static-h2" key={index}>
        {block.text}
      </h2>
    );
  }
  if (block.kind === "list") {
    const items = block.items.map((segments, itemIndex) => (
      <li key={itemIndex}>{renderInline(segments, `li-${index}-${itemIndex}`)}</li>
    ));
    return block.ordered ? (
      <ol className="static-list" key={index}>
        {items}
      </ol>
    ) : (
      <ul className="static-list" key={index}>
        {items}
      </ul>
    );
  }
  if (block.kind === "quote") {
    return (
      <blockquote className="static-quote" key={index}>
        <p>{renderInline(block.segments, `q-${index}`)}</p>
      </blockquote>
    );
  }
  return (
    <p className={index === 0 ? "static-lead" : undefined} key={index}>
      {renderInline(block.segments, `p-${index}`)}
    </p>
  );
}

// Halaman statis dinamis `/halaman/{slug}` dari `GET /api/pages/{slug}`.
// Layout institusional (beda dari halaman berita): hero band navy,
// banner overlap, grid konten + sidebar, dan kartu bantuan.
// Konten dirender sebagai elemen React dari blok aman (tanpa
// dangerouslySetInnerHTML) sehingga bebas HTML injection.
export function StaticPage({ slug }: { slug: string }) {
  const { data, loading, failed, error, reload } = useApiData(
    () =>
      Promise.all([
        fetchPageDetail(slug),
        fetchPages().catch((): StaticPageData[] => []),
      ]).then(([detail, list]) => ({
        detail,
        related: list.filter((item) => item.slug !== detail.slug).slice(0, 5),
      })),
    [slug],
    "halaman-statis",
  );
  const { identity } = useWebsiteIdentity();
  const siteName = identity?.site_title || identity?.site_name || SITE_SUFFIX;

  const page = data?.detail ?? null;
  const related = data?.related ?? [];

  useEffect(() => {
    if (!page) return;
    const title = `${page.title} | ${siteName}`;
    const description = (page.excerpt || page.paragraphs[0] || page.title).slice(0, 160);
    const canonical = `${window.location.origin}${window.location.pathname}`;
    const absoluteImage = page.image ? new URL(page.image, window.location.origin).href : "";
    setDocumentTitle(title);
    setMetaTag("name", "description", description);
    setMetaTag("property", "og:type", "article");
    setMetaTag("property", "og:url", canonical);
    setMetaTag("property", "og:title", page.title);
    setMetaTag("property", "og:description", description);
    if (absoluteImage) {
      setMetaTag("property", "og:image", absoluteImage);
      setMetaTag("property", "og:image:alt", page.title);
      setMetaTag("name", "twitter:card", "summary_large_image");
      setMetaTag("name", "twitter:image", absoluteImage);
    }
    setMetaTag("name", "twitter:title", page.title);
    setMetaTag("name", "twitter:description", description);
    setCanonical(canonical);
    setJsonLd("static-page", {
      "@context": "https://schema.org",
      "@type": "WebPage",
      name: page.title,
      description,
      url: canonical,
      ...(absoluteImage ? { image: absoluteImage } : {}),
    });
    return () => {
      clearJsonLd("static-page");
    };
  }, [page, siteName]);

  if (loading) {
    return (
      <div className="ui-wrap news-loading ui-section-top" role="status">
        <p>Memuat halaman…</p>
      </div>
    );
  }

  if (failed || !page) {
    const notFound = error instanceof ApiError && error.status === 404;
    return (
      <section className="ui-section ui-section-top">
        <div className="ui-wrap">
          <div className="empty-state" role="status">
            <h3>{notFound ? "Halaman tidak ditemukan" : "Halaman tidak dapat dimuat"}</h3>
            <p>
              {notFound
                ? "Tautan yang Anda buka tidak mengarah ke halaman mana pun."
                : "Periksa koneksi ke server API, lalu coba lagi."}
            </p>
            <div className="ui-btn">
              <a href="/">
                <span className="ui-btn-text">KEMBALI KE BERANDA</span>
                <i aria-hidden="true">›</i>
              </a>
            </div>
          </div>
          {!notFound && <DataError onRetry={reload} />}
        </div>
      </section>
    );
  }

  return (
    <>
      <section className="static-hero">
        <div className="ui-wrap">
          <span className="static-kicker">Informasi DBMSDA</span>
          <h1 className="static-title">{page.title}</h1>
          {page.publishedAt ? (
            <p className="static-meta">
              Diperbarui{" "}
              <time dateTime={toIsoDateTime(page.publishedAt)}>{formatIdDate(page.publishedAt)}</time>
            </p>
          ) : null}
        </div>
      </section>

      <div className="ui-wrap">
        {page.image ? (
          <figure className="static-banner">
            <img src={page.image} alt={page.title} />
          </figure>
        ) : null}

        <div className="static-grid">
          <article className="static-body">
            {page.blocks.length > 0 ? (
              page.blocks.map((block, index) => renderBlock(block, index))
            ) : (
              <div className="empty-state" role="status">
                <h3>Konten belum tersedia</h3>
                <p>Halaman ini belum memiliki isi.</p>
              </div>
            )}
          </article>

          <aside className="static-side" aria-label="Informasi pendukung">
            <div className="static-card">
              <h2 className="static-card-title">Bagikan halaman</h2>
              <ShareButtons title={page.title} />
            </div>

            {related.length > 0 ? (
              <nav className="static-card" aria-label="Halaman lainnya">
                <h2 className="static-card-title">Halaman lainnya</h2>
                <ul className="static-related">
                  {related.map((item) => (
                    <li key={item.uuid}>
                      <a href={staticPageHref(item)}>
                        <span aria-hidden="true">›</span> {item.title}
                      </a>
                    </li>
                  ))}
                </ul>
              </nav>
            ) : null}

            <div className="static-card static-help">
              <h2 className="static-card-title">Butuh bantuan?</h2>
              <p>Hubungi call center 112 untuk informasi lebih lanjut.</p>
              <div className="ui-btn">
                <a href="tel:112">
                  <span className="ui-btn-text">CALL CENTER 112</span>
                  <i aria-hidden="true">›</i>
                </a>
              </div>
            </div>
          </aside>
        </div>
      </div>
    </>
  );
}
