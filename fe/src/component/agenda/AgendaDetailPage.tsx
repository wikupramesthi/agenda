import { useEffect } from "react";
import { ApiError } from "../../app/api";
import { clearJsonLd, setCanonical, setDocumentTitle, setJsonLd, setMetaTag } from "../../app/seo";
import { useApiData } from "../../app/useApiData";
import { useWebsiteIdentity } from "../../app/WebsiteIdentityContext";
import { fetchAgendaDetail } from "../../data/agenda";
import { DataError } from "../common/DataError";
import { ShareButtons } from "../common/ShareButtons";

const SITE_SUFFIX = "DBMSDA Kota Bekasi";

export function AgendaDetailPage({ slug }: { slug: string }) {
  const { data: agenda, loading, failed, error, reload } = useApiData(() => fetchAgendaDetail(slug), [slug], `agenda-detail-${slug}`);
  const { identity } = useWebsiteIdentity();
  const siteName = identity?.site_title || identity?.site_name || SITE_SUFFIX;

  useEffect(() => {
    if (!agenda) return;
    const title = `${agenda.title} | ${siteName}`;
    const description = agenda.description.slice(0, 160) || agenda.title;
    const canonical = `${window.location.origin}${window.location.pathname}`;
    const absImg = agenda.image ? new URL(agenda.image, window.location.origin).href : "";
    setDocumentTitle(title);
    setMetaTag("name", "description", description);
    setMetaTag("property", "og:type", "article");
    setMetaTag("property", "og:url", canonical);
    setMetaTag("property", "og:title", agenda.title);
    setMetaTag("property", "og:description", description);
    if (absImg) {
      setMetaTag("property", "og:image", absImg);
      setMetaTag("name", "twitter:card", "summary_large_image");
      setMetaTag("name", "twitter:image", absImg);
    }
    setCanonical(canonical);
    setJsonLd("agenda-detail", {
      "@context": "https://schema.org",
      "@type": "Event",
      name: agenda.title,
      description,
      startDate: agenda.date || undefined,
      location: agenda.location ? { "@type": "Place", name: agenda.location } : undefined,
      url: canonical,
      ...(absImg ? { image: absImg } : {}),
    });
    return () => clearJsonLd("agenda-detail");
  }, [agenda, siteName]);

  if (loading) return <div className="ui-wrap news-loading ui-section-top" role="status"><p>Memuat agenda…</p></div>;
  if (failed || !agenda) {
    const notFound = error instanceof ApiError && error.status === 404;
    return (
      <section className="ui-section ui-section-top">
        <div className="ui-wrap">
          <div className="empty-state" role="status">
            <h3>{notFound ? "Agenda tidak ditemukan" : "Agenda tidak dapat dimuat"}</h3>
            <p>{notFound ? "Tautan agenda tidak valid." : "Periksa koneksi API."}</p>
            <div className="ui-btn"><a href="/agenda"><span className="ui-btn-text">KEMBALI KE AGENDA</span><i aria-hidden="true">›</i></a></div>
          </div>
          {!notFound && <DataError onRetry={reload} />}
        </div>
      </section>
    );
  }

  return (
    <>
      <section className="agenda-hero">
        <div className="ui-wrap">
          <span className="agenda-kicker">{agenda.dateLabel || "Agenda DBMSDA"}</span>
          <h1 className="agenda-title">{agenda.title}</h1>
          <div className="agenda-meta">
            {agenda.date && <span>📅 {agenda.date} {agenda.timeStart ? `• ${agenda.timeStart}` : ""} {agenda.timeEnd ? `- ${agenda.timeEnd}` : ""}</span>}
            {agenda.location && <span>📍 {agenda.location}</span>}
          </div>
        </div>
      </section>
      <div className="ui-wrap">
        {agenda.image && <figure className="agenda-banner"><img src={agenda.image} alt={agenda.title} /></figure>}
        <div className="agenda-detail-grid">
          <article className="agenda-body">
            {agenda.paragraphs.length > 0 ? agenda.paragraphs.map((p, i) => <p key={i}>{p}</p>) : <p>{agenda.description || "Detail agenda belum tersedia."}</p>}
          </article>
          <aside className="agenda-side">
            <div className="agenda-card-side">
              <h3>Detail</h3>
              <dl>
                <div><dt>Tanggal</dt><dd>{agenda.date || "-"}</dd></div>
                <div><dt>Waktu</dt><dd>{agenda.timeStart ? `${agenda.timeStart} - ${agenda.timeEnd ?? "selesai"}` : "-"}</dd></div>
                <div><dt>Lokasi</dt><dd>{agenda.location || "-"}</dd></div>
              </dl>
              <div style={{ marginTop: 12 }}><ShareButtons title={agenda.title} /></div>
            </div>
            <div className="ui-btn"><a href="/agenda"><span className="ui-btn-text">KEMBALI KE AGENDA</span><i aria-hidden="true">›</i></a></div>
          </aside>
        </div>
      </div>
    </>
  );
}
