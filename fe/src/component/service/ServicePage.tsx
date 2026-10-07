import { useEffect, useMemo, useState } from "react";
import { SEARCH_MAX_LENGTH } from "../../app/constants";
import { useApiData } from "../../app/useApiData";
import { fetchServices, type Service } from "../../data/services";
import { DataError } from "../common/DataError";

type Category = "semua" | "external" | "internal" | "other";

const categoryMeta: Record<string, { label: string; desc: string }> = {
  external: { label: "Eksternal", desc: "Untuk warga & mitra — pengaduan, perizinan, informasi publik" },
  internal: { label: "Internal", desc: "Untuk aparatur — kepegawaian, persuratan, kinerja" },
  other: { label: "Lainnya", desc: "Layanan pendukung lainnya" },
};

function ServiceCard({ item }: { item: Service }) {
  const href = item.url?.trim() ?? "";
  const isExternal = /^https?:\/\//i.test(href);
  const hasImage = !!item.image_url;

  return (
    <article className="svc-card">
      <div className="svc-card-media" aria-hidden="true">
        {hasImage ? (
          <img src={item.image_url!} alt="" loading="lazy" />
        ) : (
          <div className="svc-card-placeholder">
            <span>{item.name.slice(0, 2).toUpperCase()}</span>
          </div>
        )}
        <span className="svc-card-badge">{item.category_label}</span>
      </div>
      <div className="svc-card-body">
        <h3 className="svc-card-title">{item.name}</h3>
        {item.description ? (
          <p className="svc-card-desc">{item.description}</p>
        ) : (
          <p className="svc-card-desc svc-card-desc--muted">
            Layanan {item.category_label.toLowerCase()} DBMSDA Kota Bekasi untuk mendukung pembangunan, pemeliharaan infrastruktur, dan pelayanan publik yang responsif.
          </p>
        )}
      </div>
      <div className="svc-card-foot">
        {href ? (
          <a href={href} target={isExternal ? "_blank" : undefined} rel={isExternal ? "noopener noreferrer" : undefined} className="svc-card-link">
            Kunjungi Layanan <span aria-hidden="true">↗</span>
          </a>
        ) : (
          <span className="svc-card-link svc-card-link--muted">Segera Hadir</span>
        )}
      </div>
    </article>
  );
}

