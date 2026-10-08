import { AppFooter } from '@/components/layout/AppFooter';
import { AppHeader } from '@/components/layout/AppHeader';
import { UnofficialNotice } from '@/components/layout/UnofficialNotice';
import { BeritaSection } from '@/components/home/BeritaSection';
import { HeroSection } from '@/components/home/HeroSection';
import { KebijakanSection } from '@/components/home/KebijakanSection';
import { KenaliSection } from '@/components/home/KenaliSection';
import { MediaSocialSection } from '@/components/home/MediaSocialSection';
import { PromoBannerCarousel } from '@/components/home/PromoBannerCarousel';
import { SitusTerkaitSection } from '@/components/home/SitusTerkaitSection';

/**
 * Susunan layar beranda — urutannya sama dengan halaman asal:
 * hero + news flash, kenali, berita terkini, arah kebijakan, situs terkait,
 * media sosial/kalender/artikel, banner promosi, lalu footer.
 */
export function App() {
  return (
    <div className="min-h-screen font-ubuntu text-cust-black bg-white">
      <AppHeader />
      <main className="min-h-screen">
        <HeroSection />
        <KenaliSection />
        <BeritaSection />
        <KebijakanSection />
        <SitusTerkaitSection />
        <MediaSocialSection />
        <PromoBannerCarousel />
      </main>
      <AppFooter />
      <UnofficialNotice />
    </div>
  );
}
