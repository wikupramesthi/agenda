import { useEffect, useId, useMemo, useState } from "react";
import { SEARCH_MAX_LENGTH } from "../../app/constants";
import { useApiData } from "../../app/useApiData";
import { fetchFaqs, type Faq } from "../../data/faqs";
import { DataError } from "../common/DataError";

type FaqCategory = {
  id: string;
  label: string;
  icon: string;
  description: string;
};

const categories: FaqCategory[] = [
  { id: "informasi-umum", label: "Informasi Umum", icon: "◈", description: "Profil, tugas fungsi, dan info umum DBMSDA" },
  { id: "layanan", label: "Layanan", icon: "▣", description: "Layanan jalan, jembatan, drainase, SDA, dan PPID" },
  { id: "infrastruktur-pemeliharaan", label: "Jalan & Drainase", icon: "⬢", description: "Penanganan jalan rusak, trotoar, jembatan, dan drainase" },
  { id: "pengaduan-permohonan", label: "Pengaduan & Permohonan", icon: "☎", description: "Cara melapor, permohonan, dan tindak lanjut aduan" },
  { id: "program-kegiatan", label: "Program & Kegiatan", icon: "◆", description: "Program pembangunan dan pemeliharaan infrastruktur" },
];

function categoryOf(faq: Faq): string {
  // backend enum: informasi-umum, layanan, infrastruktur-pemeliharaan, pengaduan-permohonan, program-kegiatan
  return faq.kategori ?? "informasi-umum";
}

