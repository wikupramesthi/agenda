import { useApiData } from "../../app/useApiData";
import { fetchOfficials, officialDetailHref, type Official } from "../../data/officials";
import { DataError } from "../common/DataError";

function initials(name: string) {
  return name.split(" ").map((word) => word[0]).slice(0, 2).join("");
}

function OfficerCard({ uuid, name, role, image }: Official) {
  const href = officialDetailHref({ uuid });
  return (
    <a href={href} className="ui-officer-link" aria-label={`Lihat detail ${name}`}>
      <article className="ui-officer">
        <div className="ui-officer-photo">
          {image ? (
            <img alt={name} src={image} loading="lazy" onError={(e) => {
              const img = e.currentTarget as HTMLImageElement;
              img.style.display = "none";
              const ph = img.nextElementSibling as HTMLElement | null;
              if (ph) ph.style.display = "grid";
            }} />
          ) : null}
          <div className="officer-placeholder" aria-hidden="true" style={image ? { display: "none" } : undefined}><span>{initials(name)}</span></div>
        </div>
        <div className="ui-officer-info"><h3 className="ui-officer-name">{name}</h3><p className="officer-position">{role}</p></div>
      </article>
    </a>
  );
}

export function OfficialPage() {
  const { data, loading, failed, reload } = useApiData(fetchOfficials, [], "officials");

  if (loading) {
    return (
      <section className="ui-officers-page ui-section ui-section-top">
        <div className="ui-sec-head text-center"><h1 className="ui-sec-title ui-page-title">INFORMASI PEJABAT</h1></div>
        <div className="ui-wrap" role="status"><p style={{ textAlign: "center", color: "#6b6b8a" }}>Memuat data pejabat…</p></div>
      </section>
    );
  }

  if (failed) {
    return (
      <section className="ui-officers-page ui-section ui-section-top">
        <div className="ui-sec-head text-center"><h1 className="ui-sec-title ui-page-title">INFORMASI PEJABAT</h1></div>
        <div className="ui-wrap"><DataError onRetry={reload} /></div>
      </section>
    );
  }

  const officials = data ?? [];

  if (officials.length === 0) {
    return (
      <section className="ui-officers-page ui-section ui-section-top">
        <div className="ui-sec-head text-center"><h1 className="ui-sec-title ui-page-title">INFORMASI PEJABAT</h1></div>
        <div className="ui-wrap"><div className="empty-state" role="status"><h3>Belum ada data pejabat</h3><p>Data pejabat akan tampil di sini setelah admin menambahkannya.</p></div></div>
      </section>
    );
  }

  return (
    <section className="ui-officers-page ui-section ui-section-top">
      <div className="ui-sec-head text-center"><h1 className="ui-sec-title ui-page-title">INFORMASI PEJABAT</h1></div>
      <div className="ui-officers">
        <div className="ui-wrap">
          <div className="ui-officer-group">
            <h2 className="ui-officer-group-title">PEJABAT DBMSDA KOTA BEKASI</h2>
            <div className="ui-officer-row ui-officer-row-3">
              {officials.map((officer) => (
                <OfficerCard key={officer.uuid} {...officer} />
              ))}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
