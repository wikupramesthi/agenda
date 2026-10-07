import { PHOTO_DETAIL_PATH, gallery } from "../../data/siteData";

export function GalleryPage() {
  const doubled = [...gallery, ...gallery];
  return (
    <>
      <section className="ui-gallery-page ui-stories ui-section ui-section-top"><div className="ui-wrap"><div className="ui-sec-head"><h1 className="ui-sec-title ink-red">GALERI</h1></div><div className="ui-list"><div className="ui-list-row">{doubled.map((item, index) => { const href = index % gallery.length === 0 ? PHOTO_DETAIL_PATH : "/galeri"; return <div className="ui-list-col ui-list-badge ui-list-photo" key={`${item.title}-${index}`}><article className="ui-card ui-card-v fill-white ui-card-red"><div className="ui-card-media"><a href={href} tabIndex={-1} aria-hidden="true"><img alt="" src={item.image} loading="lazy" /></a></div><div className="ui-card-body"><div className="ui-card-meta"><div className="ui-tag ui-tag-red"><a href={href}>Foto</a></div><div className="ui-date ink-dark">September 2026</div></div><h2 className="ui-card-title"><a href={href}>{item.title}</a></h2><p>{item.text}</p></div></article></div>; })}</div></div></div></section>
    </>
  );
}
