import { menuItems, official } from '@/data/beranda-view';
import { ICONS } from '@/data/site';
import { Icon, ICON_PATH } from '@/components/ui/Icon';

type MenuDrawerProps = { open: boolean; onClose: () => void };

/** Panel navigasi kiri berwarna navy, muncul dari tombol hamburger. */
export function MenuDrawer({ open, onClose }: MenuDrawerProps) {
  return (
    <>
      <div
        onClick={onClose}
        aria-hidden
        className={`fixed inset-0 z-40 bg-black/40 transition-opacity duration-300 ${
          open ? 'opacity-100' : 'opacity-0 pointer-events-none'
        }`}
      />

      <aside
        aria-hidden={!open}
        className={`fixed top-0 left-0 h-full w-64 bg-cust-blue text-white z-50 transform transition-transform duration-300 ${
          open ? 'translate-x-0' : '-translate-x-full'
        }`}
      >
        <div className="p-4 flex justify-end">
          <button type="button" onClick={onClose} aria-label="Tutup menu" className="cursor-pointer focus:outline-none">
            <Icon d={ICON_PATH.close} />
          </button>
        </div>

        <nav className="mt-4">
          <ul>
            {menuItems.map((item) => (
              <li key={item.label}>
                <a
                  href={item.href}
                  target="_blank"
                  rel="noopener noreferrer"
                  onClick={onClose}
                  className="flex items-center gap-3 h-12 px-6 text-base hover:bg-white/10 hover:pl-8 transition-all duration-200"
                >
                  <span>{item.label}</span>
                </a>
              </li>
            ))}
          </ul>

          <hr className="h-[1px] mx-6 my-3 bg-white/30 border-0 rounded-full" />

          <a
            href={official.whatsapp}
            target="_blank"
            rel="noopener noreferrer"
            onClick={onClose}
            className="flex items-center gap-3 px-6 py-3 text-base hover:bg-white/10 hover:pl-8 transition-all duration-200"
          >
            <img src={ICONS.whatsapp} alt="" className="w-5 h-5" />
            <span>WA Center</span>
          </a>
        </nav>
      </aside>
    </>
  );
}
