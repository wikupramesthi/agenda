import { useApiData } from "../../app/useApiData";
import { fetchLatestBannerByPosisi } from "../../data/banners";

function VisionMission() {
  return (
    <>
      <section className="ui-vision fill-navy">
        <div className="ui-vision-top">
          <div className="ui-wrap">
            <h1 className="ui-vision-heading">VISI &amp; MISI</h1>
            <div className="ui-vision-lead">
              <h2 className="ui-vision-lead-title">Visi DBMSDA</h2>
              <div className="ui-vision-lead-desc">Terwujudnya infrastruktur bina marga dan pengelolaan sumber daya air yang handal, berkelanjutan, dan berkeadilan untuk mendukung Kota Bekasi yang aman, nyaman, dan berdaya saing.</div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
}

function RuangLingkup() {
  return (
    <section className="ruanglingkup sectionpora">
      <div className="ui-wrap">
        <div className="ruling">
          <div className="ruling-left">
            <h2 className="ruling-title">RUANG LINGKUP</h2>
          </div>
          <div className="ruling-right">
            <div className="ruling-desc">
              <p>
                Dinas Bina Marga dan Sumber Daya Air Kota Bekasi berkedudukan sebagai unsur pembantu Wali Kota dalam
                penyelenggaraan urusan Pemerintahan bidang Pekerjaan Umum meliputi Bina Marga, Sumber Daya Air,
                Drainase, Pengembangan Jasa Konstruksi serta Pemanfaatan Ruang Jalan dan Taman{" "}
                <em>(Pasal 2, Perwal Kota Bekasi Nomor 20 Tahun 2024)</em>.
              </p>
              <p>
                Sesuai{" "}
                <a
                  href="https://jdih.bekasikota.go.id/storage/peraturan/1765177091430-262913767.pdf"
                  target="_blank"
                  rel="noopener noreferrer"
                  style={{ color: "var(--ui-blue)", textDecoration: "underline", textUnderlineOffset: "2px" }}
                >
                  Peraturan Wali Kota Bekasi Nomor 20 Tahun 2024
                </a>{" "}
                tentang Kedudukan, Susunan Organisasi, Tugas Pokok dan Fungsi serta Tata Kerja pada Dinas Bina Marga
                dan Sumber Daya Air Kota Bekasi, DBMSDA mempunyai tugas membantu Wali Kota dalam memimpin,
                mengendalikan, dan mengkoordinasikan perumusan kebijakan teknis dan pelaksanaan fungsi urusan
                pemerintahan yang menjadi kewenangan Dinas yang meliputi bidang bina marga, sumber daya air,
                perencanaan dan jasa konstruksi serta pemanfaatan ruang jalan dan taman <em>(Pasal 4 ayat 1)</em>.
                Susunan organisasi terdiri atas Kepala Dinas, Sekretariat (Subbagian Umum dan Kepegawaian &amp;
                Subbagian Keuangan), Bidang Bina Marga, Bidang Sumber Daya Air, Bidang Perencanaan dan Jasa
                Konstruksi, Bidang Pemanfaatan Ruang Jalan dan Taman, Unit Pelaksana Teknis Daerah, dan Kelompok
                Jabatan Fungsional <em>(Pasal 3)</em>.
              </p>
            </div>
            <div className="fungsi">
              <div className="fungsi-top">Dalam melaksanakan tugasnya, DBMSDA menyelenggarakan fungsi:</div>
            </div>
            <div className="xgrid">
              <div className="xgrid-container">
                <span className="xgrid-num">1.</span>
                <div className="xgrid-text">
                  Perumusan dan penetapan kebijakan di bidang bina marga, sumber daya air, drainase, pengembangan jasa
                  konstruksi serta pemanfaatan ruang jalan dan taman;
                </div>
              </div>
              <div className="xgrid-container">
                <span className="xgrid-num">2.</span>
                <div className="xgrid-text">
                  Koordinasi dan sinkronisasi pelaksanaan kebijakan di bidang pelayanan jalan, jembatan, drainase, dan
                  pengelolaan sumber daya air;
                </div>
              </div>
              <div className="xgrid-container">
                <span className="xgrid-num">3.</span>
                <div className="xgrid-text">
                  Koordinasi pelaksanaan tugas, pembinaan, dan pemberian dukungan administrasi kepada seluruh unsur
                  organisasi di lingkungan Dinas;
                </div>
              </div>
              <div className="xgrid-container">
                <span className="xgrid-num">4.</span>
                <div className="xgrid-text">Pengelolaan barang milik/kekayaan daerah yang menjadi tanggung jawab Dinas;</div>
              </div>
              <div className="xgrid-container">
                <span className="xgrid-num">5.</span>
                <div className="xgrid-text">Pengawasan atas pelaksanaan tugas di lingkungan Dinas; dan</div>
              </div>
              <div className="xgrid-container">
                <span className="xgrid-num">6.</span>
                <div className="xgrid-text">Pelaksanaan fungsi lain yang diberikan oleh Wali Kota sesuai tugas dan fungsinya.</div>
              </div>
            </div>
          </div>
        </div>
      </div>

    </section>
  );
}

function Struktur() {
  const { data: infografis } = useApiData(() => fetchLatestBannerByPosisi("infografis"), [], "banner-infografis");

  return (
    <section className="struktur sectionpora bg-blue">
      <div className="ui-wrap">
        <div className="str">
          <div className="str-left">
            <h2 className="str-title">STRUKTUR DINAS BINA MARGA DAN SUMBER DAYA AIR KOTA BEKASI</h2>
            <div className="str-download">
              <a
                href="https://jdih.bekasikota.go.id/storage/peraturan/1765177091430-262913767.pdf"
                target="_blank"
                rel="noopener noreferrer"
              >
                DOWNLOAD STRUKTUR (PERWAL 20/2024)
              </a>
            </div>
          </div>
          <div className="str-right">
            {infografis?.image ? (
              infografis.link ? (
                <a href={infografis.link} target="_blank" rel="noopener noreferrer">
                  <img alt={infografis.name || "Infografis Struktur Organisasi"} src={infografis.image} loading="lazy" />
                </a>
              ) : (
                <img alt={infografis.name || "Infografis Struktur Organisasi"} src={infografis.image} loading="lazy" />
              )
            ) : null}
          </div>
        </div>
      </div>
    </section>
  );
}

export function AboutPage() {
  return (
    <>
      <VisionMission />
      <RuangLingkup />
      <Struktur />
    </>
  );
}
