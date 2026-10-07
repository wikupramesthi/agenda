import { asset } from "../../app/assets";

export function ServiceSection() {
  return (
    <section className="ui-service-sec ui-section">
      <div className="ui-wrap ui-wrap-narrow">
        <div className="ui-service">
          <div className="ui-service-copy">
            <h2 className="ui-service-title">LAYANAN</h2>
            <p>
              Memberikan pelayanan infrastruktur dan sumber daya air yang mudah
              diakses, cepat, transparan, dan profesional untuk mendukung
              kebutuhan masyarakat serta mewujudkan pembangunan Kota Bekasi yang
              berkelanjutan.
            </p>

            <div className="ui-btn">
              <a href="/layanan">
                <span className="ui-btn-text">LIHAT LAYANAN</span>
                <i>›</i>
              </a>
            </div>
          </div>
          <div className="ui-service-media">
            <img alt="pelayanan publik" src={asset("assets/service.png")} />
          </div>
        </div>
      </div>
    </section>
  );
}
