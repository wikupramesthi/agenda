/** Utilitas kalender beranda: nama bulan/hari dan susunan sel satu bulan. */

export const MONTH_NAMES = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
];

export const WEEKDAY_LABELS = ['SEN', 'SEL', 'RAB', 'KAM', 'JUM', 'SAB', 'MIN'];

export const WEEKEND_INDEXES = [5, 6];

export const dateKey = (d: Date): string =>
  `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;

export const startOfMonth = (d: Date): Date => new Date(d.getFullYear(), d.getMonth(), 1);

export const shiftMonth = (d: Date, delta: number): Date => startOfMonth(new Date(d.getFullYear(), d.getMonth() + delta, 1));

export type CalendarCell = { date: Date; day: number; outside: boolean; weekend: boolean; today: boolean };

/** Grid 7 kolom, awal minggu Senin, selalu penuh (kelipatan 7 sel). */
export function buildMonth(month: Date, today = new Date()): CalendarCell[] {
  const first = startOfMonth(month);
  const lead = (first.getDay() + 6) % 7;
  const daysInMonth = new Date(first.getFullYear(), first.getMonth() + 1, 0).getDate();
  const cells: CalendarCell[] = [];

  const push = (d: Date, outside: boolean) => {
    const idx = cells.length % 7;
    cells.push({
      date: d,
      day: d.getDate(),
      outside,
      weekend: WEEKEND_INDEXES.includes(idx),
      today: !outside && dateKey(d) === dateKey(today),
    });
  };

  for (let i = lead; i > 0; i -= 1) push(new Date(first.getFullYear(), first.getMonth(), -i + 1), true);
  for (let d = 1; d <= daysInMonth; d += 1) push(new Date(first.getFullYear(), first.getMonth(), d), false);
  let next = 1;
  while (cells.length % 7 !== 0) push(new Date(first.getFullYear(), first.getMonth() + 1, next++), true);

  return cells;
}
