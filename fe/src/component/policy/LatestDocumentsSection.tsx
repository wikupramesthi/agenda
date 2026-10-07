import { useApiData } from "../../app/useApiData";
import { fetchLatestDocumentsWithThumbnails } from "../../data/documents";
import { DataError } from "../common/DataError";
import { SectionHeading } from "../common/SectionHeading";
import { DocumentCard } from "./DocumentCard";

// Sorotan dokumen di beranda (menggantikan seksi pengumuman statis):
// 4 dokumen terbaru yang memiliki thumbnail, dengan tautan ke `/dokumen`.
export function LatestDocumentsSection() {
  const { data, loading, failed, reload } = useApiData(
    () => fetchLatestDocumentsWithThumbnails(4),
    [],
    "beranda-dokumen",
  );
  const items = data ?? [];

  return (
    <section className="ui-docs-sec ui-section ui-section-top" aria-label="Dokumen terbaru">
      <div className="ui-wrap">
        <SectionHeading title="DOKUMEN" actionLabel="LIHAT DOKUMEN LAINNYA" actionHref="/dokumen" />
        {items.length > 0 ? (
          <div className="ui-doc-list">
            <div className="ui-doc-row">
              {items.map((item) => (
                <DocumentCard key={item.uuid} item={item} titleTag="h3" />
              ))}
            </div>
          </div>
        ) : failed ? (
          <DataError onRetry={reload} />
        ) : loading ? (
          <div role="status"><p>Memuat dokumen terbaru…</p></div>
        ) : (
          <div className="empty-state" role="status">
            <h3>Belum ada dokumen bergambar</h3>
            <p>
              Dokumen terbaru akan tampil di sini setelah thumbnail ditambahkan
              melalui panel admin. <a href="/dokumen">Lihat semua dokumen</a>.
            </p>
          </div>
        )}
      </div>
    </section>
  );
}
