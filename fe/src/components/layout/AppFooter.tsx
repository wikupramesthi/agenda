import { official, socialAccounts } from '@/data/beranda-view';
import { ICONS } from '@/data/site';

/** Panel kontak navy + strip penanda asal-usul halaman di paling bawah. */
export function AppFooter() {
  return (
    <footer className="flex flex-col items-center justify-center">
      <div className="flex flex-col md:flex-row w-full items-start justify-start gap-8 md:gap-10 px-8 md:px-10 lg:px-20 py-8 md:py-10 bg-cust-blue text-white">
        <div className="flex flex-col items-center md:items-start gap-4 w-full md:w-2/4">
          <div className="relative w-72 h-20">
            <img src={official.logo || ICONS.logoWhite} alt="Logo Kementerian UMKM" className="object-contain w-72 h-20" />
          </div>
          <p className="text-base font-normal text-center md:text-left">{official.address}</p>
          <a href={`tel:${official.phone}`} className="text-base font-normal text-center md:text-left hover:underline">
            Call Center {official.phone}
          </a>
          <a href={`mailto:${official.email}`} className="text-base font-normal text-center md:text-left hover:underline">
            {official.email}
          </a>

          <div className="flex items-center justify-start gap-5">
            {socialAccounts.map((account) => (
              <a
                key={account.label}
                href={account.href}
                target="_blank"
                rel="noopener noreferrer"
                aria-label={account.label}
                className="cursor-pointer"
              >
                <img src={account.icon} alt={account.label} className="w-9 h-9" />
              </a>
            ))}
          </div>
        </div>
        <hr className="block md:hidden w-full h-1 border-white" />
      </div>

      <div className="flex justify-center items-center w-full px-8 md:px-10 lg:px-20 py-2 text-xs font-light text-center text-white bg-night">
        Rekonstruksi antarmuka beranda umkm.go.id · bukan situs resmi ·{' '}
        <a href={official.site} target="_blank" rel="noopener noreferrer" className="ml-1 underline">
          {official.site.replace('https://', '')}
        </a>
      </div>
    </footer>
  );
}