export function ServicePage() {
  const { data: apiData, loading, failed, reload } = useApiData(fetchServices, [], "services");
  const services = apiData ?? [];

  const [query, setQuery] = useState("");
  const [category, setCategory] = useState<Category>("semua");

  const normalized = query.trim().toLocaleLowerCase("id-ID");

  // sinkron ?q= & ?cat= untuk shareable link
  useEffect(() => {
    const sp = new URLSearchParams(window.location.search);
    const q = sp.get("q");
    const c = sp.get("cat");
    if (q) setQuery(q.slice(0, SEARCH_MAX_LENGTH));
    if (c && ["external", "internal", "other"].includes(c)) setCategory(c as Category);
  }, []);

  useEffect(() => {
    const url = new URL(window.location.href);
    if (normalized) url.searchParams.set("q", normalized);
    else url.searchParams.delete("q");
    if (category !== "semua") url.searchParams.set("cat", category);
    else url.searchParams.delete("cat");
    window.history.replaceState(null, "", url.toString());
  }, [normalized, category]);

  const filtered = useMemo(() => {
    return services.filter((s) => {
      if (category !== "semua" && s.category !== category) return false;
      if (!normalized) return true;
      const hay = `${s.name} ${s.description ?? ""} ${s.category_label}`.toLocaleLowerCase("id-ID");
      return hay.includes(normalized);
    });
  }, [services, category, normalized]);

  const counts = useMemo(() => {
    const m = new Map<string, number>();
    services.forEach((s) => m.set(s.category, (m.get(s.category) ?? 0) + 1));
    return m;
  }, [services]);

  const totalLabel = loading ? "Memuat layanan…" : `${filtered.length} layanan ditemukan`;

  if (loading) {
    return (
      <>
        <section className="svc-hero ui-section ui-section-top">
          <div className="ui-wrap">
            <nav className="faq-breadcrumb" aria-label="Breadcrumb">
              <a href="/">Beranda</a>
              <span aria-hidden="true">/</span>
              <span aria-current="page">Layanan</span>
            </nav>
            <div className="svc-hero-grid">
              <div>
                <span className="svc-kicker">LAYANAN • DBMSDA KOTA BEKASI</span>
                <h1 className="svc-title">LAYANAN</h1>
                <p className="svc-subtitle">Menyiapkan daftar layanan DBMSDA untuk Anda — mohon tunggu sejenak…</p>
              </div>
            </div>
          </div>
        </section>
        <section className="ui-section">
          <div className="ui-wrap" role="status" aria-live="polite">
            <div className="page-loading" style={{ padding: "30px 0" }}>
              <span className="loader-orbit" aria-hidden="true">
                <span className="loader-core" />
              </span>
              <p>Memuat layanan…</p>
            </div>
          </div>
        </section>
      </>
    );
  }

  if (failed) {
    return (
      <>
        <section className="svc-hero ui-section ui-section-top">
          <div className="ui-wrap">
            <nav className="faq-breadcrumb" aria-label="Breadcrumb">
              <a href="/">Beranda</a>
              <span aria-hidden="true">/</span>
              <span aria-current="page">Layanan</span>
            </nav>
            <h1 className="svc-title">LAYANAN</h1>
            <p className="svc-subtitle">Gagal memuat layanan. Koneksi ke server terganggu, tapi halaman tetap tersedia. Coba muat ulang.</p>
          </div>
        </section>
        <section className="ui-section">
          <div className="ui-wrap">
            <DataError onRetry={reload} />
          </div>
        </section>
      </>
    );
  }

  return (
    <>
      {/* HERO */}
      <section className="svc-hero ui-section ui-section-top">
        <div className="ui-wrap">
          <nav className="faq-breadcrumb" aria-label="Breadcrumb">
            <a href="/">Beranda</a>
            <span aria-hidden="true">/</span>
            <span aria-current="page">Layanan</span>
          </nav>

          <div className="svc-hero-grid">
            <div>
              <span className="svc-kicker">LAYANAN • DBMSDA KOTA BEKASI</span>
              <h1 className="svc-title">LAYANAN</h1>
              <p className="svc-subtitle">
                Satu pintu untuk semua kebutuhan infrastruktur — laporkan jalan rusak &amp; drainase mampet, urus
                perizinan pemanfaatan ruang jalan, akses data peil banjir, hingga layanan internal kepegawaian. Semua
                layanan dikelola DBMSDA Kota Bekasi dan terhubung langsung ke sistem resmi.
              </p>
              <div className="svc-stats" aria-label="Statistik layanan">
                <div className="svc-stat">
                  <b>{services.length}</b>
                  <span>Total Layanan Aktif</span>
                </div>
                <div className="svc-stat">
                  <b>{counts.get("external") ?? 0}</b>
                  <span>Untuk Warga</span>
                </div>
                <div className="svc-stat">
                  <b>{counts.get("internal") ?? 0}</b>
                  <span>Untuk Aparatur</span>
                </div>
              </div>
            </div>

            <div className="svc-hero-card" aria-hidden="true">
              <div className="svc-hero-icon">🛎️</div>
              <h2>Layanan Terpadu &amp; Transparan</h2>
              <p>
                Tidak perlu cari satu-satu. Dari pengaduan infrastruktur hingga permohonan informasi publik, semua layanan
                DBMSDA kini terpusat, mudah diakses, dan terpantau.
              </p>
              <div className="svc-hero-links">
                <span>Responsif</span>
                <span>Terintegrasi</span>
                <span>Akuntabel</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* TOOLBAR */}
      <section className="svc-toolbar ui-section" aria-label="Filter layanan">
        <div className="ui-wrap">
          <div className="svc-toolbar-inner">
            <form className="faq-search svc-search" role="search" onSubmit={(e) => e.preventDefault()} aria-label="Cari layanan">
              <span className="faq-search-icon" aria-hidden="true">
                ⌕
              </span>
              <input
                type="search"
                value={query}
                onChange={(e) => setQuery(e.target.value.slice(0, SEARCH_MAX_LENGTH))}
                placeholder="Cari layanan — mis. WBS, PPID, SP4N Lapor…"
                aria-label="Cari layanan"
                maxLength={SEARCH_MAX_LENGTH}
              />
              {query && (
                <button type="button" className="faq-clear" onClick={() => setQuery("")} aria-label="Hapus pencarian">
                  ✕
                </button>
              )}
            </form>

            <div className="faq-meta">
              <span className="faq-count" role="status" aria-live="polite">
                {totalLabel}
              </span>
            </div>
          </div>

          <div className="faq-chips" role="tablist" aria-label="Kategori layanan">
            <button
              type="button"
              role="tab"
              aria-selected={category === "semua"}
              className={`faq-chip ${category === "semua" ? "is-active" : ""}`}
              onClick={() => setCategory("semua")}
            >
              Semua <span className="faq-chip-count">{services.length}</span>
            </button>
            {(["external", "internal", "other"] as const).map((cat) => {
              const meta = categoryMeta[cat];
              const count = counts.get(cat) ?? 0;
              if (count === 0 && services.length > 0) return null;
              return (
                <button
                  key={cat}
                  type="button"
                  role="tab"
                  aria-selected={category === cat}
                  className={`faq-chip ${category === cat ? "is-active" : ""}`}
                  onClick={() => setCategory(cat)}
                >
                  {meta.label} <span className="faq-chip-count">{count}</span>
                </button>
              );
            })}
          </div>
        </div>
      </section>

      {/* GRID */}
      <section className="svc-list ui-section" aria-label="Daftar layanan">
        <div className="ui-wrap">
          {services.length === 0 ? (
            <div className="faq-empty" role="status">
              <div className="faq-empty-icon" aria-hidden="true">
                🛎️
              </div>
              <h2>Belum ada layanan aktif</h2>
              <p>
                Saat ini belum ada layanan yang dipublikasikan. Admin DBMSDA sedang menyiapkan daftar layanan terbaru.
                Silakan kembali lagi nanti atau hubungi kami untuk informasi lebih lanjut.
              </p>
              <div className="faq-empty-actions">
                <a href="/faq" className="faq-btn faq-btn-ghost">
                  Lihat FAQ
                </a>
              </div>
            </div>
          ) : filtered.length === 0 ? (
            <div className="faq-empty" role="status">
              <div className="faq-empty-icon" aria-hidden="true">?</div>
              <h2>Tidak ada hasil yang cocok</h2>
              <p>
                Kami tidak menemukan layanan untuk <strong>“{query.trim() || categoryMeta[category]?.label || category}”</strong>.
                Coba gunakan kata kunci yang lebih umum atau pilih kategori lain.
              </p>
              <div className="faq-empty-actions">
                <button
                  type="button"
                  className="faq-btn faq-btn-primary"
                  onClick={() => {
                    setQuery("");
                    setCategory("semua");
                  }}
                >
                  Tampilkan semua layanan
                </button>
              </div>
            </div>
          ) : (
            <div className="svc-grid">
              {filtered.map((item) => (
                <ServiceCard key={item.uuid} item={item} />
              ))}
            </div>
          )}
        </div>
      </section>


    </>
  );
}
