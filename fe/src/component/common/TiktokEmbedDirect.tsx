import { useEffect, useRef } from "react";

const TIKTOK_SRC = "https://www.tiktok.com/embed.js";

export function TiktokEmbedDirect() {
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const wrap = ref.current;
    if (!wrap) return;
    // Bersihkan hanya blockquote lama, biarkan fallback card tetap di bawah (tidak dobel @)
    const old = wrap.querySelector("blockquote.tiktok-embed");
    if (old) old.remove();
    const bq = document.createElement("blockquote");
    bq.className = "tiktok-embed";
    bq.setAttribute("cite", "https://www.tiktok.com/@dbmsdakotabekasi");
    bq.setAttribute("data-unique-id", "dbmsdakotabekasi");
    bq.setAttribute("data-embed-from", "embed_page");
    bq.setAttribute("data-embed-type", "creator");
    bq.setAttribute("style", "max-width:780px; min-width:288px; display:none;");
    const sec = document.createElement("section");
    const a = document.createElement("a");
    a.target = "_blank";
    a.rel = "noopener noreferrer";
    a.href = "https://www.tiktok.com/@dbmsdakotabekasi?refer=creator_embed";
    a.textContent = "@dbmsdakotabekasi";
    sec.appendChild(a);
    bq.appendChild(sec);
    wrap.prepend(bq);

    let script = document.querySelector<HTMLScriptElement>(`script[src="${TIKTOK_SRC}"]`);
    if (!script) {
      script = document.createElement("script");
      script.async = true;
      script.src = TIKTOK_SRC;
      bq.insertAdjacentElement("afterend", script);
    } else if (!bq.nextElementSibling?.matches(`script[src="${TIKTOK_SRC}"]`)) {
      const clone = document.createElement("script");
      clone.async = true;
      clone.src = TIKTOK_SRC;
      bq.insertAdjacentElement("afterend", clone);
    }
  }, []);

  // Selalu tampilkan kartu rapi (tidak dobel @ di atas ikon), embed hidden di atas untuk diisi iframe jika berhasil
  return (
    <div className="tiktok-embed-direct" ref={ref}>
      <div className="tiktok-fallback" role="status">
        <div className="tiktok-fallback-icon" aria-hidden="true">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
            <path d="M12.525.02c1.31-.02 2.61-.01 3.91-.02.08 1.53.63 3.09 1.75 4.17 1.12 1.11 2.7 1.62 4.24 1.79v4.03c-1.44-.05-2.89-.35-4.2-.97-.57-.26-1.1-.59-1.62-.93-.01 2.92.01 5.84-.02 8.75-.08 1.4-.54 2.79-1.35 3.94-1.31 1.92-3.58 3.17-5.91 3.21-1.43.08-2.86-.31-4.08-1.03-2.02-1.19-3.44-3.37-3.65-5.71-.02-.5-.03-1-.01-1.49.18-1.9 1.12-3.72 2.58-4.96 1.66-1.44 3.98-2.13 6.15-1.72.02 1.48-.04 2.96-.04 4.44-.99-.32-2.15-.23-3.02.37-.63.41-1.11 1.04-1.36 1.75-.21.51-.15 1.07-.14 1.61.24 1.64 1.82 3.02 3.5 2.87 1.12-.01 2.19-.66 2.77-1.61.19-.33.4-.67.41-1.06.1-1.79.06-3.57.07-5.36.01-4.03-.01-8.05.02-12.07z" />
          </svg>
        </div>
        <strong>@dbmsdakotabekasi</strong>
        <p>TikTok DBMSDA Kota Bekasi</p>
        <a href="https://www.tiktok.com/@dbmsdakotabekasi" target="_blank" rel="noopener noreferrer" className="tiktok-fallback-btn">
          BUKA DI TIKTOK
        </a>
      </div>
    </div>
  );
}
