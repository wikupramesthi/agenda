import { ICONS } from '@/data/site';
import type { NewsCardView } from '@/types/view';
import { ICON_PATH, Icon } from './Icon';
import { MetaLine } from './MetaLine';

/** Kartu berita: gambar, penulis, judul (2 baris, penuh saat hover), tanggal + CTA. */
export function NewsCard({ item }: { item: NewsCardView }) {
  return (
    <a
      href={item.href}
      target="_blank"
      rel="noopener noreferrer"
      className="group flex flex-col justify-between min-h-[300px] md:min-h-[418px] bg-white shadow-card rounded-xl p-4 gap-3"
    >
      <div className="flex flex-col gap-5 w-full">
        <img
          src={item.image}
          alt={item.title}
          loading="lazy"
          className="object-cover rounded-lg w-full h-[180px] md:h-[205px] bg-cust-gray"
        />
        <MetaLine icon={ICONS.author} text={`Oleh ${item.author}`} />
        <h3 className="text-lg font-semibold leading-tight line-clamp-2 group-hover:line-clamp-4">{item.title}</h3>
      </div>

      <div className="flex items-center justify-between gap-2">
        <MetaLine icon={ICONS.date} text={item.date} />
        <span className="text-cust-blue font-medium text-sm flex items-center gap-1 group-hover:gap-2 transition-all shrink-0">
          Selengkapnya
          <Icon d={ICON_PATH.arrowRight} className="w-4 h-4" strokeWidth={2} />
        </span>
      </div>
    </a>
  );
}
