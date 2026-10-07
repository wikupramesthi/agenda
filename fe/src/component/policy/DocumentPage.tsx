import { useMemo, useState } from "react";
import { SEARCH_MAX_LENGTH } from "../../app/constants";
import { useApiData } from "../../app/useApiData";
import {
  fetchDocumentCategories,
  fetchDocuments,
  type BackendDocumentCategory,
  type PublicDocument,
} from "../../data/documents";
import { DataError } from "../common/DataError";
import { DocumentCard } from "./DocumentCard";

const PAGE_SIZE = 12;

// Nomor halaman ringkas: 1 … jendela … terakhir.
function pageNumbers(page: number, total: number): (number | "…")[] {
  if (total <= 7) return Array.from({ length: total }, (_, i) => i + 1);
  const window = [page - 1, page, page + 1].filter((n) => n > 1 && n < total);
  const set = [1, ...window, total];
  const out: (number | "…")[] = [];
  set.forEach((n, i) => {
    if (i > 0 && n - set[i - 1] > 1) out.push("…");
    out.push(n);
  });
  return out;
}

function Pagination({ page, total, onChange }: { page: number; total: number; onChange: (page: number) => void }) {
  if (total < 2) return null;
  return (
    <nav className="pagination" aria-label="Halaman dokumen">
      <button type="button" onClick={() => onChange(page - 1)} disabled={page <= 1} aria-label="Halaman sebelumnya">‹</button>
      {pageNumbers(page, total).map((n, i) =>
        n === "…" ? (
          <span className="pagination-gap" key={`gap-${i}`} aria-hidden="true">…</span>
        ) : (
          <button
            type="button"
            key={n}
            onClick={() => onChange(n)}
            aria-current={n === page ? "page" : undefined}
            aria-label={`Halaman ${n}`}
          >
            {n}
          </button>
        ),
      )}
      <button type="button" onClick={() => onChange(page + 1)} disabled={page >= total} aria-label="Halaman berikutnya">›</button>
    </nav>
  );
}

// Halaman `/dokumen`: seluruh dokumen publik dari `GET /api/documents`
// dengan pencarian judul/keterangan + filter kategori dari
// `GET /api/document-categories`. Kategori API gagal -> fallback ke
// kategori yang muncul di data. Tanpa thumbnail -> logo.
export function DocumentPage() {
  const { data, loading, failed, reload } = useApiData(
    () =>
      Promise.all([
        fetchDocuments(),
        fetchDocumentCategories().catch((): BackendDocumentCategory[] => []),
      ]).then(([documents, categories]) => ({ documents, categories })),
    [],
    "dokumen",
  );
  const items: PublicDocument[] = data?.documents ?? [];
  const apiCategories = data?.categories ?? [];
  const [search, setSearch] = useState("");
  const [categorySlug, setCategorySlug] = useState("");
  const [page, setPage] = useState(1);

  const normalizedSearch = search.toLocaleLowerCase("id-ID");
  const searching = normalizedSearch.trim().length > 0;
  const filtering = categorySlug.length > 0;

  // Opsi filter: kategori API yang benar-benar punya dokumen; kalau API
  // kategori gagal/kosong, pakai kategori yang muncul di data.
  const availableCategories = useMemo(() => {
    const bySlug = new Map<string, string>();
    items.forEach((item) => {
      if (item.categorySlug && !bySlug.has(item.categorySlug)) {
        bySlug.set(item.categorySlug, item.category);
      }
    });
    const fromApi = apiCategories.filter((entry) => bySlug.has(entry.slug));
    if (fromApi.length > 0) return fromApi;
    return [...bySlug.entries()].map(([slug, name]) => ({ slug, name }));
  }, [items, apiCategories]);

  const activeCategoryName =
    availableCategories.find((entry) => entry.slug === categorySlug)?.name ?? "";

  const filtered = useMemo(
    () =>
      items.filter((item) => {
        if (filtering && item.categorySlug !== categorySlug) return false;
        if (!searching) return true;
        return `${item.title} ${item.excerpt} ${item.category}`
          .toLocaleLowerCase("id-ID")
          .includes(normalizedSearch.trim());
      }),
    [items, searching, filtering, categorySlug, normalizedSearch],
  );

  const totalPages = Math.max(1, Math.ceil(filtered.length / PAGE_SIZE));
  const safePage = Math.min(page, totalPages);
  const pageItems = filtered.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE);

  const changePage = (next: number) => {
    setPage(Math.min(Math.max(1, next), totalPages));
    document.querySelector(".doc-list-grid")?.scrollIntoView({ block: "start" });
  };

  const clearFilters = () => {
    setSearch("");
    setCategorySlug("");
    setPage(1);
  };

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
      <section className="ui-report-page ui-section ui-section-top doc-list-grid">
        <div className="ui-wrap">
          <div className="news-list-head">
            <h1 className="ui-sec-title ink-red">
              {searching || filtering ? "HASIL PENCARIAN" : "SEMUA DOKUMEN"}
            </h1>
            <div className="news-list-filters">
              <label className="news-filter">
                <span>Kategori</span>
                <select
                  value={categorySlug}
                  onChange={(event) => {
                    setCategorySlug(event.target.value);
                    setPage(1);
                  }}
                  aria-label="Filter kategori dokumen"
                >
                  <option value="">Semua</option>
                  {availableCategories.map((entry) => (
                    <option value={entry.slug} key={entry.slug}>{entry.name}</option>
                  ))}
                </select>
              </label>
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
                  aria-label="Cari dokumen"
                  onChange={(event) => {
                    setSearch(event.target.value);
                    setPage(1);
                  }}
                />
              </form>
            </div>
          </div>
          <p className="news-search-count" role="status">
            Menampilkan {pageItems.length} dari {filtered.length} dokumen
            {filtering && activeCategoryName && ` pada kategori “${activeCategoryName}”`}
            {searching && ` untuk “${search.trim()}”`}
          </p>
          {(searching || filtering) && (
            <div className="news-active-filters">
              {filtering && activeCategoryName && (
                <button
                  type="button"
                  className="news-chip"
                  onClick={() => {
                    setCategorySlug("");
                    setPage(1);
                  }}
                  aria-label={`Hapus filter kategori ${activeCategoryName}`}
                >
                  {activeCategoryName}
                  <span aria-hidden="true">×</span>
                </button>
              )}
              <button type="button" className="news-reset" onClick={clearFilters}>
                Tampilkan semua
              </button>
            </div>
          )}
          {pageItems.length > 0 ? (
            <div className="ui-doc-list ui-doc-logo">
              <div className="ui-doc-row">
                {pageItems.map((item) => (
                  <DocumentCard key={item.uuid} item={item} />
                ))}
              </div>
            </div>
          ) : (
            <div className="empty-state" role="status">
              <h3>Dokumen tidak ditemukan</h3>
              <p>
                {items.length === 0
                  ? "Dokumen akan tampil di sini setelah ditambahkan melalui panel admin."
                  : "Coba gunakan kata kunci yang lebih singkat atau ubah kategorinya."}
              </p>
              {(searching || filtering) && items.length > 0 && (
                <div className="ui-btn">
                  <button type="button" onClick={clearFilters}>
                    <span className="ui-btn-text">TAMPILKAN SEMUA DOKUMEN</span>
                    <i aria-hidden="true">›</i>
                  </button>
                </div>
              )}
            </div>
          )}
          <Pagination page={safePage} total={totalPages} onChange={changePage} />
        </div>
      </section>
    </>
  );
}
