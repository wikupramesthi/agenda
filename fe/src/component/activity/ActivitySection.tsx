import { useApiData } from "../../app/useApiData";
import {
  fetchLatestArticles,
  splitHeadlines,
} from "../../data/articles";
import { NewsCard } from "../blog/BlogCard";
import { HeadlineCarousel } from "../blog/HeadlineCarousel";
import { DataError } from "../common/DataError";

export function ActivitySection() {
  // Data murni dari API (tanpa fallback statis).
  const { data: headlines, loading, failed, reload } = useApiData(
    () => fetchLatestArticles().then(splitHeadlines),
    [],
    "berita",
  );

  // Slider: 5 berita paling baru. Grid bawah: 3 berikutnya (tak duplikat).
  const sliderNews = headlines?.slider ?? [];
  const gridNews = headlines?.grid ?? [];

  if (sliderNews.length === 0) {
    return (
      <section className="ui-headlines ui-section" aria-label="Berita terbaru">
        <div className="ui-sec-head text-center"><h2 className="ui-sec-title">BERITA TERBARU</h2></div>
        {failed ? (
          <DataError onRetry={reload} />
        ) : (
          loading && <div className="ui-wrap" role="status"><p>Memuat berita terbaru…</p></div>
        )}
      </section>
    );
  }

  return (
    <>
      <section className="ui-headlines ui-section" aria-label="Berita terbaru">
        <div className="ui-sec-head text-center"><h2 className="ui-sec-title">BERITA TERBARU</h2></div>
        <HeadlineCarousel items={sliderNews} label="Berita terbaru" />
        <div className="ui-more-right"><div className="ui-btn ui-btn-rose"><a href="/berita"><span className="ui-btn-text">LIHAT BERITA LAINNYA</span><i aria-hidden="true">›</i></a></div></div>
      </section>
      <section className="ui-stories ui-section ui-news-grid" aria-label="Sorotan berita"><div className="ui-wrap"><div className="ui-grid-3"><div className="swiper-wrapper">{gridNews.map((item) => <div className="swiper-slide" key={item.title}><NewsCard item={item} /></div>)}</div></div></div></section>
    </>
  );
}
