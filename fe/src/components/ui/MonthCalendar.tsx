import { useMemo, useState } from 'react';
import { MONTH_NAMES, WEEKDAY_LABELS, buildMonth, dateKey, shiftMonth } from '@/lib/calendar';
import type { AgendaView } from '@/types/view';
import { Icon, ICON_PATH } from './Icon';

type MonthCalendarProps = { agenda: AgendaView[] };

/** Kalender bulanan kolom kanan: header navy, akhir pekan merah, hari ini lingkaran navy. */
export function MonthCalendar({ agenda }: MonthCalendarProps) {
  const today = useMemo(() => new Date(), []);
  const [month, setMonth] = useState(() => shiftMonth(today, 0));
  const cells = useMemo(() => buildMonth(month, today), [month, today]);
  const agendaDays = useMemo(() => new Set(agenda.map((a) => a.date).filter(Boolean)), [agenda]);

  return (
    <div className="bg-white rounded-lg shadow-card overflow-hidden text-center">
      <div className="bg-cust-blue text-white rounded-t-lg">
        <div className="grid grid-cols-7 items-center h-11 px-1">
          <button
            type="button"
            aria-label="Bulan sebelumnya"
            onClick={() => setMonth((m) => shiftMonth(m, -1))}
            className="col-start-1 h-11 flex items-center justify-center text-white/90 hover:text-white"
          >
            <Icon d={ICON_PATH.chevronLeft} className="w-4 h-4" />
          </button>
          <div className="col-start-2 col-end-7 font-bold text-[17px] leading-none">
            {MONTH_NAMES[month.getMonth()]} {month.getFullYear()}
          </div>
          <button
            type="button"
            aria-label="Bulan berikutnya"
            onClick={() => setMonth((m) => shiftMonth(m, 1))}
            className="col-start-7 col-end-8 h-11 flex items-center justify-center text-white/90 hover:text-white"
          >
            <Icon d={ICON_PATH.chevronRight} className="w-4 h-4" />
          </button>
        </div>
      </div>

      <div className="grid grid-cols-7 gap-1 px-2 pt-4 text-[11px] font-semibold text-gray-500">
        {WEEKDAY_LABELS.map((label) => (
          <div key={label} className={label === 'SAB' || label === 'MIN' ? 'text-red-500' : ''}>
            {label}
          </div>
        ))}
      </div>

      <div className="grid grid-cols-7 gap-1 px-2 pb-6 pt-2">
        {cells.map((cell) => (
          <div key={cell.date.toISOString()} className="relative">
            <span
              className={`cal-cell ${cell.today ? 'cal-today' : ''} ${cell.outside ? 'cal-muted' : ''} ${
                !cell.today && cell.weekend && !cell.outside ? 'cal-weekend' : ''
              }`}
            >
              {cell.day}
            </span>
            {agendaDays.has(dateKey(cell.date)) && (
              <span className="absolute left-1/2 -translate-x-1/2 bottom-1 w-1.5 h-1.5 rounded-full bg-cust-orange" />
            )}
          </div>
        ))}
      </div>
    </div>
  );
}
