import { useCallback, useEffect, useRef, useState } from "react";
import { CAROUSEL_INTERVAL_MS } from "../../app/constants";
import { useApiData } from "../../app/useApiData";
import { fetchBannersByPosisi, type BannerItem } from "../../data/banners";

export function BannerSlider({ posisi = "slider", limit = 5 }: { posisi?: string; limit?: number }) {
  const { data } = useApiData(() => fetchBannersByPosisi(posisi, limit), [posisi, limit], "banner-slider");
  const banners: BannerItem[] = data ?? [];

  const [active, setActive] = useState(0);
  const [paused, setPaused] = useState(false);

  const safeActive = banners.length ? active % banners.length : 0;
  const activeBanner = banners[safeActive];

  useEffect(() => {
    setActive(0);
  }, [banners.length]);

  useEffect(() => {
    if (paused || banners.length < 2) return;
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;
    const id = window.setInterval(() => setActive((v) => (v + 1) % banners.length), CAROUSEL_INTERVAL_MS);
    return () => window.clearInterval(id);
  }, [paused, banners.length]);

  const goTo = useCallback(
    (idx: number) => {
      if (!banners.length) return;
      setActive(((idx % banners.length) + banners.length) % banners.length);
    },
    [banners.length],
  );

  // Swipe sentuh untuk HP: geser kiri/kanan ganti banner.
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
      if (Math.abs(dy) > Math.abs(dx)) return;
      if (Math.abs(dx) < 40) return;
      if (dx < 0) goTo(safeActive + 1);
      else goTo(safeActive - 1);
    },
    [goTo, safeActive],
  );

  if (banners.length === 0) return null;

  return (
    <div className="banner-slider" role="region" aria-roledescription="carousel" aria-label="Banner DBMSDA">
      <div
        className="banner-slider-viewport"
        onTouchStart={onTouchStart}
        onTouchEnd={onTouchEnd}
        style={{ touchAction: "pan-y" }}
      >
        {activeBanner.link?.trim() ? (
          <a href={activeBanner.link} target="_blank" rel="noopener noreferrer" aria-label={activeBanner.name} className="banner-slide-link">
            <img alt={activeBanner.name} src={activeBanner.image} className="banner-slide-img" loading="lazy" draggable={false} />
          </a>
        ) : (
          <span className="banner-slide-static" aria-label={activeBanner.name}>
            <img alt={activeBanner.name} src={activeBanner.image} className="banner-slide-img" loading="lazy" draggable={false} />
          </span>
        )}
      </div>

      {banners.length > 1 && (
        <div className="banner-slider-controls">
          <button className="banner-arrow" type="button" onClick={() => goTo(safeActive - 1)} aria-label="Banner sebelumnya">
            <span aria-hidden="true">‹</span>
          </button>
          <div className="banner-dots" role="tablist" aria-label="Pilih banner">
            {banners.map((b, idx) => (
              <button
                key={`${b.name}-${idx}`}
                role="tab"
                type="button"
                aria-label={`Tampilkan banner ${idx + 1}: ${b.name}`}
                aria-selected={safeActive === idx}
                className={safeActive === idx ? "is-active" : ""}
                onClick={() => setActive(idx)}
              />
            ))}
          </div>
          <button className="banner-arrow" type="button" onClick={() => goTo(safeActive + 1)} aria-label="Banner berikutnya">
            <span aria-hidden="true">›</span>
          </button>
          <button
            className="banner-pause"
            type="button"
            onClick={() => setPaused((v) => !v)}
            aria-pressed={paused}
            aria-label={paused ? "Putar otomatis banner" : "Jeda otomatis banner"}
          >
            {paused ? "▶" : "⏸"}
          </button>
        </div>
      )}
    </div>
  );
}
