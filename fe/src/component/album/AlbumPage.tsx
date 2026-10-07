import { useEffect, useState } from "react";
import { SEARCH_MAX_LENGTH } from "../../app/constants";
import { useApiData } from "../../app/useApiData";
import { albumHref, fetchAlbums, type Album } from "../../data/albums";
import { DataError } from "../common/DataError";

function AlbumCard({ item }: { item: Album }) {
  const href = albumHref(item);
  // cover cukup 1 foto pertama
  const cover = item.fotos[0]?.gambar || item.cover_url || "";
  return (
    <article className="album-card">
      <a href={href} className="album-media" tabIndex={-1} aria-hidden="true">
        {cover ? (
          <img src={cover} alt="" loading="lazy" />
        ) : (
          <span className="album-placeholder" aria-hidden="true">
            {item.nama.slice(0, 2).toUpperCase()}
          </span>
        )}
        <span className="album-count">
          <svg width={14} height={14} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} aria-hidden="true">
            <rect x={3} y={3} width={18} height={18} rx={3} />
            <circle cx={9} cy={9} r={1.5} fill="currentColor" stroke="none" />
            <path d="m21 15-4.5-4.5L6 21" />
          </svg>
          {item.foto_count} foto
        </span>
      </a>
      <div className="album-body">
        <h3 className="album-title">
          <a href={href}>{item.nama}</a>
        </h3>
        {item.deskripsi ? <p className="album-desc">{item.deskripsi}</p> : null}
        <a href={href} className="album-link">
          Lihat Album <span aria-hidden="true">›</span>
        </a>
      </div>
    </article>
  );
}

export function AlbumPage() {
  const [query, setQuery] = useState("");
  const [page, setPage] = useState(1);
  const [committed, setCommitted] = useState("");

  useEffect(() => {
    const sp = new URLSearchParams(window.location.search);
    const q = sp.get("q");
    if (q) {
      setQuery(q.slice(0, SEARCH_MAX_LENGTH));
      setCommitted(q.slice(0, SEARCH_MAX_LENGTH));
    }
  }, []);

  const { data, loading, failed, reload } = useApiData(
    () => fetchAlbums({ search: committed, page, perPage: 9 }),
    [committed, page],
    "album",
  );

  const items = data?.items ?? [];
  const meta = data?.meta;

  const submit = (e: React.FormEvent) => {
    e.preventDefault();
    setPage(1);
    setCommitted(query.trim().slice(0, SEARCH_MAX_LENGTH));
  };

  return (
    <section className="ui-section ui-section-top album-page">
      <div className="ui-wrap">
        <div className="album-head">
          <div>
            <span className="album-kicker">Galeri Foto</span>
            <h1 className="ui-sec-title album-h1">ALBUM KEGIATAN</h1>
            <p className="album-sub">
              Kumpulan album dokumentasi kegiatan Dinas Bina Marga dan Sumber Daya Air Kota Bekasi.
            </p>
          </div>
          <form className="album-search" role="search" onSubmit={submit}>
            <input
              type="search"
              value={query}
              maxLength={SEARCH_MAX_LENGTH}
              placeholder="Cari album…"
              aria-label="Cari album"
              onChange={(e) => setQuery(e.target.value)}
            />
            <button type="submit">Cari</button>
          </form>
        </div>

        {loading ? (
          <div className="news-loading" role="status">
            <p>Memuat album…</p>
          </div>
        ) : failed ? (
          <DataError onRetry={reload} />
        ) : items.length === 0 ? (
          <div className="empty-state" role="status">
            <h3>Album tidak ditemukan</h3>
            <p>Coba kata kunci lain atau kembali lagi nanti.</p>
          </div>
        ) : (
          <>
            <div className="album-grid">
              {items.map((a) => (
                <AlbumCard key={a.uuid} item={a} />
              ))}
            </div>
            {meta && meta.last_page > 1 && (
              <nav className="pagination" aria-label="Halaman album">
                <button type="button" disabled={page <= 1} onClick={() => setPage((p) => Math.max(1, p - 1))} aria-label="Halaman sebelumnya">
                  ‹
                </button>
                <span className="album-pageinfo" aria-live="polite">
                  Halaman {meta.current_page} dari {meta.last_page} ({meta.total} album)
                </span>
                <button
                  type="button"
                  disabled={page >= meta.last_page}
                  onClick={() => setPage((p) => Math.min(meta.last_page, p + 1))}
                  aria-label="Halaman berikutnya"
                >
                  ›
                </button>
              </nav>
            )}
          </>
        )}
      </div>
    </section>
  );
}
