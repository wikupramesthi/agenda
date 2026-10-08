import { agendaItems } from '@/data/beranda-view';
import { MonthCalendar } from '@/components/ui/MonthCalendar';
import { AgendaPanel } from './AgendaPanel';
import { ArticleFeed } from './ArticleFeed';
import { InstagramFeed } from './InstagramFeed';

/**
 * Bagian berlatar gradasi putih ke kuning: dua kolom kiri untuk unggahan media
 * sosial, satu kolom kanan berisi kalender, agenda, dan daftar artikel.
 */
export function MediaSocialSection() {
  return (
    <section className="bg-gradient-to-b from-white to-gold px-5 p-10 lg:p-20 mx-auto">
      <div className="max-w-[1400px] mx-auto grid grid-cols-1 lg:grid-cols-3 gap-6">
        <InstagramFeed />
        <div className="lg:col-span-1 flex flex-col gap-6">
          <MonthCalendar agenda={agendaItems} />
          <AgendaPanel />
          <ArticleFeed />
        </div>
      </div>
    </section>
  );
}
