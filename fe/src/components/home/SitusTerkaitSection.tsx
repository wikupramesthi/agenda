import { official, situsTerkait } from '@/data/beranda-view';
import { PillLink } from '@/components/ui/PillLink';

/** Baris logo mitra institucional + tombol "Lihat Lainnya". */
export function SitusTerkaitSection() {
  if (!situsTerkait.length) return null;

  return (
    <div className="flex flex-col w-full justify-center items-center gap-7 px-5 md:px-10 lg:px-20 py-5">
      <h2 className="font-bold text-3xl">Situs Terkait</h2>

      <div className="flex flex-wrap items-center justify-center gap-x-14 gap-y-8 md:gap-y-10 w-full">
        {situsTerkait.map((site) => (
          <a
            key={site.href + site.name}
            href={site.href}
            target="_blank"
            rel="noopener noreferrer"
            title={site.name}
            className="flex items-center justify-center h-16 md:h-20 grayscale-[35%] hover:grayscale-0 hover:scale-105 transition-all duration-300"
          >
            <img src={site.image} alt={site.name} loading="lazy" className="max-h-16 md:max-h-20 w-auto object-contain" />
          </a>
        ))}
      </div>

      <PillLink href={official.site} variant="navy-lg">
        Lihat Lainnya
      </PillLink>
    </div>
  );
}
