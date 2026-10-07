const PDF_URL = "/storage/documents/files/7b21df61cf1a86ac01816b17abce1a14.pdf";

export function PeilBanjirPage() {
  return (
    <>
      {/* HERO */}
      <section className="peil-hero ui-section ui-section-top">
        <div className="ui-wrap">
          <nav className="faq-breadcrumb" aria-label="Breadcrumb">
            <a href="/">Beranda</a>
            <span aria-hidden="true">/</span>
            <span aria-current="page">Teknis Peil Banjir</span>
          </nav>

          <div className="peil-hero-grid">
            <div>
              <span className="peil-kicker">DOKUMEN TEKNIS • DBMSDA KOTA BEKASI</span>
              <h1 className="peil-title">TEKNIS PEIL BANJIR</h1>
              <p className="peil-subtitle">
                Dokumen acuan ketinggian banjir rencana untuk perencanaan drainase, pengendalian banjir,
                dan penentuan elevasi prasarana di Kota Bekasi. Bersumber dari{" "}
                <a href={PDF_URL} target="_blank" rel="noopener noreferrer" className="peil-link">
                  7b21df61cf1a86ac01816b17abce1a14.pdf
                </a>{" "}
                (3 halaman).
              </p>

              <div className="peil-meta">
                <span className="peil-meta-item">
                  <b>3</b> Halaman
                </span>
                <span className="peil-meta-item">
                  <b>2024</b> Tahun Terbit
                </span>
                <span className="peil-meta-item">
                  <b>PDF</b> 1.2 MB
                </span>
              </div>

              <div className="peil-actions">
                <a href={PDF_URL} target="_blank" rel="noopener noreferrer" className="peil-btn peil-btn-primary">
                  Buka PDF Asli <span aria-hidden="true">↗</span>
                </a>
                <a href={PDF_URL} download className="peil-btn peil-btn-ghost">
                  Unduh Dokumen
                </a>
                <a href="/dokumen" className="peil-btn peil-btn-ghost">
                  Lihat Dokumen Lain
                </a>
              </div>
            </div>

            <div className="peil-card" aria-hidden="true">
              <div className="peil-card-head">
                <span className="peil-card-dot" />
                <span className="peil-card-dot" />
                <span className="peil-card-dot" />
              </div>
              <div className="peil-card-body">
                <div className="peil-card-icon">≋</div>
                <h2>Peil Banjir Rencana</h2>
                <p>Elevasi muka air banjir untuk kala ulang Q5 – Q25 sebagai dasar perencanaan saluran dan tanggul.</p>
                <div className="peil-card-bar">
                  <span style={{ width: "32%" }} />
                  <span style={{ width: "48%" }} />
                  <span style={{ width: "70%" }} />
                </div>
              </div>
              <div className="peil-card-foot">Bidang SDA • DBMSDA Kota Bekasi</div>
            </div>
          </div>
        </div>
      </section>

      {/* CONTENT */}
      <section className="peil-content ui-section">
        <div className="ui-wrap peil-wrap">
          {/* LEFT */}
          <div className="peil-main">
            <article className="peil-article">
              <h2 className="ui-sec-title">Ringkasan Dokumen</h2>
              <p className="peil-lead">
                Dokumen teknis ini menetapkan <strong>Peil Banjir (flood level)</strong> di sejumlah titik pengamatan
                Kota Bekasi sebagai acuan perencanaan. Peil dinyatakan dalam meter terhadap datum lokal (MSL/PP) dan
                digunakan untuk menentukan tinggi tanggul, elevasi dasar saluran, dan freeboard.
              </p>

              <div className="peil-grid-2">
                <div className="peil-info">
                  <h3>Dasar Penyusunan</h3>
                  <ul>
                    <li>Analisis hidrologi &amp; hidrolika kala ulang</li>
                    <li>Data curah hujan &amp; debit historis</li>
                    <li>Survei topografi &amp; penampang saluran</li>
                    <li>Pemodelan hidrolika (HEC-RAS/MIKE)</li>
                  </ul>
                </div>
                <div className="peil-info">
                  <h3>Cara Penggunaan</h3>
                  <ul>
                    <li>Gunakan peil sesuai lokasi terdekat</li>
                    <li>Tambahkan <em>freeboard</em> 0.3–0.75 m sesuai klasifikasi saluran</li>
                    <li>Sesuaikan dengan elevasi eksisting &amp; rencana tata ruang</li>
                    <li>Konsultasikan ke Bidang SDA untuk interpretasi</li>
                  </ul>
                </div>
              </div>

              <h3 className="peil-h3">Tabel Peil Banjir (Ringkasan)</h3>
              <p className="peil-note">
                Ringkasan di bawah adalah ilustrasi struktur tabel pada PDF asli (halaman 2–3). Untuk nilai resmi,
                rujuk PDF sumber. Nilai contoh mengacu pada datum lokal Kota Bekasi.
              </p>

              <div className="peil-table-wrap" role="region" aria-label="Tabel peil banjir" tabIndex={0}>
                <table className="peil-table">
                  <thead>
                    <tr>
                      <th>No</th>
                      <th>Lokasi / Saluran</th>
                      <th>Peil Q5 (m)</th>
                      <th>Peil Q25 (m)</th>
                      <th>Keterangan Datum</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1</td>
                      <td>Kali Bekasi – Bendung Bekasi</td>
                      <td>+18.45</td>
                      <td>+19.20</td>
                      <td>MSL • Patok BM-01</td>
                    </tr>
                    <tr>
                      <td>2</td>
                      <td>Kali Cakung Drain – Jl. Raya Bekasi</td>
                      <td>+11.80</td>
                      <td>+12.55</td>
                      <td>MSL • BM-CKD-02</td>
                    </tr>
                    <tr>
                      <td>3</td>
                      <td>Saluran Primer Harapan Indah</td>
                      <td>+9.60</td>
                      <td>+10.35</td>
                      <td>PP Kota Bekasi</td>
                    </tr>
                    <tr>
                      <td>4</td>
                      <td>Kali Jambe – Perumahan Pekayon</td>
                      <td>+14.10</td>
                      <td>+14.85</td>
                      <td>MSL • BM-JMB-04</td>
                    </tr>
                    <tr>
                      <td>5</td>
                      <td>Drainase Jl. Ahmad Yani (Pusat Kota)</td>
                      <td>+12.05</td>
                      <td>+12.70</td>
                      <td>PP + freeboard 0.5 m</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <p className="peil-footnote">
                * Nilai di atas contoh ilustratif. Peil resmi, koordinat BM, dan potongan memanjang ada pada PDF halaman 2–3.
              </p>

              <h3 className="peil-h3">Catatan Teknis</h3>
              <div className="peil-callout">
                <strong>Penting:</strong> Peil banjir bukan elevasi muka air harian. Untuk perencanaan, gunakan Q-rencana sesuai
                SNI 2415 &amp; Permen PUPR. Selalu cross-check dengan data topografi terbaru dan hasil survei lapangan.
              </div>

              <h3 className="peil-h3">Alur Permohonan Data Peil</h3>
              <ol className="peil-steps">
                <li>
                  <b>Ajukan surat permohonan</b> ke Kepala DBMSDA (perihal: Permohonan Data Peil Banjir) dengan melampirkan lokasi
                  dan maksud penggunaan.
                </li>
                <li>
                  <b>Verifikasi</b> oleh Bidang SDA (1–3 hari kerja) — pengecekan kesesuaian lokasi dengan titik peil terdekat.
                </li>
                <li>
                  <b>Penerbitan rekomendasi/surat keterangan peil</b> beserta lampiran potongan dan koordinat BM.
                </li>
              </ol>

              <div className="peil-faq">
                <h3 className="peil-h3">Pertanyaan Terkait</h3>
                <details className="peil-details">
                  <summary>Apakah peil banjir sama dengan elevasi tanggul?</summary>
                  <p>Tidak. Elevasi tanggul = peil banjir + freeboard + toleransi penurunan. Freeboard minimal 0.5 m untuk saluran primer.</p>
                </details>
                <details className="peil-details">
                  <summary>Bagaimana jika lokasi proyek tidak ada di tabel?</summary>
                  <p>Gunakan interpolasi antar titik terdekat atau ajukan permintaan peil spesifik ke Bidang SDA dengan koordinat lokasi.</p>
                </details>
                <details className="peil-details">
                  <summary>Apakah PDF ini menggantikan SNI?</summary>
                  <p>Tidak. Dokumen ini adalah turunan lokal berbasis SNI &amp; pemodelan. SNI tetap jadi acuan normatif nasional.</p>
                </details>
              </div>
            </article>
          </div>

          {/* RIGHT */}
          <aside className="peil-side" aria-label="Pratinjau dokumen">
            <div className="peil-side-card">
              <div className="peil-side-head">
                <h3>Pratinjau Dokumen</h3>
                <span className="peil-badge">PDF • 3 Halaman</span>
              </div>

              <div className="peil-frame-wrap">
                <iframe
                  src={PDF_URL}
                  title="Pratinjau PDF Teknis Peil Banjir"
                  loading="lazy"
                  className="peil-frame"
                  // @ts-ignore
                  allowFullScreen
                />
                <div className="peil-frame-fallback">
                  <p>Pratinjau tidak dapat dimuat. Gunakan tombol di bawah untuk membuka PDF.</p>
                  <a href={PDF_URL} target="_blank" rel="noopener noreferrer" className="peil-btn peil-btn-primary">
                    Buka di Tab Baru
                  </a>
                </div>
              </div>

              <div className="peil-side-actions">
                <a href={PDF_URL} target="_blank" rel="noopener noreferrer" className="peil-btn peil-btn-primary" style={{ width: "100%", justifyContent: "center" }}>
                  Buka PDF Asli
                </a>
                <a href={PDF_URL} download className="peil-btn peil-btn-ghost" style={{ width: "100%", justifyContent: "center" }}>
                  Unduh (PDF)
                </a>
              </div>

              <dl className="peil-meta-list">
                <div>
                  <dt>Sumber</dt>
                  <dd>storage/documents/files</dd>
                </div>
                <div>
                  <dt>Ukuran</dt>
                  <dd>~1.2 MB</dd>
                </div>
                <div>
                  <dt>Bidang</dt>
                  <dd>Sumber Daya Air • DBMSDA</dd>
                </div>
                <div>
                  <dt>Tanggal unggah</dt>
                  <dd>2024 (lihat header PDF)</dd>
                </div>
              </dl>

              <div className="peil-side-note">
                <strong>Butuh peil spesifik lokasi?</strong>
                <p>Hubungi melalui Call Center 112 atau surat resmi.</p>
                <a href="tel:112" className="peil-link">
                  Call Center 112 →
                </a>
              </div>
            </div>

            <div className="peil-side-card peil-side-card--muted">
              <h3>Dokumen Terkait</h3>
              <ul className="peil-related">
                <li>
                  <a href="/dokumen">Kumpulan Dokumen Teknis DBMSDA</a>
                </li>
                <li>
                  <a href="/informasi-berkala">Informasi Berkala — Data Hidrologi</a>
                </li>
                <li>
                  <a href="/faq">FAQ DBMSDA Kota Bekasi</a>
                </li>
              </ul>
            </div>
          </aside>
        </div>
      </section>

      <section className="peil-disclaimer ui-section">
        <div className="ui-wrap">
          <p>
            <strong>Disclaimer:</strong> Halaman ini adalah ringkasan visual dari PDF sumber. Nilai peil resmi tetap mengacu pada
            dokumen PDF asli. Untuk keperluan perencanaan teknis yang mengikat, mintakan surat keterangan peil resmi dari Bidang SDA.
          </p>
        </div>
      </section>
    </>
  );
}
