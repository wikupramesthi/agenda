type SectionHeadingProps = {
  /** Baris kecil di atas judul, kapital (mis. "Berita Terkini"). */
  overline?: string;
  /** Judul besar; bila `href` diisi, judul sekaligus menjadi tautan. */
  title: string;
  href?: string;
};

/** Judul section gaya beranda: label kecil + judul kapital 30px. */
export function SectionHeading({ overline, title, href }: SectionHeadingProps) {
  const className = 'font-bold text-3xl uppercase cursor-pointer hover:text-cust-blue transition-colors';
  return (
    <div className="flex flex-col">
      {overline ? <span className="uppercase tracking-wide text-gray-500">{overline}</span> : null}
      {href ? (
        <a href={href} target="_blank" rel="noopener noreferrer" className={className}>
          {title}
        </a>
      ) : (
        <h2 className={className}>{title}</h2>
      )}
    </div>
  );
}
