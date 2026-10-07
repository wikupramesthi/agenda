import { useEffect, useState } from "react";
import {
  COUNTDOWN_INTERVAL_MS,
  MS_PER_DAY,
  MS_PER_HOUR,
  MS_PER_MINUTE,
  PORPROV_DISMISS_KEY,
  PORPROV_RANGE_LABEL,
  PORPROV_TARGET,
} from "../../app/constants";
import { ROUTE_CHANGE_EVENT } from "../../app/useRoute";

type Parts = { days: number; hours: number; minutes: number };

// Hitung sisa waktu menuju pembukaan. Kembalikan null jika hari-H
// sudah terlewati agar floating otomatis hilang.
function getParts(): Parts | null {
  const parsed = new Date(PORPROV_TARGET).getTime();
  if (!Number.isFinite(parsed)) return null;
  const distance = parsed - Date.now();
  if (distance <= 0) return null;
  return {
    days: Math.floor(distance / MS_PER_DAY),
    hours: Math.floor((distance % MS_PER_DAY) / MS_PER_HOUR),
    minutes: Math.floor((distance % MS_PER_HOUR) / MS_PER_MINUTE),
  };
}

function pad(value: number, length: number): string {
  return String(Math.max(0, Math.floor(value))).padStart(length, "0");
}

function readCollapsed(): boolean {
  try {
    return sessionStorage.getItem(PORPROV_DISMISS_KEY) === "1";
  } catch {
    return false;
  }
}

function DigitGroup({ digits, label }: { digits: string; label: string }) {
  return (
    <div className="porprov-group">
      <div className="porprov-digits" aria-hidden="true">
        {digits.split("").map((digit, index) => (
          <span key={index} className="porprov-digit">{digit}</span>
        ))}
      </div>
      <span className="porprov-label">{label}</span>
    </div>
  );
}

export function PorprovFloatingCountdown({ path }: { path: string }) {
  const [collapsed, setCollapsed] = useState(readCollapsed);
  const [parts, setParts] = useState<Parts | null>(getParts);
  // Home: tampil hanya saat sudah sampai section layanan (.ui-service-sec),
  // sembunyi lagi saat scroll ke atas (banner-slider ke atas).
  // Halaman lain (tanpa section layanan): tetap tampil.
  const [pastLayanan, setPastLayanan] = useState(false);
  // Transisi slow: tetap di-mount saat menghilang agar fade-out halus.
  const [mounted, setMounted] = useState(false);
  const isHome = path === "/";

  useEffect(() => {
    // Samakan ritme dengan countdown lain (tiap 1 menit).
    setParts(getParts());
    const id = window.setInterval(() => setParts(getParts()), COUNTDOWN_INTERVAL_MS);
    return () => window.clearInterval(id);
  }, []);

  useEffect(() => {
    let frame = 0;
    const check = () => {
      frame = 0;
      // Halaman lain: tidak ada section layanan, tetap tampil.
      if (!isHome) {
        setPastLayanan(true);
        return;
      }
      const el = document.querySelector(".ui-service-sec");
      // Home tapi section belum render (lazy chunk): tetap sembunyi,
      // biar tidak nongol sesaat pas buka halaman.
      if (!el) {
        setPastLayanan(false);
        return;
      }
      // Home: tampil saat atas section layanan masuk 85% viewport,
      // sembunyi lagi saat scroll ke atas (masih di banner-slider ke atas).
      setPastLayanan(el.getBoundingClientRect().top <= window.innerHeight * 0.85);
    };
    const onScroll = () => {
      if (frame) return;
      frame = window.requestAnimationFrame(check);
    };
    check();
    window.addEventListener("scroll", onScroll, { passive: true });
    window.addEventListener("resize", check);
    window.addEventListener("popstate", check);
    window.addEventListener(ROUTE_CHANGE_EVENT, check);
    // Tangkap render telat (data API / lazy section).
    const timer = window.setInterval(check, 1200);
    return () => {
      window.removeEventListener("scroll", onScroll);
      window.removeEventListener("resize", check);
      window.removeEventListener("popstate", check);
      window.removeEventListener(ROUTE_CHANGE_EVENT, check);
      window.clearInterval(timer);
      if (frame) window.cancelAnimationFrame(frame);
    };
  }, [isHome]);

  // Efek slow: unmount ditunda sampai fade-out selesai.
  useEffect(() => {
    if (pastLayanan && parts !== null) {
      setMounted(true);
      return;
    }
    const t = window.setTimeout(() => setMounted(false), 1100);
    return () => window.clearTimeout(t);
  }, [pastLayanan, parts]);

  const shown = parts !== null && pastLayanan;

  // Setelah hari-H terlewati kedua varian otomatis hilang.
  if (parts === null) return null;
  // Home sebelum sampai layanan: disembunyikan; halaman lain: tetap tampil.
  if (!mounted) return null;

  const collapse = () => {
    try {
      sessionStorage.setItem(PORPROV_DISMISS_KEY, "1");
    } catch {
      // Abaikan: status mini tetap berlaku untuk sesi render ini.
    }
    setCollapsed(true);
  };

  const expand = () => {
    try {
      sessionStorage.removeItem(PORPROV_DISMISS_KEY);
    } catch {
      // Abaikan: panel tetap dibuka untuk sesi render ini.
    }
    setCollapsed(false);
  };

  const label = `${parts.days} hari ${parts.hours} jam ${parts.minutes} menit menuju Porprov Jabar XV`;

  // Mode mini: menempel di sisi kanan, bisa dibuka kembali.
  if (collapsed) {
    return (
      <aside className={`porprov-mini${shown ? " is-visible" : ""}`} role="timer" aria-label={label} aria-hidden={!shown}>
        <div className="porprov-mini-copy">
          <strong className="porprov-mini-title">Menuju Porprov Jabar XV</strong>
          <span className="porprov-mini-range">{PORPROV_RANGE_LABEL}</span>
        </div>
        <button
          type="button"
          className="porprov-open"
          onClick={expand}
          aria-expanded="false"
          aria-label="Buka panel hitung mundur Porprov Jabar XV"
        >
          Buka
        </button>
      </aside>
    );
  }

  return (
    <aside
      className={`porprov-float${shown ? " is-visible" : ""}`}
      role="timer"
      aria-label={label}
      aria-hidden={!shown}
    >
      <div className="porprov-head">
        <div className="porprov-copy">
          <strong className="porprov-title">Menuju Porprov Jabar XV</strong>
          <span className="porprov-range">{PORPROV_RANGE_LABEL}</span>
        </div>
        <button
          type="button"
          className="porprov-close"
          onClick={collapse}
          aria-expanded="true"
          aria-label="Tutup panel hitung mundur Porprov Jabar XV"
        >
          Tutup
        </button>
      </div>
      <div className="porprov-body">
        <DigitGroup digits={pad(parts.days, 3)} label="Hari" />
        <DigitGroup digits={pad(parts.hours, 2)} label="Jam" />
        <DigitGroup digits={pad(parts.minutes, 2)} label="Menit" />
      </div>
    </aside>
  );
}
