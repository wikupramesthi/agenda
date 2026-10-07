import { useEffect, useState } from "react";
import { asset } from "../../app/assets";
import { fetchLatestBannerByPosisi, type BannerItem } from "../../data/banners";

// Banner gateway bawah berita: gambar + tautan dari API posisi "pengumuman"
// (data terakhir). Gagal diam-diam dengan fallback statis. Rapih: selalu di dalam ui-wrap + ui-section biar jarak berirama.
export function EventGatewayBanner({ className = "event-gateway" }: { className?: string }) {
  const [banner, setBanner] = useState<BannerItem | null>(null);

  useEffect(() => {
    let alive = true;
    fetchLatestBannerByPosisi("pengumuman")
      .then((item) => {
        if (alive) setBanner(item);
      })
      .catch(() => {});
    return () => {
      alive = false;
    };
  }, []);

  const image = banner?.image ?? asset("assets/banner.png");
  const label = banner?.name || "Lihat Indonesia Sports Summit 2026";
  const href = banner?.link?.trim() || "";

  // Tanpa link dari API: tampil sebagai gambar saja (tidak bisa diklik).
  if (!href) {
    return (
      <span className={className} role="img" aria-label={label}>
        <img alt="" src={image} loading="lazy" />
      </span>
    );
  }

  // Ada link: selalu buka di tab baru.
  return (
    <a
      className={className}
      href={href}
      aria-label={label}
      target="_blank"
      rel="noopener noreferrer"
    >
      <img alt="" src={image} loading="lazy" />
    </a>
  );
}
