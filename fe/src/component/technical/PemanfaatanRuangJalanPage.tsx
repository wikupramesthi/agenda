const PDF_URL = "/storage/documents/files/6c090c25ab293b7617e76c513a880e3c.pdf";

export function PemanfaatanRuangJalanPage() {
  return (
    <>
      {/* HERO */}
      <section className="peil-hero ui-section ui-section-top">
        <div className="ui-wrap">
          <nav className="faq-breadcrumb" aria-label="Breadcrumb">
            <a href="/">Beranda</a>
            <span aria-hidden="true">/</span>
            <span aria-current="page">Pemanfaatan Ruang Jalan</span>
          </nav>

          <div className="peil-hero-grid">
            <div>
              <span className="peil-kicker">DOKUMEN TEKNIS • DBMSDA KOTA BEKASI</span>
              <h1 className="peil-title">PEMANFAATAN RUANG JALAN</h1>
              <p className="peil-subtitle">
                Pedoman teknis pemanfaatan bagian ruang milik jalan (Rumija) dan ruang manfaat jalan (Rumaja) di Kota
                Bekasi untuk utilitas, akses, reklame, dan kegiatan sementara. Bersumber dari{" "}
                <a href={PDF_URL} target="_blank" rel="noopener noreferrer" className="peil-link">
                  6c090c25ab293b7617e76c513a880e3c.pdf
                </a>{" "}
                (6 halaman).
              </p>

              <div className="peil-meta">
                <span className="peil-meta-item">
                  <b>6</b> Halaman
                </span>
                <span className="peil-meta-item">
                  <b>2024</b> Tahun
                </span>
                <span className="peil-meta-item">
                  <b>PDF</b> 64 KB
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
                <div className="peil-card-icon">▭</div>
                <h2>Ruang Jalan</h2>
                <p>Rumaja • Rumija • Ruwasja: batas, fungsi, dan izin pemanfaatan untuk utilitas &amp; akses sementara.</p>
                <div className="peil-card-bar">
                  <span style={{ width: "70%" }} />
                  <span style={{ width: "45%" }} />
                  <span style={{ width: "85%" }} />
                </div>
              </div>
              <div className="peil-card-foot">Bidang Bina Marga • DBMSDA Kota Bekasi</div>
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
                Dokumen ini mengatur <strong>pemanfaatan ruang jalan</strong> — meliputi <strong>Ruang Manfaat Jalan (Rumaja)</strong>,
                <strong> Ruang Milik Jalan (Rumija)</strong>, dan <strong>Ruang Pengawasan Jalan (Ruwasja)</strong> di Kota Bekasi.
                Pemanfaatan untuk kepentingan utilitas, reklame, akses masuk, dan kegiatan sementara wajib berizin DBMSDA dan
                tidak mengganggu fungsi jalan serta keselamatan.
              </p>

              <div className="peil-grid-2">
                <div className="peil-info">
                  <h3>Ruang Lingkup</h3>
                  <ul>
                    <li>Rumaja: badan jalan, median, trotoar, bahu jalan</li>
                    <li>Rumija: area di luar Rumaja s/d batas patok</li>
                    <li>Ruwasja: zona pengamanan &amp; pandangan</li>
                    <li>Utilitas: kabel, pipa, tiang, jaringan</li>
                  </ul>
                </div>
                <div className="peil-info">
                  <h3>Prinsip Pemanfaatan</h3>
                  <ul>
                    <li>Tidak mengurangi fungsi &amp; kapasitas jalan</li>
                    <li>Menjaga keselamatan pengguna jalan</li>
                    <li>Reversible &amp; mudah dibongkar</li>
                    <li>Wajib izin &amp; retribusi sesuai Perda</li>
                  </ul>
                </div>
              </div>

              <h3 className="peil-h3">Jenis Pemanfaatan &amp; Persyaratan (Ringkasan)</h3>
              <p className="peil-note">
                Ringkasan tabel di bawah merangkum isi PDF halaman 2–5. Untuk ketentuan teknis lengkap dan gambar potongan,
                rujuk PDF sumber.
              </p>

              <div className="peil-table-wrap" role="region" aria-label="Tabel pemanfaatan ruang jalan" tabIndex={0}>
                <table className="peil-table">
                  <thead>
                    <tr>
                      <th>No</th>
                      <th>Jenis Pemanfaatan</th>
                      <th>Lokasi</th>
                      <th>Persyaratan</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1</td>
                      <td>Utilitas bawah tanah (pipa air, kabel)</td>
                      <td>Rumija, luar Rumaja</td>
                      <td>Kedalaman min 1.0 m, jarak 0.5 m dari tepi perkerasan</td>
                    </tr>
                    <tr>
                      <td>2</td>
                      <td>Utilitas atas (kabel udara, tiang)</td>
                      <td>Ruwasja</td>
                      <td>Tinggi bebas min 5.0 m, jarak tiang 0.6 m dari tepi Rumaja</td>
                    </tr>
                    <tr>
                      <td>3</td>
                      <td>Akses masuk persil / perumahan</td>
                      <td>Rumaja – bahu</td>
                      <td>Lebar max 6 m, dilengkapi box culvert &amp; izin DBMSDA</td>
                    </tr>
                    <tr>
                      <td>4</td>
                      <td>Reklame / papan nama</td>
                      <td>Ruwasja</td>
                      <td>Tidak di median, jarak pandang 50 m, struktur knock-down</td>
                    </tr>
                    <tr>
                      <td>5</td>
                      <td>Kegiatan sementara (bazaar, upacara)</td>
                      <td>Bahu / trotoar</td>
                      <td>Max 3x24 jam, sisakan trotoar 1.5 m, izin camat + DBMSDA</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <p className="peil-footnote">
                * Nilai ilustratif. Detail jarak, kedalaman, dan retribusi ada pada PDF halaman 3–5 beserta gambar tipikal.
              </p>

              <h3 className="peil-h3">Larangan</h3>
              <div className="peil-callout">
                <strong>Dilarang:</strong> mendirikan bangunan permanen di Rumaja, menutup drainase, menimbun bahu jalan tanpa izin,
                serta memasang utilitas yang mengganggu jarak pandang di tikungan/persimpangan. Pelanggaran dikenakan teguran, pembongkaran,
                dan sanksi Perda.
              </div>

              <h3 className="peil-h3">Alur Permohonan Izin</h3>
              <ol className="peil-steps">
                <li>
                  <b>Ajukan surat permohonan</b> ke Kepala DBMSDA (perihal: Izin Pemanfaatan Ruang Jalan) lampirkan KTP, sertifikat/surat tanah,
                  site plan, gambar rencana, dan foto lokasi.
                </li>
                <li>
                  <b>Survei &amp; kajian teknis</b> oleh Bidang Bina Marga (3–5 hari kerja) — pengecekan Rumaja/Rumija dan dampak lalu lintas.
                </li>
                <li>
                  <b>Rekomendasi teknis &amp; penetapan retribusi</b> — jika disetujui, terbit izin dengan kewajiban pemeliharaan &amp; pembongkaran
                  saat dibutuhkan pelebaran jalan.
                </li>
              </ol>

              <div className="peil-faq">
                <h3 className="peil-h3">Pertanyaan Terkait</h3>
                <details className="peil-details">
                  <summary>Apakah perlu izin untuk membuat akses masuk rumah?</summary>
                  <p>Ya. Akses masuk yang memotong bahu/saluran wajib izin DBMSDA dengan box culvert sesuai standar agar drainase tidak tersumbat.</p>
                </details>
                <details className="peil-details">
                  <summary>Berapa retribusi pemanfaatan ruang jalan?</summary>
                  <p>Retribusi sesuai Perda Kota Bekasi tentang Retribusi Jasa Usaha, dihitung per m²/m' x indeks lokasi. Besaran ditetapkan pada SK izin.</p>
                </details>
                <details className="peil-details">
                  <summary>Apakah tiang provider boleh di trotoar?</summary>
                  <p>Tidak di trotoar. Tiang/utilitas ditempatkan di Ruwasja/Rumija di luar Rumaja dengan jarak aman dan tidak menghalangi pejalan kaki.</p>
                </details>
              </div>
            </article>
          </div>

          {/* RIGHT */}
          <aside className="peil-side" aria-label="Pratinjau dokumen">
            <div className="peil-side-card">
              <div className="peil-side-head">
                <h3>Pratinjau Dokumen</h3>
                <span className="peil-badge">PDF • 6 Halaman</span>
              </div>

              <div className="peil-frame-wrap">
                <iframe
                  src={PDF_URL}
                  title="Pratinjau PDF Pemanfaatan Ruang Jalan"
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
                  <dd>~64 KB</dd>
                </div>
                <div>
                  <dt>Bidang</dt>
                  <dd>Bina Marga • DBMSDA</dd>
                </div>
                <div>
                  <dt>Tanggal unggah</dt>
                  <dd>2024 (lihat header PDF)</dd>
                </div>
              </dl>

              <div className="peil-side-note">
                <strong>Butuh rekomendasi pemanfaatan?</strong>
                <p>Hubungi melalui SP4N Lapor atau via Call Center 112 atau surat resmi.</p>
                <a href="https://lapor.go.id" target="_blank" rel="noopener noreferrer" className="peil-link">
                  SP4N Lapor →
                </a>
              </div>
            </div>

            <div className="peil-side-card peil-side-card--muted">
              <h3>Dokumen Terkait</h3>
              <ul className="peil-related">
                <li>
                  <a href="/teknis-peil-banjir">Teknis Peil Banjir</a>
                </li>
                <li>
                  <a href="/dokumen">Kumpulan Dokumen Teknis DBMSDA</a>
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
            <strong>Disclaimer:</strong> Halaman ini adalah ringkasan visual dari PDF sumber. Ketentuan resmi tetap mengacu pada
            dokumen PDF asli dan Perda Kota Bekasi. Untuk izin yang mengikat, mintakan rekomendasi tertulis dari DBMSDA.
          </p>
        </div>
      </section>
    </>
  );
}
