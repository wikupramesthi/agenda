import { ICONS } from '@/data/site';

type MetaLineProps = {
  /** Ikon kecil dari public/image (penulis atau tanggal). */
  icon: typeof ICONS.author | typeof ICONS.date;
  text: string;
  align?: 'left' | 'right';
};

/** Baris metadata kartu berita: ikon + teks kecil. */
export function MetaLine({ icon, text, align = 'left' }: MetaLineProps) {
  if (!text) return null;
  return (
    <div className={`flex gap-2 items-center text-sm text-gray-600 ${align === 'right' ? 'justify-end' : ''}`}>
      <img src={icon} alt="" className="w-4 h-4" />
      <span className="truncate">{text}</span>
    </div>
  );
}
