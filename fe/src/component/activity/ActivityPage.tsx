import { useEffect, useMemo, useState } from "react";
import { announcements, calendarEvents } from "../../data/siteData";
import { asset } from "../../app/assets";
import { SEARCH_MAX_LENGTH } from "../../app/constants";
import { useApiData } from "../../app/useApiData";
import {
  fetchAllArticles,
  fetchCategories,
  type Category,
} from "../../data/articles";
import { NewsCard } from "../blog/BlogCard";
import { HeadlineCarousel } from "../blog/HeadlineCarousel";
import { DataError } from "../common/DataError";

type Variant = "news" | "event" | "announcement";

const PAGE_SIZE = 9;

function EventList() {
  return (
    <>
      <section className="ui-events-page ui-section ui-section-top"><div className="ui-wrap"><div className="ui-sec-head text-center"><h1 className="ui-sec-title ui-page-title">KALENDER KEGIATAN</h1><p>Kalender Kegiatan DBMSDA</p></div><div className="event-react-grid">{calendarEvents.map((event) => <article className="event-react-card" key={event.title}><time dateTime={`${event.day}-${event.month}`}><b>{event.day}</b><span>{event.month}</span></time><div><small>Agenda DBMSDA</small><h2>{event.title}</h2><p>Informasi kegiatan infrastruktur dan sumber daya air Kota Bekasi.</p></div><span className="event-react-detail">DETAIL <span aria-hidden="true">›</span></span></article>)}</div></div></section>
    </>
  );
}

function AnnouncementList() {
  return (
    <>
      <section className="ui-docs-sec ui-section ui-section-top"><div className="ui-wrap"><div className="ui-sec-head"><h1 className="ui-sec-title ink-blue">INFORMASI UMUM</h1></div><div className="ui-doc-list ui-doc-3 ui-doc-logo"><div className="ui-doc-row">{announcements.map((title, index) => <div className="ui-doc-col" key={title}><article className="ui-doc"><div className="ui-doc-media"><img alt="" src={asset("assets/logo.png")} loading="lazy" /></div><div className="ui-doc-body"><div className="ui-doc-dl"><span aria-hidden="true">↓</span></div><div className="ui-doc-date">September 2026 · {String(index + 1).padStart(2, "0")}</div><h2 className="ui-doc-title">{title}</h2></div></article></div>)}</div></div></div></section>
    </>
  );
}

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
    <nav className="pagination" aria-label="Halaman berita">
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

