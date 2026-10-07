import { asset } from "../../app/assets";
import { useApiData } from "../../app/useApiData";
import { fetchLatestBannerByPosisi } from "../../data/banners";

export function JournalSection() {
  const { data: mitra } = useApiData(() => fetchLatestBannerByPosisi("mitra"), [], "banner-mitra");

  // Kanan: 1 banner terakhir kategori mitra — cukup gambar saja, ukuran dikunci agar tidak goyang saat scroll (CLS).
  const mitraImgStyle: React.CSSProperties = { display: "block", width: "100%", objectFit: "cover", borderRadius: 16, background: "#142058" };
  const mitraCard = mitra ? (
    mitra.link?.trim() ? (
      <a className="ui-duo-col" href={mitra.link} target="_blank" rel="noopener noreferrer" aria-label={mitra.name} style={{ display: "block", contain: "layout" }}>
        <img alt={mitra.name} src={mitra.image} loading="lazy" decoding="async" style={mitraImgStyle} />
      </a>
    ) : (
      <div className="ui-duo-col" aria-label={mitra.name} style={{ contain: "layout" }}>
        <img alt={mitra.name} src={mitra.image} loading="lazy" decoding="async" style={mitraImgStyle} />
      </div>
    )
  ) : (
    <a className="ui-duo-col" href="https://dbmsda.bekasikota.go.id" target="_blank" rel="noopener noreferrer"><div className="ui-journal ui-journal-sport"><h2 className="ui-journal-title">JURNAL SUMBER DAYA AIR</h2><div className="ui-journal-media"><img alt="Jurnal Sumber Daya Air" src={asset("assets/journal-sport.png")} /></div><div className="ui-btn"><span className="fill-red"><span className="ui-btn-text">LIHAT JURNAL SDA</span><i>›</i></span></div></div></a>
  );

  return <section className="ui-journals ui-section fill-navy"><div className="ui-wrap"><div className="ui-duo">
    <a className="ui-duo-col" href="https://online.flippingbook.com/view/505000649/" target="_blank" rel="noopener noreferrer"><div className="ui-journal ui-journal-youth"><h2 className="ui-journal-title">JURNAL DBMSDA</h2><div className="ui-journal-media"><img alt="Jurnal Pemuda" src={asset("assets/journal-youth.png")} /></div><div className="ui-btn"><span className="fill-red"><span className="ui-btn-text">LIHAT JURNAL</span><i>›</i></span></div></div></a>
    {mitraCard}
  </div></div></section>;
}
