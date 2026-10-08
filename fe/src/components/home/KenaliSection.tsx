import { kenali } from '@/data/beranda-view';
import { PillLink } from '@/components/ui/PillLink';

/** Kartu putih rounded-xl: teks di kiri (judul KoHo kapital), gambar logo di kanan. */
export function KenaliSection() {
  return (
    <div className="px-5 p-10 lg:p-20 lg:py-10 pb-24 lg:pb-20">
      <div className="flex flex-col lg:flex-row justify-center lg:justify-between items-stretch overflow-hidden rounded-xl bg-white shadow-card min-h-[320px]">
        <div className="order-2 lg:order-1 flex-1 lg:max-w-[42%] p-8 md:p-12 flex flex-col gap-4 justify-center items-start">
          <h2 className="font-koho text-4xl md:text-5xl font-semibold uppercase text-ink leading-tight">{kenali.title}</h2>
          <p className="text-base text-gray-700 leading-relaxed max-w-md">{kenali.excerpt}</p>
          <PillLink href={kenali.href} variant="gold-sm">
            Lihat Lainnya
          </PillLink>
        </div>
        <div className="order-1 lg:order-2 flex-1 min-h-[220px] md:min-h-[320px] bg-cust-silver flex items-center justify-center">
          <img src={kenali.image} alt={`${kenali.title} — logo Kementerian UMKM`} className="h-full w-full object-contain p-6" />
        </div>
      </div>
    </div>
  );
}