function NewsList({ query = "" }: { query?: string }) {
  // Seluruh berita (semua kategori) dari API + daftar kategori untuk filter.
  // Kategori gagal dimuat diam-diam: fallback ke kategori yang muncul di data.
  const { data, loading, failed, reload } = useApiData(
    () =>
      Promise.all([
        fetchAllArticles(),
        fetchCategories().catch((): Category[] => []),
      ]).then(([articles, categories]) => ({ articles, categories })),
    [],
    "berita",
  );
  const items = data?.articles ?? [];
  const apiCategories = data?.categories ?? [];
  const [search, setSearch] = useState(query);
  const [category, setCategory] = useState("");
  const [page, setPage] = useState(1);

  // Samakan kotak cari saat datang dari pencarian header (`?q=`).
  useEffect(() => {
    setSearch(query);
    setPage(1);
  }, [query]);

  const normalizedSearch = search.toLocaleLowerCase("id-ID");
  const searching = normalizedSearch.trim().length > 0;
  const filtering = category.length > 0;
  const isNarrowed = searching || filtering;
  // Opsi filter: kategori API yang benar-benar punya berita; kalau API
  // kategori gagal, pakai nama kategori yang muncul di data.
  const availableCategories = useMemo(() => {
    const names = new Set(
      items.map((item) => item.category ?? "").filter((name) => name.length > 0),
    );
    const fromApi = apiCategories
      .map((entry) => entry.name)
      .filter((name) => names.has(name));
    return fromApi.length > 0 ? fromApi : [...names];
  }, [items, apiCategories]);
  const filtered = useMemo(
    () =>
      items.filter((item) => {
        if (filtering && item.category !== category) return false;
        if (!searching) return true;
        return `${item.title} ${item.excerpt} ${item.category ?? ""}`
          .toLocaleLowerCase("id-ID")
          .includes(normalizedSearch.trim());
      }),
    [items, searching, filtering, category, normalizedSearch],
  );

  // Saat mencari/menyaring: hasil saja. Normal: hero 5 teratas + grid sisanya.
  const hero = isNarrowed ? [] : items.slice(0, 5);
  const pool = isNarrowed ? filtered : items.slice(5);
  const totalPages = Math.max(1, Math.ceil(pool.length / PAGE_SIZE));
  const safePage = Math.min(page, totalPages);
  const pageItems = pool.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE);

  const changePage = (next: number) => {
    setPage(Math.min(Math.max(1, next), totalPages));
    document.querySelector(".news-list-grid")?.scrollIntoView({ block: "start" });
  };

  const clearCategory = () => {
    setCategory("");
    setPage(1);
  };
  const clearFilters = () => {
    setSearch("");
    setCategory("");
    setPage(1);
  };

  if (loading) {
    return (
      <>
        <div className="ui-wrap" role="status"><p>Memuat berita…</p></div>
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
      {hero.length > 0 && (
        <section className="ui-headlines ui-section" aria-label="Berita utama">
          <HeadlineCarousel items={hero} label="Berita utama" />
        </section>
      )}
      <section className="ui-stories ui-section news-list-grid" aria-label="Semua berita">
        <div className="ui-wrap">
          <div className="news-list-head">
            <h2 className="ui-sec-title ink-red">{searching ? "HASIL PENCARIAN" : filtering ? category.toLocaleUpperCase("id-ID") : "SEMUA BERITA"}</h2>
            <div className="news-list-filters">
              <label className="news-filter">
                <span>Kategori</span>
                <select
                  value={category}
                  onChange={(event) => {
                    setCategory(event.target.value);
                    setPage(1);
                  }}
                >
                  <option value="">Semua</option>
                  {availableCategories.map((name) => (
                    <option value={name} key={name}>{name}</option>
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
                  placeholder="Cari berita…"
                  aria-label="Cari berita"
                  onChange={(event) => {
                    setSearch(event.target.value);
                    setPage(1);
                  }}
                />
              </form>
            </div>
          </div>
          <p className="news-search-count" role="status">
            Menampilkan {pageItems.length} dari {pool.length} berita
            {filtering && ` pada kategori “${category}”`}
            {searching && ` untuk “${search.trim()}”`}
          </p>
          {isNarrowed && (
            <div className="news-active-filters">
              {filtering && (
                <button type="button" className="news-chip" onClick={clearCategory} aria-label={`Hapus filter kategori ${category}`}>
                  {category}
                  <span aria-hidden="true">×</span>
                </button>
              )}
              <button type="button" className="news-reset" onClick={clearFilters}>
                Tampilkan semua
              </button>
            </div>
          )}
          {pageItems.length > 0 ? (
            <div className="ui-grid-3">
              <div className="swiper-wrapper">
                {pageItems.map((item) => (
                  <div className="swiper-slide" key={item.title}>
                    <NewsCard item={item} />
                  </div>
                ))}
              </div>
            </div>
          ) : (
            <div className="empty-state" role="status">
              <h3>Berita tidak ditemukan</h3>
              <p>
                {filtering && !searching
                  ? `Belum ada berita pada kategori “${category}”.`
                  : "Coba gunakan kata kunci yang lebih singkat atau ubah kategorinya."}
              </p>
              <div className="ui-btn">
                <button type="button" onClick={clearFilters}>
                  <span className="ui-btn-text">TAMPILKAN SEMUA BERITA</span>
                  <i aria-hidden="true">›</i>
                </button>
              </div>
            </div>
          )}
          <Pagination page={safePage} total={totalPages} onChange={changePage} />
        </div>
      </section>
    </>
  );
}

export function ActivityPage({ variant, query = "" }: { variant: Variant; query?: string }) {
  if (variant === "event") return <EventList />;
  if (variant === "announcement") return <AnnouncementList />;
  return <NewsList query={query} />;
}
