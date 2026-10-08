import { kenali, socialImages, socialLinks } from '@/data/beranda-view';
import { INSTAGRAM } from '@/data/site';

/**
 * Pengganti widget feed pihak ketiga: judul, chip akun, tagar, dan grid foto.
 * Semua tautan langsung menuju akun resminya.
 */
export function InstagramFeed() {
  return (
    <div className="lg:col-span-2 flex flex-col gap-5">
      <h2 className="text-xl md:text-2xl font-bold">
        Media Sosial <span className="text-cust-orange">Kementerian UMKM</span>
      </h2>

      <div className="flex flex-wrap items-center gap-3">
        <a
          href={socialLinks.profile}
          target="_blank"
          rel="noopener noreferrer"
          className="flex items-center gap-3 bg-white rounded-full shadow-sm pl-2 pr-4 py-2 hover:shadow transition-shadow"
        >
          <img src={kenali.image} alt={socialLinks.handle} className="w-9 h-9 rounded-full object-cover bg-cust-gray" />
          <span className="font-semibold text-cust-blue text-sm">{socialLinks.handle}</span>
        </a>

        <div className="flex flex-wrap gap-2">
          {socialLinks.tags.map((tag) => (
            <a
              key={tag}
              href={`${INSTAGRAM.tagBase}${tag.toLowerCase()}/`}
              target="_blank"
              rel="noopener noreferrer"
              className="text-xs font-semibold px-3 py-1.5 rounded-full bg-cust-blue text-white hover:brightness-125 transition-all"
            >
              #{tag}
            </a>
          ))}
        </div>
      </div>

      {socialImages.length > 0 && (
        <div className="grid grid-cols-2 gap-4">
          {socialImages.map((src, i) => (
            <a
              key={src + i}
              href={socialLinks.profile}
              target="_blank"
              rel="noopener noreferrer"
              aria-label={`Kiriman media sosial Kementerian UMKM ${i + 1}`}
              className="group relative block overflow-hidden rounded-xl shadow-card aspect-square bg-cust-gray"
            >
              <img src={src} alt="" loading="lazy" className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" />
              <span className="absolute inset-x-0 bottom-0 h-1.5 bg-flash" />
            </a>
          ))}
        </div>
      )}
    </div>
  );
}
