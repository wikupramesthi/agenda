import { asset } from "../../app/assets";

export function CategorySection() {
  return <section className="ui-section"><div className="ui-wrap"><div className="ui-duo">
    <div className="ui-duo-col"><a className="ui-tile ui-tile-red" href="/halaman/visi-misi-kota-bekasi"><div className="ui-tile-copy"><h2 className="ui-tile-title">WALI DAN WAKIL WALI KOTA BEKASI</h2><p>Bersama Membangun Kota Bekasi yang Nyaman, Sejahtera, dan Memberikan Pelayanan Terbaik bagi Masyarakat.</p></div><div className="ui-tile-media"><img alt="walikota bekasi" src={asset("assets/wali-wakil.png")} /></div><div className="ui-btn ui-btn-light"><span><span className="ui-btn-text">LIHAT VISI MISI</span><i>›</i></span></div></a></div>
    <div className="ui-duo-col"><a className="ui-tile ui-tile-blue" href="/visi-misi"><div className="ui-tile-copy"><h2 className="ui-tile-title">KEPALA DINAS BMSDA KOTA BEKASI</h2><p>Menghadirkan infrastruktur yang terhubung dan pengelolaan sumber daya air yang berkelanjutan.</p></div><div className="ui-tile-media"><img alt="kepala dbmsda" src={asset("assets/kadis.png")} /></div><div className="ui-btn ui-btn-light"><span><span className="ui-btn-text">LIHAT PROFIL</span><i>›</i></span></div></a></div>
  </div></div></section>;
}
