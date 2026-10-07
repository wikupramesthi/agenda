import { useEffect, useRef, useState } from "react";
import { useApiData } from "../../app/useApiData";
import {
  fetchAllArticles,
  fetchArticlesByCategory,
  KEGIATAN_CATEGORY_SLUG,
  newsDetailHref,
} from "../../data/articles";
import { DataError } from "../common/DataError";
import { SectionHeading } from "../common/SectionHeading";

async function fetchKegiatan(): Promise<import("../../data/siteData").News[]> {
  // 1) coba endpoint kategori spesifik (paling akurat & cepat)
  try {
    const byCategory = await fetchArticlesByCategory(KEGIATAN_CATEGORY_SLUG, 6);
    if (byCategory.length > 0) return byCategory;
  } catch {
    // lanjut fallback — kategori belum ada atau API error
  }
  // 2) fallback: ambil semua lalu filter lokal yang mengandung "kegiatan"
  //    tahan terhadap slug varian (Kegiatan, KEGIATAN, kegiatan-dinas, dll)
  try {
    const all = await fetchAllArticles(50);
    const filtered = all.filter((a) =>
      (a.category ?? "").toLowerCase().includes("kegiatan"),
    );
    if (filtered.length > 0) return filtered.slice(0, 6);
  } catch {
    // abaikan, kembalikan kosong di bawah
  }
  return [];
}

export function KegiatanSection() {
  const { data, loading, failed, reload } = useApiData(
    () => fetchKegiatan(),
    [],
    "kegiatan",
  );

  const items = data ?? [];
  const trackRef = useRef<HTMLDivElement>(null);
  const [page, setPage] = useState(0);

  // 2 kartu per halaman di desktop, 1 di mobile — hitung dots
  const perPage = 2;
  const totalPages = Math.max(1, Math.ceil(items.length / perPage));

  const scrollToPage = (next: number) => {
    const track = trackRef.current;
    if (!track) return;
    const clamped = ((next % totalPages) + totalPages) % totalPages;
    const card = track.querySelector<HTMLElement>(".kegiatan-card");
    const gap = 22;
    const step = card ? (card.offsetWidth + gap) * perPage : track.clientWidth;
    track.scrollTo({
      left: clamped * step,
      behavior: window.matchMedia("(prefers-reduced-motion: reduce)").matches ? "auto" : "smooth",
    });
    setPage(clamped);
  };

  useEffect(() => {
    const track = trackRef.current;
    if (!track || items.length <= perPage) return;
    const onScroll = () => {
      const card = track.querySelector<HTMLElement>(".kegiatan-card");
      const gap = 22;
      const step = card ? (card.offsetWidth + gap) * perPage : track.clientWidth;
      if (step <= 0) return;
      const next = Math.round(track.scrollLeft / step);
      setPage(Math.min(Math.max(0, next), totalPages - 1));
    };
    track.addEventListener("scroll", onScroll, { passive: true });
    return () => track.removeEventListener("scroll", onScroll);
  }, [items.length, totalPages, perPage]);

  // reset halaman saat data ganti
  useEffect(() => setPage(0), [items.length]);

  return (
    <section className="ui-gallery-sec ui-kegiatan-sec ui-section" aria-label="Kegiatan">
      <div className="ui-wrap">
        <SectionHeading
          title="KEGIATAN"
          actionLabel="LIHAT KEGIATAN LAINNYA"
          actionHref="/berita"
          actionClassName="bg-blue2"
        />

        {items.length > 0 ? (
          <>
            <div className="kegiatan-track" ref={trackRef} role="region" aria-roledescription="carousel" aria-label="Kegiatan">
              {items.map((item) => {
                const href = newsDetailHref(item);
                return (
                  <div className="kegiatan-card" key={item.slug ?? item.title}>
                    <article className="ui-card ui-card-h ui-card-red">
                      <div className="ui-card-media">
                        <a href={href} tabIndex={-1} aria-hidden="true">
                          <img alt="" src={item.image} loading="lazy" />
                        </a>
                      </div>
                      <div className="ui-card-body">
                        <div className="ui-card-meta">
                          <div className="ui-tag ui-tag-red">
                            <a href={href}>{item.category ?? "Kegiatan"}</a>
                          </div>
                          <div className="ui-date ink-dark">{item.date}</div>
                        </div>
                        <h3 className="ui-card-title">
                          <a href={href}>{item.title}</a>
                        </h3>
                        <p>{item.excerpt}</p>
                      </div>
                    </article>
                  </div>
                );
              })}
            </div>
            {totalPages > 1 && (
              <div className="kegiatan-dots" role="tablist" aria-label="Halaman kegiatan">
                {Array.from({ length: totalPages }).map((_, i) => (
                  <button
                    key={i}
                    type="button"
                    role="tab"
                    aria-selected={page === i}
                    aria-label={`Halaman ${i + 1} dari ${totalPages}`}
                    className={page === i ? "is-active" : ""}
                    onClick={() => scrollToPage(i)}
                  />
                ))}
              </div>
            )}
          </>
        ) : failed ? (
          <DataError onRetry={reload} />
        ) : loading ? (
          <div role="status">
            <p>Memuat kegiatan terbaru…</p>
          </div>
        ) : (
          <div className="empty-state" role="status">
            <h3>Belum ada kegiatan</h3>
            <p>
              Berita kategori kegiatan akan tampil di sini setelah ditambahkan
              melalui panel admin. <a href="/berita">Lihat semua berita</a>.
            </p>
          </div>
        )}
      </div>
    </section>
  );
}
