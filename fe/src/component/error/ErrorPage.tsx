export function ErrorPage() {
  return (
    <section className="err-hero ui-section ui-section-top" aria-labelledby="err-title">
      <div className="ui-wrap">
        <div className="err-grid">
          {/* LEFT */}
          <div className="err-copy">
            <span className="err-kicker">404 • HALAMAN TIDAK DITEMUKAN</span>
            <div className="err-code" aria-hidden="true">
              <span>404</span>
              <span className="err-code-ghost">404</span>
            </div>
            <h1 id="err-title" className="err-title">
              Sepertinya Anda <span>tersesat</span>
            </h1>
            <p className="err-desc">
              Halaman yang Anda cari tidak tersedia, sudah dipindahkan, atau alamatnya salah ketik.
              Tenang — kami bantu arahkan kembali ke jalur yang benar.
            </p>

            <div className="err-actions">
              <a href="/" className="err-btn err-btn-primary">
                Kembali ke Beranda <span aria-hidden="true">→</span>
              </a>
              <a href="/dokumen" className="err-btn err-btn-ghost">
                Cari Dokumen
              </a>
              <a href="tel:112" className="err-btn err-btn-ghost">
                Call Center 112
              </a>
            </div>

            <div className="err-path" role="status" aria-live="polite">
              <span className="err-path-label">URL yang diminta:</span>
              <code className="err-path-code">{typeof window !== "undefined" ? window.location.pathname : "/404"}</code>
            </div>

            <div className="err-quick">
              <h2>Atau coba halaman populer</h2>
              <div className="err-quick-grid">
                <a href="/berita" className="err-quick-card">
                  <span className="err-quick-icon">📰</span>
                  <strong>Berita</strong>
                  <span>Informasi terbaru DBMSDA</span>
                </a>
                <a href="/dokumen" className="err-quick-card">
                  <span className="err-quick-icon">📄</span>
                  <strong>Dokumen</strong>
                  <span>Peraturan &amp; data teknis</span>
                </a>
                <a href="/layanan" className="err-quick-card">
                  <span className="err-quick-icon">🛎️</span>
                  <strong>Layanan</strong>
                  <span>PPID &amp; pelayanan publik</span>
                </a>
                <a href="/faq" className="err-quick-card">
                  <span className="err-quick-icon">❓</span>
                  <strong>FAQ</strong>
                  <span>Jawaban cepat</span>
                </a>
              </div>
            </div>
          </div>

          {/* RIGHT ILLUSTRATION */}
          <div className="err-visual" aria-hidden="true">
            <div className="err-illus">
              <div className="err-illus-top">
                <span />
                <span />
                <span />
              </div>
              <div className="err-illus-body">
                <div className="err-illus-road">
                  <span className="err-road-line" />
                  <span className="err-road-line" />
                </div>
                <div className="err-illus-sign">
                  <span>404</span>
                  <small>Tidak Ditemukan</small>
                </div>
                <div className="err-illus-pin">📍</div>
              </div>
              <div className="err-illus-foot">
                <span>DBMSDA Kota Bekasi</span>
                <span>Bina Marga • SDA</span>
              </div>
            </div>
            <p className="err-visual-note">Ilustrasi: ruang jalan &amp; penanda lokasi yang hilang — kembali ke peta utama.</p>
          </div>
        </div>
      </div>
    </section>
  );
}
