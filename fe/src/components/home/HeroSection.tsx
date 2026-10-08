import { Swiper, SwiperSlide } from 'swiper/react';
import { heroSlides, newsFlash } from '@/data/beranda-view';
import { heroCarouselProps } from '@/lib/swiper';
import { PillTag } from '@/components/ui/PillLink';
import { NewsFlashBar } from './NewsFlashBar';

import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';

/** Layar pertama: slideshow setinggi viewport dengan bar News Flash di bawahnya. */
export function HeroSection() {
  return (
    <div className="relative flex flex-col w-full h-screen">
      <div className="relative flex-1 min-h-0">
        <Swiper className="hero-swiper w-full h-full" {...heroCarouselProps}>
          {heroSlides.map((slide) => (
            <SwiperSlide key={slide.id}>
              <div className="relative flex flex-col justify-end h-full w-full">
                <img src={slide.image} alt={slide.title} className="absolute inset-0 w-full h-full object-cover" />
                <div className="absolute inset-0 bg-gradient-to-t from-cust-blue/90 via-cust-blue/45 to-cust-blue/15" />

                <div className="relative z-10 flex flex-col justify-center items-center md:items-stretch flex-shrink-0 px-5 lg:px-20 pt-20 pb-12 text-white gap-10">
                  <div className="max-w-[1400px] w-full mx-auto">
                    <a href={slide.href} target="_blank" rel="noopener noreferrer" className="group block">
                      <h2 className="text-2xl md:text-3xl lg:text-5xl max-w-5xl font-bold text-center md:text-left leading-snug line-clamp-2 group-hover:line-clamp-4">
                        {slide.title}
                      </h2>
                      <PillTag variant="outline-light" className="mt-10">
                        Selengkapnya
                      </PillTag>
                    </a>
                  </div>
                </div>
              </div>
            </SwiperSlide>
          ))}
        </Swiper>
      </div>
      <NewsFlashBar items={newsFlash} />
    </div>
  );
}
