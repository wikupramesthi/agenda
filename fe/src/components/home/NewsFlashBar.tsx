import type { NewsLinkView } from '@/types/view';

/**
 * Bar melayang 48px di bawah slideshow: badge kuning bersudut kanan membulat
 * lalu judul-judel running text yang bergulir terus (CSS marquee).
 */
export function NewsFlashBar({ items }: { items: NewsLinkView[] }) {
  if (!items.length) return null;
  const loop = [...items, ...items];

  return (
    <div className="h-12 flex items-center overflow-hidden bg-cust-blue">
      <div className="bg-flash h-12 w-40 flex items-center justify-center rounded-r-full flex-shrink-0 z-10">
        News Flash
      </div>
      <div className="flex-1 overflow-hidden text-white text-sm md:text-base">
        <div className="marquee-track">
          {loop.map((item, i) => (
            <span key={`${item.title}-${i}`} className="inline-flex items-center">
              <a href={item.href} target="_blank" rel="noopener noreferrer" className="px-4 hover:underline whitespace-nowrap">
                {item.title}
              </a>
              <span className="text-white/60">|</span>
            </span>
          ))}
        </div>
      </div>
    </div>
  );
}
