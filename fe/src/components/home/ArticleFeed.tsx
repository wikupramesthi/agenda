import { useEffect, useState } from 'react';
import { GPR_FEED } from '@/data/site';

export type FeedEntry = { label: string; title: string; date: string; href: string };

const textIn = (node: Element, tag: string): string => node.getElementsByTagName(tag)[0]?.textContent?.trim() || '';

const stampOf = (raw: string): string => {
  if (!raw) return '';
  const d = new Date(raw);
  if (Number.isNaN(d.getTime())) return raw;
  const pad = (n: number) => String(n).padStart(2, '0');
  return `${pad(d.getDate())}-${pad(d.getMonth() + 1)}-${d.getFullYear()} ${pad(d.getHours())}:${pad(d.getMinutes())}`;
};

const parse = (xml: string, max: number): FeedEntry[] =>
  Array.from(new DOMParser().parseFromString(xml, 'text/xml').getElementsByTagName('item'))
    .slice(0, max)
    .map((node) => ({
      label: textIn(node, 'category_title') || 'Artikel',
      title: textIn(node, 'title'),
      date: stampOf(textIn(node, 'dateOrigin') || textIn(node, 'pubDate')),
      href: textIn(node, 'link'),
    }))
    .filter((entry) => entry.title && entry.href);

/**
 * Daftar "Artikel" pada kolom kanan. Sumbernya RSS publik yang sama dengan widget
 * di beranda asal, jadi kontennya selalu terbaru tanpa perlu ikut disalin.
 */
export function ArticleFeed({ limit = 8 }: { limit?: number }) {
  const [entries, setEntries] = useState<FeedEntry[]>([]);

  useEffect(() => {
    let alive = true;
    fetch(GPR_FEED)
      .then((r) => (r.ok ? r.text() : Promise.reject(new Error(`HTTP ${r.status}`))))
      .then((xml) => alive && setEntries(parse(xml, limit)))
      .catch(() => alive && setEntries([]));
    return () => {
      alive = false;
    };
  }, [limit]);

  if (!entries.length) return null;

  return (
    <ul className="flex flex-col">
      {entries.map((entry, i) => (
        <li key={`${entry.href}-${i}`}>
          <a
            href={entry.href}
            target="_blank"
            rel="noopener noreferrer"
            className="group flex flex-col gap-1 py-3 border-b border-dotted border-gray-500/60 last:border-0"
          >
            <div className="flex items-center justify-between gap-3">
              <span className="text-xs font-semibold text-cust-orange uppercase">{entry.label}</span>
              <span className="text-xs text-gray-500 whitespace-nowrap">{entry.date}</span>
            </div>
            <span className="text-sm leading-snug line-clamp-2 group-hover:text-cust-blue transition-colors">{entry.title}</span>
          </a>
        </li>
      ))}
    </ul>
  );
}
