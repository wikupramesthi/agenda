import type { AnchorHTMLAttributes, ReactNode } from 'react';

const VARIANTS = {
  /** Tombol hero: pil transparan bergaris putih. */
  'outline-light':
    'bg-transparent border border-white/90 text-white rounded-full px-10 py-3 hover:bg-white hover:text-cust-blue',
  /** Tombol gold berbentuk pil (banner arah kebijakan). */
  gold: 'bg-cust-orange text-white rounded-full px-10 py-3 hover:brightness-110',
  /** Tombol kecil rounded-xl, misalnya "Lihat Lainnya" pada kartu Kenali. */
  'gold-sm': 'bg-cust-orange text-white rounded-xl px-4 py-2 text-sm hover:brightness-110',
  'navy-sm': 'bg-cust-blue text-white rounded-xl px-4 py-2 text-sm hover:brightness-125',
  /** Tombol "Lihat Lainnya" besar di bagian Situs Terkait. */
  'navy-lg': 'bg-cust-blue text-white rounded-xl px-20 py-3 text-sm font-medium hover:brightness-125',
} as const;

export type PillVariant = keyof typeof VARIANTS;

const BASE =
  'inline-flex items-center justify-center text-center cursor-pointer transition-all duration-300 ease-in-out';

export const pillClass = (variant: PillVariant, className = ''): string => `${BASE} ${VARIANTS[variant]} ${className}`;

type PillLinkProps = AnchorHTMLAttributes<HTMLAnchorElement> & { variant?: PillVariant };

/** CTA bertaut; default membuka tautan resmi di tab baru. */
export function PillLink({ variant = 'gold-sm', className = '', target, rel, children, ...rest }: PillLinkProps) {
  return (
    <a
      target={target ?? '_blank'}
      rel={rel ?? 'noopener noreferrer'}
      className={pillClass(variant, className)}
      {...rest}
    >
      {children}
    </a>
  );
}

/** Versi tanpa tautan: dipakai saat CTA berada di dalam elemen <a> induk. */
export function PillTag({ variant = 'gold-sm', className = '', children }: { variant?: PillVariant; className?: string; children: ReactNode }) {
  return <span className={pillClass(variant, className)}>{children}</span>;
}
