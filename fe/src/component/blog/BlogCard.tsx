import { newsDetailHref } from "../../data/articles";
import { News } from "../../data/siteData";

type Props = { item: News; horizontal?: boolean };

// Kartu berita generik mengikuti sistem class `ui-card` di tema.
// Nama file historis `BlogCard` dipertahankan agar impor lama tetap jalan;
// gunakan `NewsCard` untuk kode baru.
export function NewsCard({ item, horizontal = false }: Props) {
  const href = newsDetailHref(item);
  return (
    <article className={`ui-card ${horizontal ? "ui-card-h" : "ui-card-v"} fill-white ui-card-red`}>
      <div className="ui-card-media"><a href={href} tabIndex={-1} aria-hidden="true"><img alt="" src={item.image} loading="lazy" /></a></div>
      <div className="ui-card-body"><div className="ui-card-meta"><div className="ui-tag ui-tag-red"><a href="/berita">{item.category ?? "Berita"}</a></div><div className="ui-date ink-dark">{item.date}</div></div><h3 className="ui-card-title"><a href={href}>{item.title}</a></h3>{item.excerpt ? <p>{item.excerpt}</p> : null}</div>
    </article>
  );
}

export const BlogCard = NewsCard;
