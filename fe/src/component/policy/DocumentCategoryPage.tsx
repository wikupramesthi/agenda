import { useMemo, useState } from "react";
import { SEARCH_MAX_LENGTH } from "../../app/constants";
import { useApiData } from "../../app/useApiData";
import { fetchDocumentsByCategory, type PublicDocument } from "../../data/documents";
import { DataError } from "../common/DataError";
import { DocumentCard } from "./DocumentCard";

// Halaman satu kategori dokumen PPID dengan pencarian lokal.
// Data dari `GET /api/documents/category/{slug}`; cangkang tetap tampil
// saat API gagal (blok error + tombol muat ulang) atau data kosong.
// Tanpa thumbnail -> logo (via DocumentCard).
export function DocumentCategoryPage({ title, categorySlug }: { title: string; categorySlug: string }) {
  const { data, loading, failed, reload } = useApiData(
    () => fetchDocumentsByCategory(categorySlug),
    [categorySlug],
    `dokumen-${categorySlug}`,
  );
  const items: PublicDocument[] = data ?? [];
  const [search, setSearch] = useState("");

  const normalizedSearch = search.toLocaleLowerCase("id-ID").trim();
  const searching = normalizedSearch.length > 0;
  const filtered = useMemo(() => {
    if (!searching) return items;
    return items.filter((item) =>
      `${item.title} ${item.excerpt}`
        .toLocaleLowerCase("id-ID")
        .includes(normalizedSearch),
    );
  }, [items, searching, normalizedSearch]);

  if (loading) {
    return (
      <>
        <div className="ui-wrap" role="status">
          <p>Memuat dokumen…</p>
        </div>
      </>
    );
  }

  if (failed) {
    return (
      <>
        <section className="ui-section">
          <DataError onRetry={reload} />
        </section>
      </>
    );
  }

  return (
    <>
      <section className="ui-report-page ui-section ui-section-top">
        <div className="ui-wrap">
          <div className="ui-sec-head">
            <h1 className="ui-sec-title ink-blue">{title}</h1>
          </div>
          {items.length > 0 && (
            <div className="news-list-head">
              <p className="news-search-count" role="status">
                Menampilkan {filtered.length} dari {items.length} dokumen
                {searching && ` untuk “${search.trim()}”`}
              </p>
              <div className="news-list-filters">
                <form
                  className="news-search"
                  role="search"
                  onSubmit={(event) => event.preventDefault()}
                >
                  <input
                    type="search"
                    value={search}
                    maxLength={SEARCH_MAX_LENGTH}
                    placeholder="Cari dokumen…"
                    aria-label={`Cari dokumen ${title}`}
                    onChange={(event) => setSearch(event.target.value)}
                  />
                </form>
              </div>
            </div>
          )}
          {filtered.length > 0 ? (
            <div className="ui-doc-list ui-doc-logo">
              <div className="ui-doc-row">
                {filtered.map((item) => (
                  <DocumentCard key={item.uuid} item={item} />
                ))}
              </div>
            </div>
          ) : items.length > 0 ? (
            <div className="empty-state" role="status">
              <h3>Dokumen tidak ditemukan</h3>
              <p>Coba gunakan kata kunci yang lebih singkat.</p>
              <div className="ui-btn">
                <button type="button" onClick={() => setSearch("")}>
                  <span className="ui-btn-text">TAMPILKAN SEMUA DOKUMEN</span>
                  <i aria-hidden="true">›</i>
                </button>
              </div>
            </div>
          ) : (
            <div className="empty-state" role="status">
              <h3>Belum ada dokumen</h3>
              <p>Dokumen kategori ini akan tampil di sini setelah ditambahkan melalui panel admin.</p>
            </div>
          )}
        </div>
      </section>
    </>
  );
}
