import { PHOTO_DETAIL_PATH, gallery } from "../../data/siteData";
import { SectionHeading } from "../common/SectionHeading";

export function GallerySection() {
  return <section className="ui-gallery-sec ui-section"><div className="ui-wrap"><SectionHeading title="GALERI" actionLabel="LIHAT GALERI LAINNYA" actionHref="/galeri" actionClassName="bg-blue2" /><div className="ui-grid-2"><div className="swiper-wrapper">{gallery.map((item, index) => { const href = index === 0 ? PHOTO_DETAIL_PATH : "/galeri"; return <div className="swiper-slide" key={item.title}><article className="ui-card ui-card-h ui-card-red"><div className="ui-card-media"><a href={href} tabIndex={-1} aria-hidden="true"><img alt="" src={item.image} loading="lazy" /></a></div><div className="ui-card-body"><div className="ui-card-meta"><div className="ui-tag ui-tag-red"><a href={href}>Foto</a></div><div className="ui-date ink-dark">Rabu, 09 September 2026</div></div><h3 className="ui-card-title"><a href={href}>{item.title}</a></h3><p>{item.text}</p></div></article></div>; })}</div></div></div></section>;
}
