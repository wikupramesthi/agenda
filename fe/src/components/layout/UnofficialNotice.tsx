import { useState } from 'react';
import { official } from '@/data/beranda-view';

/**
 * Penanda asal-usul halaman. Tampilan ini meniru portal pemerintah, jadi keterangan
 * "bukan situs resmi" sengaja ditampilkan di setiap layar dan hanya bisa ditutup
 * sementara (muncul lagi saat halaman dimuat ulang).
 */
export function UnofficialNotice() {
  const [hidden, setHidden] = useState(false);
  if (hidden) return null;

  return (
    <div className="fixed bottom-4 left-4 right-4 sm:right-auto z-50 flex items-start gap-3 max-w-sm px-4 py-3 text-xs text-white rounded-xl bg-night/95 shadow-lg ring-1 ring-white/15">
      <span aria-hidden className="flex items-center justify-center shrink-0 w-5 h-5 mt-0.5 font-bold rounded-full bg-cust-orange text-night">
        !
      </span>
      <p className="leading-relaxed">
        Halaman ini <strong>rekonstruksi antarmuka</strong> untuk latihan pengembangan, bukan situs resmi
        Kementerian UMKM. Seluruh tautan menunjuk ke{' '}
        <a href={official.site} target="_blank" rel="noopener noreferrer" className="font-semibold underline">
          umkm.go.id
        </a>
        .
      </p>
      <button type="button" onClick={() => setHidden(true)} aria-label="Tutup keterangan" className="shrink-0 text-white/60 hover:text-white">
        ✕
      </button>
    </div>
  );
}
