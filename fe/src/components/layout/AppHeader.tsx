import { useEffect, useState } from 'react';
import { official } from '@/data/beranda-view';
import { ICONS } from '@/data/site';
import { Icon, ICON_PATH } from '@/components/ui/Icon';
import { MenuDrawer } from './MenuDrawer';

const LANGUAGES = ['Indonesia', 'English'];

/**
 * Bar navigasi tetap di atas: transparan dengan logo putih saat di puncak,
 * lalu menjadi putih dengan logo warna setelah halaman digulir.
 */
export function AppHeader() {
  const [drawer, setDrawer] = useState(false);
  const [solid, setSolid] = useState(false);
  const [langOpen, setLangOpen] = useState(false);

  useEffect(() => {
    const onScroll = () => setSolid(window.scrollY > 40);
    onScroll();
    window.addEventListener('scroll', onScroll, { passive: true });
    return () => window.removeEventListener('scroll', onScroll);
  }, []);

  useEffect(() => {
    document.body.style.overflow = drawer ? 'hidden' : '';
    return () => {
      document.body.style.overflow = '';
    };
  }, [drawer]);

  return (
    <>
      <header
        className={`fixed top-0 z-40 flex items-center justify-between w-full min-h-20 px-5 lg:px-20 py-4 transition-all duration-300 ease-in-out ${
          solid ? 'bg-white text-cust-blue drop-shadow-lg' : 'bg-transparent text-white'
        }`}
      >
        <button
          type="button"
          onClick={() => setDrawer(true)}
          aria-label="Buka menu navigasi"
          className="cursor-pointer focus:outline-none"
        >
          <Icon d={ICON_PATH.menu} />
        </button>

        <a href={official.site} target="_blank" rel="noopener noreferrer" className="flex justify-center cursor-pointer">
          <img
            src={solid ? ICONS.logoColor : ICONS.logoWhite}
            alt="Logo Kementerian UMKM"
            width={100}
            height={100}
            decoding="async"
            className="w-52"
          />
        </a>

        <div className="relative flex items-center gap-2 cursor-pointer" onClick={() => setLangOpen((v) => !v)}>
          <img src={ICONS.flagId} alt="Bahasa Indonesia" width={24} height={24} className="w-6 h-6 rounded-full" />
          <Icon d={ICON_PATH.chevronDown} className="w-4 h-4" />

          {langOpen && (
            <ul className="absolute right-0 top-9 w-40 bg-white text-cust-black rounded-lg shadow-lg overflow-hidden animate-fade">
              {LANGUAGES.map((lang, i) => (
                <li
                  key={lang}
                  role="button"
                  tabIndex={0}
                  onClick={(e) => {
                    e.stopPropagation();
                    setLangOpen(false);
                  }}
                  onKeyDown={(e) => e.key === 'Enter' && setLangOpen(false)}
                  className={`px-4 py-2 text-sm cursor-pointer hover:bg-cust-gray ${
                    i === 0 ? 'font-semibold text-cust-blue' : ''
                  }`}
                >
                  {lang}
                </li>
              ))}
            </ul>
          )}
        </div>
      </header>

      <MenuDrawer open={drawer} onClose={() => setDrawer(false)} />
    </>
  );
}
