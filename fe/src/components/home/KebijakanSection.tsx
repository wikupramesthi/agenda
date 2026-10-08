import { Swiper, SwiperSlide } from 'swiper/react';
import { kebijakanExcerpt, kebijakanSlides } from '@/data/beranda-view';
import { carouselProps } from '@/lib/swiper';
import { PillLink } from '@/components/ui/PillLink';

import 'swiper/css';
import 'swiper/css/navigation';

/** Banner besar satu layar penuh: foto latar, overlay navy dari kiri, judul + CTA gold. */
export function KebijakanSection() {
  const slides = kebijakanSlides.map((s) => ({ ...s, excerpt: kebijakanExcerpt }));
  if (!slides.length) return null;

  return (
    <div className="w-full">
      <Swiper className="flat-swiper w-full h-full" {...carouselProps(7000)}>
          {slides.map((s) => (
            <SwiperSlide key={s.id}>
              <div
                className="relative flex justify-center items-center bg-cover bg-center lg:min-h-[689px] min-h-[420px] w-full"
                style={{ backgroundImage: `url(${s.image})` }}
              >
                <div className="absolute inset-0 bg-gradient-to-r from-cust-blue/90 via-cust-blue/55 to-cust-blue/10" />
                <div className="relative z-10 w-full px-6 lg:px-20 py-16 flex flex-col justify-center items-start gap-6 text-white">
                  <div className="w-full max-w-5xl flex flex-col gap-5 items-start">
                    <h2 className="w-full font-bold text-xl md:text-3xl lg:text-5xl leading-tight">{s.title}</h2>
                    <p className="text-base md:text-lg leading-relaxed text-white/90 max-w-2xl">{s.excerpt}</p>
                    <PillLink href={s.href} variant="gold">
                      Selengkapnya
                    </PillLink>
                  </div>
                </div>
              </div>
            </SwiperSlide>
        ))}
      </Swiper>
    </div>
  );
}