export function FaqPage() {
  const baseId = useId();
  const { data: apiData, loading, failed, reload } = useApiData(fetchFaqs, [], "faqs");
  const faqs = apiData ?? [];

  const [activeCategory, setActiveCategory] = useState<string>("semua");
  const [query, setQuery] = useState("");
  const [openIds, setOpenIds] = useState<Set<string>>(new Set());

  // buka otomatis FAQ pertama saat data pertama kali masuk (UX seperti versi statis)
  useEffect(() => {
    if (faqs.length > 0 && openIds.size === 0) {
      setOpenIds(new Set([faqs[0].id]));
    }
  }, [faqs, openIds.size]);

  const normalized = query.trim().toLocaleLowerCase("id-ID");

  const filtered = useMemo(() => {
    return faqs.filter((item) => {
      const cat = categoryOf(item);
      if (activeCategory !== "semua" && cat !== activeCategory) return false;
      if (!normalized) return true;
      const catLabel = categories.find((c) => c.id === cat)?.label ?? "";
      const haystack = `${item.question} ${item.answer} ${catLabel}`.toLocaleLowerCase("id-ID");
      return haystack.includes(normalized);
    });
  }, [faqs, activeCategory, normalized]);

  const grouped = useMemo(() => {
    const map = new Map<string, Faq[]>();
    filtered.forEach((item) => {
      const cat = categoryOf(item);
      const list = map.get(cat) ?? [];
      list.push(item);
      map.set(cat, list);
    });
    return categories
      .filter((cat) => map.has(cat.id))
      .map((cat) => ({ cat, items: map.get(cat.id)! }));
  }, [filtered]);

  // hitung per kategori untuk chip (dari seluruh data, bukan hanya filtered agar user tahu distribusi)
  const countsByCategory = useMemo(() => {
    const m = new Map<string, number>();
    faqs.forEach((f) => {
      const c = categoryOf(f);
      m.set(c, (m.get(c) ?? 0) + 1);
    });
    return m;
  }, [faqs]);

  const totalLabel = loading ? "Memuat FAQ…" : `${filtered.length} pertanyaan ditemukan`;

  const toggle = (id: string) => {
    setOpenIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  };

  const expandAll = () => setOpenIds(new Set(filtered.map((f) => f.id)));
  const collapseAll = () => setOpenIds(new Set());

  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const q = params.get("q");
    if (q) setQuery(q.slice(0, SEARCH_MAX_LENGTH));
  }, []);

  useEffect(() => {
    const url = new URL(window.location.href);
    if (normalized) url.searchParams.set("q", normalized);
    else url.searchParams.delete("q");
    window.history.replaceState(null, "", url.toString());
  }, [normalized]);

  // Loading state mengikuti pola berita: shell tetap tampil, cangkang tidak kosong
  if (loading) {
    return (
      <>
        <section className="faq-hero ui-section ui-section-top">
          <div className="ui-wrap">
            <nav className="faq-breadcrumb" aria-label="Breadcrumb">
              <a href="/">Beranda</a>
              <span aria-hidden="true">/</span>
              <span aria-current="page">FAQ</span>
            </nav>
            <div className="faq-hero-grid">
              <div className="faq-hero-copy">
                <span className="faq-kicker">PUSAT BANTUAN • DBMSDA KOTA BEKASI</span>
                <h1 className="faq-title">Pertanyaan yang Sering <span>Diajukan</span></h1>
                <p className="faq-subtitle">Memuat daftar pertanyaan untuk Anda…</p>
              </div>
            </div>
          </div>
        </section>
        <section className="ui-section">
          <div className="ui-wrap" role="status" aria-live="polite">
            <div className="page-loading" style={{ padding: "30px 0" }}>
              <span className="loader-orbit" aria-hidden="true"><span className="loader-core" /></span>
              <p>Memuat FAQ…</p>
            </div>
          </div>
        </section>
      </>
    );
  }

  if (failed) {
    return (
      <>
        <section className="faq-hero ui-section ui-section-top">
          <div className="ui-wrap">
            <nav className="faq-breadcrumb" aria-label="Breadcrumb">
              <a href="/">Beranda</a>
              <span aria-hidden="true">/</span>
              <span aria-current="page">FAQ</span>
            </nav>
            <div className="faq-hero-grid">
              <div className="faq-hero-copy">
                <span className="faq-kicker">PUSAT BANTUAN • DBMSDA KOTA BEKASI</span>
                <h1 className="faq-title">Pertanyaan yang Sering <span>Diajukan</span></h1>
                <p className="faq-subtitle">Terjadi kendala saat memuat data. Silakan coba lagi, atau hubungi Call Center 112 Kota Bekasi.</p>
              </div>
            </div>
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
      <section className="faq-hero ui-section ui-section-top">
        <div className="ui-wrap">
          <nav className="faq-breadcrumb" aria-label="Breadcrumb">
            <a href="/">Beranda</a>
            <span aria-hidden="true">/</span>
            <span aria-current="page">FAQ</span>
          </nav>

          <div className="faq-hero-grid">
            <div className="faq-hero-copy">
              <span className="faq-kicker">PUSAT BANTUAN • DBMSDA KOTA BEKASI</span>
              <h1 className="faq-title">
                Pertanyaan yang Sering <span>Diajukan</span>
              </h1>
              <p className="faq-subtitle">
                Temukan jawaban seputar layanan jalan dan jembatan, drainase dan
                sumber daya air, perizinan dan rekomendasi teknis, serta informasi
                publik Dinas Bina Marga dan Sumber Daya Air Kota Bekasi.
              </p>

              <div className="faq-hero-actions">
                <a href="#daftar-faq" className="faq-btn faq-btn-primary">
                  Lihat Daftar FAQ <span aria-hidden="true">›</span>
                </a>
                <a href="tel:112" className="faq-btn faq-btn-ghost">
                  Call Center 112
                </a>
              </div>

              <div className="faq-stats" aria-label="Statistik FAQ">
                <div className="faq-stat">
                  <b>{faqs.length}</b>
                  <span>Total Pertanyaan</span>
                </div>
                <div className="faq-stat">
                  <b>{categories.length}</b>
                  <span>Kategori Bantuan</span>
                </div>
                <div className="faq-stat">
                  <b>112</b>
                  <span>Call Center Siaga</span>
                </div>
              </div>
            </div>

            <div className="faq-hero-card" aria-hidden="true">
              <div className="faq-hero-illus">
                <div className="faq-illus-top">
                  <span className="faq-illus-dot" />
                  <span className="faq-illus-dot" />
                  <span className="faq-illus-dot" />
                </div>
                <div className="faq-illus-body">
                  <div className="faq-illus-q">Q</div>
                  <div className="faq-illus-lines">
                    <span />
                    <span />
                    <span />
                  </div>
                </div>
                <div className="faq-illus-badge">DBMSDA • PUSAT BANTUAN</div>
              </div>
              <div className="faq-hero-note">
                <strong>Butuh jawaban cepat?</strong>
                <p>Gunakan kolom pencarian atau pilih kategori di bawah. Jika belum menemukan jawaban, hubungi Call Center 112 Kota Bekasi atau PPID DBMSDA.</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="faq-toolbar ui-section" aria-label="Filter FAQ">
        <div className="ui-wrap">
          <div className="faq-toolbar-inner">
            <form
              className="faq-search"
              role="search"
              onSubmit={(e) => e.preventDefault()}
              aria-label="Cari FAQ"
            >
              <span className="faq-search-icon" aria-hidden="true">⌕</span>
              <input
                type="search"
                value={query}
                onChange={(e) => setQuery(e.target.value.slice(0, SEARCH_MAX_LENGTH))}
                placeholder="Cari pertanyaan — mis. jalan rusak, drainase mampet, banjir, PPID, perizinan…"
                aria-label="Cari pertanyaan FAQ"
                maxLength={SEARCH_MAX_LENGTH}
              />
              {query && (
                <button
                  type="button"
                  className="faq-clear"
                  onClick={() => setQuery("")}
                  aria-label="Hapus pencarian"
                >
                  ✕
                </button>
              )}
            </form>

            <div className="faq-meta">
              <span className="faq-count" role="status" aria-live="polite">
                {totalLabel}
              </span>
              <div className="faq-expand-actions">
                <button type="button" className="faq-mini-btn" onClick={expandAll}>
                  Buka semua
                </button>
                <button type="button" className="faq-mini-btn" onClick={collapseAll}>
                  Tutup semua
                </button>
              </div>
            </div>
          </div>

          <div className="faq-chips" role="tablist" aria-label="Kategori FAQ">
            <button
              type="button"
              role="tab"
              aria-selected={activeCategory === "semua"}
              className={`faq-chip ${activeCategory === "semua" ? "is-active" : ""}`}
              onClick={() => setActiveCategory("semua")}
            >
              Semua <span className="faq-chip-count">{faqs.length}</span>
            </button>
            {categories.map((cat) => {
              const count = countsByCategory.get(cat.id) ?? 0;
              return (
                <button
                  key={cat.id}
                  type="button"
                  role="tab"
                  aria-selected={activeCategory === cat.id}
                  className={`faq-chip ${activeCategory === cat.id ? "is-active" : ""}`}
                  onClick={() => setActiveCategory(cat.id)}
                >
                  <span aria-hidden="true" className="faq-chip-icon">{cat.icon}</span>
                  {cat.label} <span className="faq-chip-count">{count}</span>
                </button>
              );
            })}
          </div>
        </div>
      </section>

      <section id="daftar-faq" className="faq-list ui-section" aria-label="Daftar FAQ">
        <div className="ui-wrap">
          {faqs.length === 0 ? (
            <div className="faq-empty" role="status">
              <div className="faq-empty-icon" aria-hidden="true">?</div>
              <h2>Belum ada pertanyaan</h2>
              <p>Saat ini belum ada pertanyaan yang tersedia. Silakan cek kembali nanti atau hubungi Call Center 112 Kota Bekasi / PPID DBMSDA.</p>
              <div className="faq-empty-actions">
                <a href="tel:112" className="faq-btn faq-btn-primary">Call Center 112</a>
              </div>
            </div>
          ) : grouped.length === 0 ? (
            <div className="faq-empty" role="status">
              <div className="faq-empty-icon" aria-hidden="true">?</div>
              <h2>Tidak ditemukan hasil</h2>
              <p>
                Tidak ada pertanyaan yang cocok dengan <strong>“{query.trim()}”</strong>
                {activeCategory !== "semua" && (
                  <>
                    {" "}
                    pada kategori <strong>{categories.find((c) => c.id === activeCategory)?.label}</strong>
                  </>
                )}
                . Coba gunakan kata kunci yang lebih singkat atau pilih kategori lain.
              </p>
              <div className="faq-empty-actions">
                <button
                  type="button"
                  className="faq-btn faq-btn-primary"
                  onClick={() => {
                    setQuery("");
                    setActiveCategory("semua");
                  }}
                >
                  Tampilkan semua FAQ
                </button>
              </div>
            </div>
          ) : (
            <div className="faq-groups">
              {grouped.map(({ cat, items }) => (
                <div key={cat.id} className="faq-group">
                  <div className="faq-group-head">
                    <div className="faq-group-icon" aria-hidden="true">
                      {cat.icon}
                    </div>
                    <div>
                      <h2 className="faq-group-title">{cat.label.toUpperCase()}</h2>
                      <p className="faq-group-desc">
                        {cat.description} • {items.length} pertanyaan
                      </p>
                    </div>
                  </div>

                  <div className="faq-accordion">
                    {items.map((item, idx) => {
                      const isOpen = openIds.has(item.id);
                      const panelId = `${baseId}-${item.id}-panel`;
                      const btnId = `${baseId}-${item.id}-btn`;
                      return (
                        <article key={item.id} className={`faq-item ${isOpen ? "is-open" : ""}`}>
                          <h3 className="faq-q-head">
                            <button
                              id={btnId}
                              type="button"
                              className="faq-q-btn"
                              aria-expanded={isOpen}
                              aria-controls={panelId}
                              onClick={() => toggle(item.id)}
                            >
                              <span className="faq-q-num" aria-hidden="true">
                                {String(idx + 1).padStart(2, "0")}
                              </span>
                              <span className="faq-q-text">{item.question}</span>
                              <span className="faq-q-chevron" aria-hidden="true" />
                            </button>
                          </h3>
                          <div
                            id={panelId}
                            role="region"
                            aria-labelledby={btnId}
                            className="faq-a"
                            hidden={!isOpen}
                          >
                            <div className="faq-a-inner">
                              {item.paragraphs.length > 0 ? (
                                item.paragraphs.map((p, i) => <p key={i}>{p}</p>)
                              ) : (
                                <p>{item.answer}</p>
                              )}
                            </div>
                          </div>
                        </article>
                      );
                    })}
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </section>

      <section className="faq-cta ui-section" aria-label="Catatan FAQ">
        <div className="ui-wrap">
          <div className="faq-disclaimer">
            <p>
              <strong>Belum menemukan jawaban?</strong> Silakan merujuk pada dokumen resmi
              di halaman Informasi Publik DBMSDA Kota Bekasi, atau hubungi Call Center 112
              dan PPID DBMSDA untuk bantuan lebih lanjut.
            </p>
          </div>
        </div>
      </section>
    </>
  );
}
