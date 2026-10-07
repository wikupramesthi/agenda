import { asset } from "../../app/assets";
import type { DocumentPageContent } from "../../data/siteData";

export function PolicyPage({ content }: { content: DocumentPageContent }) {
  return (
    <>
      <section className="ui-report-page ui-section ui-section-top"><div className="ui-wrap"><div className="ui-sec-head"><h1 className="ui-sec-title ink-blue">{content.title}</h1></div><div className="ui-doc-list"><div className="ui-doc-row">{content.documents.map((title, index) => <div className="ui-doc-col" key={title}><article className="ui-doc"><div className="ui-doc-media"><img alt="" src={index % 2 ? asset("assets/journal-sport.png") : asset("assets/journal-youth.png")} loading="lazy" /></div><div className="ui-doc-body"><div className="ui-doc-dl"><span aria-hidden="true">↓</span></div><div className="ui-doc-date">Dokumen DBMSDA · 2026</div><h2 className="ui-doc-title">{title}</h2></div></article></div>)}</div></div></div></section>
    </>
  );
}
