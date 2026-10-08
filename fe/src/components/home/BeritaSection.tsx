import { useState } from 'react';
import { beritaTabNames, beritaTabs, official } from '@/data/beranda-view';
import { SectionHeading } from '@/components/ui/SectionHeading';
import { NewsCard } from '@/components/ui/NewsCard';

/**
 * Bagian "Berita Terkini": judul + pemilih kategori (tab aktif kuning, sisanya navy)
 * lalu grid kartu yang isinya berganti sesuai tab.
 */
export function BeritaSection() {
  const tabs = beritaTabNames;
  const [active, setActive] = useState(tabs[0] ?? '');

  if (!tabs.length) return null;

  return (
    <section className="flex flex-col gap-4 pt-0 px-5 p-10 lg:p-20 lg:py-0 mx-auto">
      <div className="flex flex-col lg:flex-row lg:justify-between gap-5 lg:items-center">
        <SectionHeading overline="Berita Terkini" title="Baca Berita Paling Terkini" href={`${official.site}/berita`} />

        <div className="flex items-center justify-center flex-wrap gap-3">
          {tabs.map((tab) => (
            <button
              key={tab}
              type="button"
              onClick={() => setActive(tab)}
              aria-pressed={active === tab}
              className={`rounded-xl px-4 py-2 cursor-pointer text-white transition-all duration-300 ${
                active === tab ? 'bg-cust-orange' : 'bg-cust-blue hover:brightness-125'
              }`}
            >
              {tab}
            </button>
          ))}
        </div>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
        {(beritaTabs[active] || []).map((item, i) => (
          <NewsCard key={`${item.href}-${i}`} item={item} />
        ))}
      </div>
    </section>
  );
}
