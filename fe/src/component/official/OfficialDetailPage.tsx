import { useEffect } from "react";
import { ApiError } from "../../app/api";
import { clearJsonLd, setCanonical, setDocumentTitle, setJsonLd, setMetaTag } from "../../app/seo";
import { useApiData } from "../../app/useApiData";
import { useWebsiteIdentity } from "../../app/WebsiteIdentityContext";
import { fetchOfficialDetail } from "../../data/officials";
import { DataError } from "../common/DataError";
import { ShareButtons } from "../common/ShareButtons";

const SITE_SUFFIX = "DBMSDA Kota Bekasi";

function initials(name: string) {
  return name.split(" ").map((w) => w[0]).slice(0, 2).join("");
}

export function OfficialDetailPage({ uuid }: { uuid: string }) {
  const { data: official, loading, failed, error, reload } = useApiData(() => fetchOfficialDetail(uuid), [uuid], `official-${uuid}`);
  const { identity } = useWebsiteIdentity();
  const siteName = identity?.site_title || identity?.site_name || SITE_SUFFIX;

  useEffect(() => {
    if (!official) return;
    const title = `${official.name} - ${official.role} | ${siteName}`;
    const description = official.paragraphs[0]?.slice(0, 160) || `${official.name} - ${official.role} DBMSDA Kota Bekasi`;
    const canonical = `${window.location.origin}${window.location.pathname}`;
    const absoluteImage = official.image ? new URL(official.image, window.location.origin).href : "";
    setDocumentTitle(title);
    setMetaTag("name", "description", description);
    setMetaTag("property", "og:type", "profile");
    setMetaTag("property", "og:url", canonical);
    setMetaTag("property", "og:title", official.name);
    setMetaTag("property", "og:description", description);
    if (absoluteImage) {
      setMetaTag("property", "og:image", absoluteImage);
      setMetaTag("property", "og:image:alt", official.name);
      setMetaTag("name", "twitter:card", "summary_large_image");
      setMetaTag("name", "twitter:image", absoluteImage);
    }
    setCanonical(canonical);
    setJsonLd("official-detail", {
      "@context": "https://schema.org",
      "@type": "Person",
      name: official.name,
      jobTitle: official.role,
      description,
      url: canonical,
      ...(absoluteImage ? { image: absoluteImage } : {}),
    });
    return () => clearJsonLd("official-detail");
  }, [official, siteName]);

  if (loading) {
    return <div className="ui-wrap news-loading ui-section-top" role="status"><p>Memuat data pejabat…</p></div>;
  }
  if (failed || !official) {
    const notFound = error instanceof ApiError && error.status === 404;
    return (
      <section className="ui-section ui-section-top">
        <div className="ui-wrap">
          <div className="empty-state" role="status">
            <h3>{notFound ? "Pejabat tidak ditemukan" : "Data pejabat tidak dapat dimuat"}</h3>
            <p>{notFound ? "Tautan yang Anda buka tidak mengarah ke pejabat mana pun." : "Periksa koneksi ke server API, lalu coba lagi."}</p>
            <div className="ui-btn"><a href="/informasi-pejabat"><span className="ui-btn-text">KEMBALI KE DAFTAR PEJABAT</span><i aria-hidden="true">›</i></a></div>
          </div>
          {!notFound && <DataError onRetry={reload} />}
        </div>
      </section>
    );
  }

  return (
    <>
      <section className="official-hero">
        <div className="ui-wrap">
          <span className="official-kicker">{official.role}</span>
          <h1 className="official-name">{official.name}</h1>
          {official.departments.length > 0 && <p className="official-depts">{official.departments.join(" • ")}</p>}
        </div>
      </section>

      <div className="ui-wrap">
        <div className="official-detail-grid">
          <div className="official-photo-card">
            {official.image ? (
              <img src={official.image} alt={official.name} className="official-photo-img" />
            ) : (
              <div className="official-photo-placeholder" aria-hidden="true"><span>{initials(official.name)}</span></div>
            )}
            <div className="official-photo-meta">
              <strong>{official.name}</strong>
              <span>{official.role}</span>
            </div>
            <div className="official-share">
              <ShareButtons title={`${official.name} - ${official.role}`} />
            </div>
          </div>

          <article className="official-bio">
            <div className="official-bio-head">
              <h2>Biodata</h2>
            </div>
            <dl className="official-meta">
              <div><dt>Nama</dt><dd>{official.name}</dd></div>
              <div><dt>Jabatan</dt><dd>{official.role}</dd></div>
              {official.nip && <div><dt>NIP</dt><dd>{official.nip}</dd></div>}
            </dl>

            {official.paragraphs.length > 0 ? (
              <div className="official-riwayat">
                <h3>Riwayat Pendidikan &amp; Karir</h3>
                {official.paragraphs.map((p, i) => (
                  <p key={i} className={i === 0 ? "official-lead" : undefined}>{p}</p>
                ))}
              </div>
            ) : (
              <div className="official-riwayat"><p style={{ color: "#6b6b8a" }}>Riwayat belum tersedia.</p></div>
            )}

            <div className="ui-btn" style={{ marginTop: 18 }}>
              <a href="/informasi-pejabat"><span className="ui-btn-text">KEMBALI KE DAFTAR</span><i aria-hidden="true">›</i></a>
            </div>
          </article>
        </div>
      </div>
    </>
  );
}
