import { useApiData } from "../../app/useApiData";
import { fetchArticlesByCategory, newsDetailHref } from "../../data/articles";

const PEMELIHARAAN_SLUG = "pemeliharaan";

export function InspirationSection() {
  const { data } = useApiData(() => fetchArticlesByCategory(PEMELIHARAAN_SLUG, 3), [], "inspirasi-pemeliharaan");
  const items = (data ?? []).slice(0, 3);

  // Fallback tetap tampilkan seksi (kop tetap), isi kosong → placeholder ringan.
  if (items.length === 0) {
    return (
      <section className="ui-stories ui-section" aria-label="Pemeliharaan">
        <div className="ui-wrap">
          <div className="ui-sec-head"><h2 className="ui-sec-title">PEMELIHARAAN</h2></div>
          <p style={{ color: "#6b6b8a", fontSize: 14 }}>Belum ada berita pemeliharaan.</p>
        </div>
      </section>
    );
  }

  return (
    <section className="ui-stories ui-section" aria-label="Pemeliharaan">
      <div className="ui-wrap">
        <div className="ui-sec-head"><h2 className="ui-sec-title">PEMELIHARAAN</h2></div>
        <div className="ui-grid-3">
          <div className="swiper-wrapper">
            {items.map((item) => {
              const href = newsDetailHref(item);
              return (
                <div className="swiper-slide" key={item.slug ?? item.title}>
                  <article className="ui-card ui-card-v fill-white ui-card-blue">
                    <div className="ui-card-media">
                      <a href={href} tabIndex={-1} aria-hidden="true">
                        <img alt="" src={item.image} loading="lazy" />
                      </a>
                    </div>
                    <div className="ui-card-body">
                      <div className="ui-card-meta">
                        <div className="ui-tag ui-tag-blue">
                          <a href="/berita">Pemeliharaan</a>
                        </div>
                        <div className="ui-date ink-dark">{item.date}</div>
                      </div>
                      <h3 className="ui-card-title"><a href={href}>{item.title}</a></h3>
                      <p>{item.excerpt || "Informasi pemeliharaan infrastruktur DBMSDA Kota Bekasi."}</p>
                    </div>
                  </article>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </section>
  );
}
