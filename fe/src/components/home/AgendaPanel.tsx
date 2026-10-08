import { agendaItems, agendaMessage, eMag } from '@/data/beranda-view';

/** Kolom kanan: daftar agenda (umumnya kosong) + banner E-Magz. */
export function AgendaPanel() {
  return (
    <div className="flex flex-col gap-4">
      <h3 className="font-bold text-lg">Agenda UMKM</h3>

      {agendaItems.length ? (
        <ul className="flex flex-col gap-3">
          {agendaItems.map((item) => (
            <li key={item.href + item.title}>
              <a
                href={item.href}
                target="_blank"
                rel="noopener noreferrer"
                className="block bg-white rounded-lg p-3 shadow-sm hover:shadow transition-shadow"
              >
                {item.date ? <div className="text-xs text-cust-orange font-semibold">{item.date}</div> : null}
                <div className="text-sm font-medium leading-snug">{item.title}</div>
              </a>
            </li>
          ))}
        </ul>
      ) : (
        <div className="flex justify-center">
          <span className="text-xs px-4 py-2 rounded-full bg-white text-gray-500 shadow-sm">{agendaMessage}</span>
        </div>
      )}

      <a
        href={eMag.href}
        target="_blank"
        rel="noopener noreferrer"
        className="block w-full rounded-lg overflow-hidden shadow-card hover:brightness-105 transition"
      >
        <img src={eMag.image} alt="Majalah elektronik Kementerian UMKM" className="w-full h-auto object-cover" />
      </a>
    </div>
  );
}
