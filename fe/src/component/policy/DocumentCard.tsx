import { asset } from "../../app/assets";
import type { PublicDocument } from "../../data/documents";

// Fallback bila dokumen tidak punya thumbnail: pakai logo agar kartu
// tetap rapi (bukan gambar acak selang-seling).
export const DOCUMENT_FALLBACK_IMAGE = asset("assets/logo.png");

// Kartu dokumen: TIDAK langsung mengunduh. Pratinjau dibuka di tab baru
// (`target="_blank"`, dibiarkan ke browser oleh intersepsi klik SPA),
// unduh hanya lewat tombol UNDUH yang eksplisit.
export function DocumentCard({ item, titleTag = "h2" }: { item: PublicDocument; titleTag?: "h2" | "h3" }) {
  const media = item.thumbnail ?? DOCUMENT_FALLBACK_IMAGE;
  // Data backend umumnya mengisi excerpt sama persis dengan judul —
  // jangan tampilkan dua kali agar kartu tidak redundan.
  const excerpt = item.excerpt.trim();
  const showExcerpt =
    excerpt.length > 0 &&
    excerpt.toLocaleLowerCase("id-ID") !== item.title.trim().toLocaleLowerCase("id-ID");
  return (
    <div className="ui-doc-col">
      <article className={item.file ? "ui-doc ui-doc-filed" : "ui-doc"}>
        <div className="ui-doc-media">
          <img alt="" src={media} loading="lazy" />
        </div>
        <div className="ui-doc-body">
          <div className="ui-doc-meta">
            {item.category && (
              <span className="ui-doc-tag" title={item.category}>
                {item.category}
              </span>
            )}
            {item.date && <div className="ui-doc-date">{item.date}</div>}
          </div>
          {titleTag === "h3" ? (
            <h3 className="ui-doc-title">{item.title}</h3>
          ) : (
            <h2 className="ui-doc-title">{item.title}</h2>
          )}
          {showExcerpt && <p className="ui-doc-excerpt">{item.excerpt}</p>}
        </div>
        {item.file && (
          <div className="ui-doc-actions">
            <a
              className="ui-doc-btn ui-doc-btn-view"
              href={item.file}
              target="_blank"
              rel="noopener noreferrer"
              aria-label={`Lihat ${item.title} di tab baru`}
            >
              LIHAT FILE
            </a>
            <a
              className="ui-doc-btn ui-doc-btn-dl"
              href={item.file}
              download
              aria-label={`Unduh ${item.title}`}
            >
              UNDUH
            </a>
          </div>
        )}
      </article>
    </div>
  );
}
