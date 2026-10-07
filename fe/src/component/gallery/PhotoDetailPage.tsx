import { useState } from "react";
import { asset } from "../../app/assets";
import { useApiData } from "../../app/useApiData";
import { NEWS_CATEGORY_SLUG, fetchArticlesByCategory } from "../../data/articles";
import type { News } from "../../data/siteData";
import { NewsCard } from "../blog/BlogCard";
import { EventGatewayBanner } from "../common/EventGatewayBanner";
import { ShareButtons } from "../common/ShareButtons";
import { UpdatesGrid } from "../common/UpdatesGrid";
import { InspirationSection } from "../inspiration/InspirationSection";
import { GallerySection } from "./GallerySection";

const title = "Menpora Erick Dampingi Presiden Prabowo Lepas 432 Atlet Indonesia ke Asian Games 2026";
const photos = Array.from({ length: 7 }, (_, index) => asset(`assets/photo-detail/photo-${index + 1}.jpg`));

export function PhotoDetailPage() {
  const [active, setActive] = useState(0);
  const select = (index: number) => setActive(((index % photos.length) + photos.length) % photos.length);

  // Berita terkait dari API (tanpa data statis); gagal diam-diam.
  const { data } = useApiData<News[]>(
    () => fetchArticlesByCategory(NEWS_CATEGORY_SLUG, 3),
    [],
    "berita-terkait",
  );
  const relatedNews = data ?? [];

  return (
    <>
      <section className="photo-detail ui-section ui-section-top">
        <div className="ui-wrap photo-detail-shell">
          <header className="photo-detail-heading">
            <span className="photo-kicker">FOTO</span>
            <h1>{title}</h1>
            <time dateTime="2026-09-09">Rabu, 09 September 2026</time>
            <ShareButtons title={title} label="Bagikan halaman" />
          </header>

          <div className="photo-viewer">
            <div className="photo-stage" aria-live="polite">
              <img alt={`${title}, foto ${active + 1} dari ${photos.length}`} src={photos[active]} />
              <button className="photo-arrow photo-arrow-prev" aria-label="Foto sebelumnya" onClick={() => select(active - 1)} type="button">‹</button>
              <button className="photo-arrow photo-arrow-next" aria-label="Foto berikutnya" onClick={() => select(active + 1)} type="button">›</button>
            </div>
            <div className="photo-thumbs" role="tablist" aria-label="Daftar foto">
              {photos.map((photo, index) => <button role="tab" aria-selected={active === index} aria-label={`Tampilkan foto ${index + 1}`} aria-current={active === index} className={active === index ? "is-active" : ""} key={photo} onClick={() => select(index)} type="button"><img alt="" src={photo} loading="lazy" /></button>)}
            </div>
          </div>

          <div className="photo-copy">
            <p>DBMSDA Kota Bekasi melaksanakan kegiatan infrastruktur dan pengelolaan sumber daya air sebagai bagian dari komitmen pembangunan Kota Bekasi yang berkelanjutan. Dokumentasi kegiatan ini menampilkan progres lapangan dan kolaborasi lintas bidang.</p>
            <p>Foto : DBMSDA Kota Bekasi</p>
            <a className="photo-news-link" href="/berita">BERITA SELENGKAPNYA</a>
          </div>
        </div>
      </section>

      {relatedNews.length > 0 && (
      <section className="related-news ui-stories ui-section">
        <div className="ui-wrap">
          <div className="ui-sec-head"><h2 className="ui-sec-title">BERITA</h2><div className="ui-sec-more"><div className="ui-btn"><a className="fill-red" href="/berita"><span className="ui-btn-text">LIHAT BERITA LAINNYA</span><i aria-hidden="true">›</i></a></div></div></div>
          <div className="ui-grid-3"><div className="swiper-wrapper">{relatedNews.map((item) => <div className="swiper-slide" key={item.title}><NewsCard item={item} /></div>)}</div></div>
        </div>
      </section>
      )}
      <InspirationSection />
      <GallerySection />
      <UpdatesGrid />
      <EventGatewayBanner className="event-gateway ui-wrap detail-event-gateway" />
    </>
  );
}
