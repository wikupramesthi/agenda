import { ActivitySection } from "../activity/ActivitySection";
import { BannerSection } from "../banner/BannerSection";
import { BannerSlider } from "../banner/BannerSlider";
import { CategorySection } from "../category/CategorySection";
import { UpdatesGrid } from "../common/UpdatesGrid";
import { InspirationSection } from "../inspiration/InspirationSection";
import { JournalSection } from "../journal/JournalSection";
import { KegiatanSection } from "../kegiatan/KegiatanSection";
import { LatestDocumentsSection } from "../policy/LatestDocumentsSection";
import { ServiceSection } from "../service/ServiceSection";

export function HomePage() {
  return (
    <div className="home-stack">
      <BannerSection />
      <ActivitySection />
      <section className="ui-section" aria-label="Banner DBMSDA"><div className="ui-wrap"><BannerSlider posisi="slider" limit={5} /></div></section>
      <CategorySection />
      <ServiceSection />
      <LatestDocumentsSection />
      <JournalSection />
      <KegiatanSection />
      <InspirationSection />
      <UpdatesGrid />
    </div>
  );
}
