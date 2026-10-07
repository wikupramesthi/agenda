import { useEffect } from "react";

const SCRIPT_SRC = "https://rahadiana.github.io/gpr_widget_kominfo/gpr-widget-kominfo.min.js";
const CONTAINER_ID = "gpr-kominfo-widget-container";

// Widget GPR Kominfo — script eksternal akan merender ke #gpr-kominfo-widget-container
// Dibuat sebagai komponen agar tidak block render & tetap CSP-friendly (script di-load sekali).
export function KominfoWidget() {
  useEffect(() => {
    if (document.getElementById(CONTAINER_ID) == null) return;
    if (document.querySelector(`script[src="${SCRIPT_SRC}"]`)) return;
    const s = document.createElement("script");
    s.type = "text/javascript";
    s.src = SCRIPT_SRC;
    s.async = true;
    document.body.appendChild(s);
    return () => {
      // biarkan script tetap terpasang agar tidak re-download saat navigasi SPA
    };
  }, []);

  return (
    <div className="kominfo-widget-wrap ui-wrap" aria-label="Widget GPR Kominfo">
      <div id={CONTAINER_ID} />
    </div>
  );
}
