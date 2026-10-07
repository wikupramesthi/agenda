import { asset } from "../../app/assets";
import { AgendaCountdown } from "../counter/AgendaCountdown";

export function BannerSection() {
  return (
    <>
      <section className="ui-hero ui-section">
        <div className="ui-hero-bg"><img alt="" src={asset("assets/hero-bg.png")} /></div>
        <div className="ui-wrap"><div className="ui-hero-inner">
          <div className="ui-hero-media"><img alt="Infrastruktur DBMSDA Kota Bekasi" src={asset("assets/hero-person.png")} /></div>
          <div className="ui-hero-copy"><h1 className="ui-hero-title">MEMBANGUN INFRASTRUKTUR, MENJAGA KENYAMANAN KOTA</h1><p>Di balik setiap jalan yang menghubungkan, jembatan yang melintas, drainase yang mengalir, taman yang menghijau, dan ruang kota yang terpelihara, ada kerja nyata untuk Kota Bekasi.</p><p>Dinas Bina Marga dan Sumber Daya Air Kota Bekasi melaksanakan pembangunan dan pemeliharaan jalan dan jembatan, pengelolaan drainase, penanggulangan banjir, pembangunan dan pemeliharaan taman kota, pemeliharaan Ruang Milik Jalan (Rumija), serta pembinaan jasa konstruksi.</p><p>Terus bergerak, terus membangun, untuk Kota Bekasi yang semakin keren.</p><div className="ui-btn"><a href="/visi-misi"><span className="ui-btn-text">PROFIL KAMI</span><i>›</i></a></div></div>
        </div></div>
      </section>
      <AgendaCountdown />
    </>
  );
}
