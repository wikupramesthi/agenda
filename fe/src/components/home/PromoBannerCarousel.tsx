import { Swiper, SwiperSlide } from 'swiper/react';
import { bannerSlides } from '@/data/beranda-view';
import { carouselProps } from '@/lib/swiper';

import 'swiper/css';
import 'swiper/css/navigation';

/** Deretan banner promosi penuh-lebar di bagian bawah beranda. */
export function PromoBannerCarousel() {
  if (!bannerSlides.length) return null;

  return (
    <div className="w-full section3">
      <Swiper className="banner-swiper w-full" {...carouselProps(5000)}>
        {bannerSlides.map((banner) => (
          <SwiperSlide key={banner.href + banner.name}>
            <a
              href={banner.href}
              target="_blank"
              rel="noopener noreferrer"
              aria-label={banner.name}
              className="block bg-cover bg-center lg:min-h-[640px] min-h-[260px] w-full"
              style={{ backgroundImage: `url(${banner.image})` }}
            >
              <span className="sr-only">{banner.name}</span>
            </a>
          </SwiperSlide>
        ))}
      </Swiper>
    </div>
  );
}
