import { asset } from "../../app/assets";
import { useWebsiteIdentity } from "../../app/WebsiteIdentityContext";

const columnOne: [string, string][] = [["Beranda", "/"], ["Visi Misi", "/visi-misi"], ["Informasi Pejabat", "/informasi-pejabat"], ["Dokumen", "/dokumen"]];
const columnTwo: [string, string][] = [["Berita", "/berita"], ["Pengumuman", "/pengumuman"], ["Galeri", "/galeri"], ["Layanan", "/layanan"]];

function SocialIcon({ kind }: { kind: "instagram" | "tiktok" | "facebook" }) {
  const common = { width: 18, height: 18, viewBox: "0 0 24 24", fill: "none", "aria-hidden": true } as const;
  if (kind === "instagram") {
    return (
      <svg {...common} stroke="currentColor" strokeWidth={1.8} strokeLinecap="round" strokeLinejoin="round">
        <rect x={3} y={3} width={18} height={18} rx={5} />
        <circle cx={12} cy={12} r={3.5} />
        <circle cx={17.5} cy={6.5} r={1} fill="currentColor" stroke="none" />
      </svg>
    );
  }
  if (kind === "facebook") {
    return (
      <svg width={18} height={18} viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
        <path d="M14 8h3V4h-3c-2.76 0-5 2.24-5 5v3H6v4h3v5h4v-5h3l1-4h-4V9c0-.55.45-1 1-1z" />
      </svg>
    );
  }
  // tiktok only
  return (
    <svg width={18} height={18} viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
      <path d="M12.525.02c1.31-.02 2.61-.01 3.91-.02.08 1.53.63 3.09 1.75 4.17 1.12 1.11 2.7 1.62 4.24 1.79v4.03c-1.44-.05-2.89-.35-4.2-.97-.57-.26-1.1-.59-1.62-.93-.01 2.92.01 5.84-.02 8.75-.08 1.4-.54 2.79-1.35 3.94-1.31 1.92-3.58 3.17-5.91 3.21-1.43.08-2.86-.31-4.08-1.03-2.02-1.19-3.44-3.37-3.65-5.71-.02-.5-.03-1-.01-1.49.18-1.9 1.12-3.72 2.58-4.96 1.66-1.44 3.98-2.13 6.15-1.72.02 1.48-.04 2.96-.04 4.44-.99-.32-2.15-.23-3.02.37-.63.41-1.11 1.04-1.36 1.75-.21.51-.15 1.07-.14 1.61.24 1.64 1.82 3.02 3.5 2.87 1.12-.01 2.19-.66 2.77-1.61.19-.33.4-.67.41-1.06.1-1.79.06-3.57.07-5.36.01-4.03-.01-8.05.02-12.07z" />
    </svg>
  );
}

export function Footer() {
  const { identity } = useWebsiteIdentity();
  const logoSrc = identity?.logo_url || asset("assets/logo.png");
  const logoAlt = identity?.site_name ? `logo ${identity.site_name}` : "logo DBMSDA";
  const address = identity?.address || "Jl. Gerbang Pemuda No.3 Senayan\nKel. Gelora, Kec. Tanah Abang,\nJakarta Pusat 10270";
  const phone = identity?.phone || "112";
  const email = identity?.email || "dbmsdakotabekasi2018@gmail.com";

  const socials: Array<{ label: string; href: string; kind: "instagram" | "tiktok" | "facebook" }> = [];
  if (identity?.facebook_url?.trim()) {
    socials.push({ label: "Facebook", href: identity.facebook_url, kind: "facebook" });
  }
  socials.push({
    label: "Instagram",
    href: identity?.instagram_url || "https://www.instagram.com/dbmsdakotabekasi/",
    kind: "instagram",
  });
  socials.push({
    label: "TikTok",
    href: identity?.tiktok_url || "https://www.tiktok.com/@dbmsdakotabekasi",
    kind: "tiktok",
  });

  return (
    <footer>
      <div className="ui-wrap"><div className="ui-footer">
        <div className="ui-footer-col ui-footer-brand"><div className="ui-footer-logo"><img
          alt={logoAlt}
          src={logoSrc}
          loading="lazy"
          onError={(e) => {
            const img = e.currentTarget as HTMLImageElement;
            if (img.src !== asset("assets/logo.png")) img.src = asset("assets/logo.png");
          }}
        /></div><div className="ui-footer-addr"><p style={{ whiteSpace: "pre-line" }}>{address}</p><p>Call Center : {phone}<br />Email : {email}</p></div><div className="ui-socials"><ul>{socials.map((s) => (
          <li key={s.href}><a aria-label={s.label} href={s.href} target="_blank" rel="noopener noreferrer" className="social-icon"><SocialIcon kind={s.kind} /></a></li>
        ))}</ul></div></div>
        <nav className="ui-footer-col" aria-label="Halaman utama"><h2 className="ui-footer-head">Halaman</h2><ul className="ui-footer-nav">{columnOne.map(([label, href]) => <li key={href}><a href={href}>{label}</a></li>)}</ul></nav>
        <nav className="ui-footer-col" aria-label="Halaman layanan"><h2 className="ui-footer-head" aria-hidden="true">&nbsp;</h2><ul className="ui-footer-nav">{columnTwo.map(([label, href]) => <li key={href}><a href={href}>{label}</a></li>)}</ul></nav>
      </div></div>
      <div className="ui-footer-art" aria-hidden="true"><img alt="" src={asset("assets/footer-bg.png")} loading="lazy" /></div>
    </footer>
  );
}
