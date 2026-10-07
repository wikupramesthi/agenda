import { useCallback, useEffect, useRef, useState } from "react";
import { CAROUSEL_INTERVAL_MS } from "../../app/constants";
import { newsDetailHref } from "../../data/articles";
import type { News } from "../../data/siteData";

// Carousel 5 berita utama dipakai beranda + halaman berita.
// Kontrol (‹ dots › jeda) dalam pill di dalam gambar; autoplay hormati
// `prefers-reduced-motion`. Mendukung swipe sentuh di HP (touch + pointer).
export function HeadlineCarousel({ items, label = "Berita utama" }: { items: News[]; label?: string }) {
  const [active, setActive] = useState(0);
  const [paused, setPaused] = useState(false);
  const safeActive = items.length ? active % items.length : 0;
  const featured = items[safeActive];

  const goTo = useCallback(
    (index: number) => {
      if (!items.length) return;
      setActive(((index % items.length) + items.length) % items.length);
    },
    [items.length],
  );

  useEffect(() => {
    if (paused || items.length < 2) return;
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;
    const id = window.setInterval(
      () => setActive((value) => (value + 1) % items.length),
      CAROUSEL_INTERVAL_MS,
    );
    return () => window.clearInterval(id);
  }, [paused, items.length]);

  useEffect(() => {
    setActive((value) => (items.length ? value % items.length : 0));
  }, [items.length]);

  // ---- swipe sentuh: HP geser kiri/kanan untuk pindah berita ----
  const touchStartX = useRef<number | null>(null);
  const touchStartY = useRef<number | null>(null);
  const onTouchStart = useCallback((e: React.TouchEvent) => {
    touchStartX.current = e.touches[0]?.clientX ?? null;
    touchStartY.current = e.touches[0]?.clientY ?? null;
  }, []);
  const onTouchEnd = useCallback(
    (e: React.TouchEvent) => {
      const startX = touchStartX.current;
      const startY = touchStartY.current;
      touchStartX.current = null;
      touchStartY.current = null;
      if (startX === null || startY === null) return;
      const endX = e.changedTouches[0]?.clientX ?? startX;
      const endY = e.changedTouches[0]?.clientY ?? startY;
      const dx = endX - startX;
      const dy = endY - startY;
      // Abaikan geser vertikal (scroll halaman) — hanya horizontal.
      if (Math.abs(dy) > Math.abs(dx)) return;
      if (Math.abs(dx) < 40) return;
      if (dx < 0) goTo(safeActive + 1);
      else goTo(safeActive - 1);
    },
    [goTo, safeActive],
  );

  if (!featured) return null;
  const featuredHref = newsDetailHref(featured);

  return (
    <div className="ui-slider headline-carousel" aria-roledescription="carousel" aria-label={label}>
      <div
        className="swiper-wrapper"
        onTouchStart={onTouchStart}
        onTouchEnd={onTouchEnd}
        style={{ touchAction: "pan-y" }}
      >
        <div className="swiper-slide">
          <div className="ui-feature" aria-live="polite">
            <div className="ui-feature-media">
              <a href={featuredHref} tabIndex={-1} aria-hidden="true">
                <div className="ui-feature-bg" />
                <img alt="" src={featured.image} />
              </a>
            </div>
            <div className="ui-wrap">
              <div className="ui-feature-copy">
                <div className="ui-feature-meta">
                  <div className="ui-tag"><a href="/berita">Berita</a></div>
                  <div className="ui-date">{featured.date}</div>
                </div>
                <div className="ui-feature-main">
                  <h2 className="ui-feature-title"><a href={featuredHref}>{featured.title}</a></h2>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div className="featured-controls">
        <button className="featured-arrow" type="button" onClick={() => goTo(safeActive - 1)} aria-label="Berita sebelumnya"><span aria-hidden="true">‹</span></button>
        <div className="featured-dots" role="tablist" aria-label="Pilih berita utama">
          {items.map((item, index) => (
            <button
              aria-label={`Tampilkan berita ${index + 1}: ${item.title}`}
              aria-current={safeActive === index}
              role="tab"
              aria-selected={safeActive === index}
              className={safeActive === index ? "is-active" : ""}
              key={item.title}
              onClick={() => setActive(index)}
              type="button"
            />
          ))}
        </div>
        <button className="featured-arrow" type="button" onClick={() => goTo(safeActive + 1)} aria-label="Berita berikutnya"><span aria-hidden="true">›</span></button>
        <button className="carousel-pause" type="button" onClick={() => setPaused((v) => !v)} aria-pressed={paused} aria-label={paused ? "Putar otomatis berita" : "Jeda otomatis berita"}>{paused ? "▶" : "⏸"}</button>
      </div>
    </div>
  );
}
