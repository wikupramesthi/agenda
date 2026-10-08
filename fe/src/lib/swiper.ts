/** Preset Swiper yang dipakai bersama oleh carousel beranda. */
import { A11y, Autoplay, Navigation, Pagination } from 'swiper/modules';

export const swiperModules = [Navigation, Pagination, Autoplay, A11y];

/** Autoplay per carousel (ms), mengikuti ritme pembacaan halaman asal. */
export const autoplayFor = (delay: number) => ({ delay, disableOnInteraction: false });

export const carouselProps = (delay: number) => ({
  modules: swiperModules,
  loop: true,
  speed: 700,
  navigation: true,
  autoplay: autoplayFor(delay),
});

export const heroCarouselProps = {
  ...carouselProps(6000),
  pagination: { clickable: true },
};
