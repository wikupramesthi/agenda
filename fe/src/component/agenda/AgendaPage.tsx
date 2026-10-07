import { useEffect, useState } from "react";
import { SEARCH_MAX_LENGTH } from "../../app/constants";
import { useApiData } from "../../app/useApiData";
import { agendaDetailHref, fetchAgendaList, type AgendaItem } from "../../data/agenda";
import { DataError } from "../common/DataError";

function AgendaCard({ item }: { item: AgendaItem }) {
  const href = agendaDetailHref(item);
  const day = item.date ? item.date.split("-")[0] : "--";
  const month = item.dateLabel ? item.dateLabel.split(" ")[1] ?? "" : "";
  return (
    <a href={href} className="agenda-card" aria-label={item.title}>
      <div className="agenda-card-date">
        <b>{day}</b>
        <span>{month}</span>
      </div>
      <div className="agenda-card-body">
        <small>{item.location || "DBMSDA Kota Bekasi"}</small>
        <h3>{item.title}</h3>
        {item.description && <p>{item.description.slice(0, 120)}{item.description.length > 120 ? "…" : ""}</p>}
        <span className="agenda-card-cta">LIHAT DETAIL ›</span>
      </div>
      {item.image && <img src={item.image} alt="" loading="lazy" className="agenda-card-img" />}
    </a>
  );
}

export function AgendaPage() {
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const perPage = 9;

  const { data, loading, failed, reload } = useApiData(
    () => fetchAgendaList({ search: search.trim() || undefined, page, perPage }),
    [search, page],
    `agenda-${search}-${page}`
  );

  const items = data?.items ?? [];
  const meta = data?.meta;
  const totalPages = meta?.last_page ?? 1;

  useEffect(() => {
    setPage(1);
  }, [search]);

  if (loading) {
    return (
      <section className="ui-section ui-section-top">
        <div className="ui-wrap"><div className="ui-sec-head text-center"><h1 className="ui-sec-title">AGENDA</h1></div><p role="status" style={{ textAlign: "center", color: "#6b6b8a" }}>Memuat agenda…</p></div>
      </section>
    );
  }
  if (failed) {
    return (
      <section className="ui-section ui-section-top">
        <div className="ui-wrap"><div className="ui-sec-head text-center"><h1 className="ui-sec-title">AGENDA</h1></div><DataError onRetry={reload} /></div>
      </section>
    );
  }

  return (
    <section className="ui-section ui-section-top">
      <div className="ui-wrap">
        <div className="ui-sec-head text-center"><h1 className="ui-sec-title">AGENDA</h1></div>
        <p className="agenda-subtitle">Jadwal kegiatan resmi DBMSDA Kota Bekasi.</p>

        <form className="agenda-toolbar" role="search" onSubmit={(e) => e.preventDefault()}>
          <input
            type="search"
            value={search}
            maxLength={SEARCH_MAX_LENGTH}
            placeholder="Cari agenda…"
            aria-label="Cari agenda"
            onChange={(e) => setSearch(e.target.value)}
          />
          {search && <button type="button" className="news-reset" onClick={() => setSearch("")}>Hapus</button>}
        </form>

        {items.length === 0 ? (
          <div className="empty-state" role="status">
            <h3>Tidak ada agenda</h3>
            <p>{search ? `Tidak ada agenda untuk “${search}”.` : "Belum ada agenda terbit."}</p>
          </div>
        ) : (
          <>
            <div className="agenda-grid">
              {items.map((item) => (
                <AgendaCard key={item.uuid} item={item} />
              ))}
            </div>
            {totalPages > 1 && (
              <nav className="pagination" aria-label="Halaman agenda">
                <button type="button" disabled={page <= 1} onClick={() => setPage((p) => Math.max(1, p - 1))}>‹</button>
                <span style={{ color: "#6b6b8a", fontSize: 14 }}>{page} / {totalPages}</span>
                <button type="button" disabled={page >= totalPages} onClick={() => setPage((p) => Math.min(totalPages, p + 1))}>›</button>
              </nav>
            )}
          </>
        )}
      </div>
    </section>
  );
}
