import { ReactNode, useCallback, useEffect, useRef, useState, type MouseEvent as ReactMouseEvent } from "react";
import { INTRO_COOLDOWN_MS, INTRO_LAST_KEY } from "../../app/constants";
import { ROUTE_CHANGE_EVENT } from "../../app/useRoute";
import { Footer } from "../footer/Footer";
import { Header } from "../header/Header";
import { StartScreen } from "../start/StartScreen";
import { PorprovFloatingCountdown } from "../counter/PorprovFloatingCountdown";

function readNumber(key: string): number {
  const raw = localStorage.getItem(key);
  const value = raw === null ? 0 : Number(raw);
  return Number.isFinite(value) && value >= 0 ? Math.floor(value) : 0;
}

// Tentukan apakah splash boleh tampil pada pemuatan beranda ini.
// Interval murni 5 menit berdasar waktu terakhir tampil.
function shouldShowIntro(): boolean {
  try {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return false;
    const last = readNumber(INTRO_LAST_KEY);
    if (last === 0) return true;
    return Date.now() - last >= INTRO_COOLDOWN_MS;
  } catch {
    return true;
  }
}

function recordHomeVisit(shown: boolean) {
  try {
    if (shown) localStorage.setItem(INTRO_LAST_KEY, String(Date.now()));
  } catch {
    // Abaikan
  }
}

export function SiteLayout({ children, showIntro, path }: { path: string; children: ReactNode; showIntro: boolean }) {
  const [introVisible, setIntroVisible] = useState(() => showIntro && shouldShowIntro());
  const [navigating, setNavigating] = useState(false);
  const recordedRef = useRef(false);

  useEffect(() => {
    if (!showIntro) setIntroVisible(false);
  }, [showIntro]);

  // Catat tepat 1x per pemuatan beranda agar penghitung "tiap N kunjungan"
  // dan cooldown waktu akurat.
  useEffect(() => {
    if (!showIntro || recordedRef.current) return;
    recordedRef.current = true;
    recordHomeVisit(introVisible);
  }, [showIntro, introVisible]);

  const dismissIntro = useCallback(() => {
    setIntroVisible(false);
    // Kembalikan fokus ke konten utama agar keyboard/SR tidak tersesat.
    requestAnimationFrame(() => {
      document.getElementById("main-content")?.focus({ preventScroll: true });
    });
  }, []);

  const skipToContent = useCallback((event: ReactMouseEvent<HTMLAnchorElement>) => {
    // Fokus + scroll manual agar keyboard/SR langsung ke konten.
    // Fragment `#main-content` tidak mengubah pathname sehingga aman
    // untuk router (tidak dianggap pindah halaman).
    event.preventDefault();
    document.getElementById("main-content")?.focus({ preventScroll: false });
    document.getElementById("main-content")?.scrollIntoView({ block: "start" });
  }, []);

  // Bar loading tipis tiap pindah halaman (hilang sendiri <0,5 detik).
  useEffect(() => {
    let timer = 0;
    const onChange = () => {
      setNavigating(true);
      window.clearTimeout(timer);
      timer = window.setTimeout(() => setNavigating(false), 450);
    };
    window.addEventListener("popstate", onChange);
    window.addEventListener(ROUTE_CHANGE_EVENT, onChange);
    return () => {
      window.removeEventListener("popstate", onChange);
      window.removeEventListener(ROUTE_CHANGE_EVENT, onChange);
      window.clearTimeout(timer);
    };
  }, []);

  return (
    <>
      {navigating && <div className="route-loader" aria-hidden="true" />}
      <a className="skip-link" href="#main-content" onClick={skipToContent}>Lewati ke konten utama</a>
      {showIntro && <StartScreen visible={introVisible} onDismiss={dismissIntro} />}
      <Header showAlert={showIntro} />
      <main id="main-content" tabIndex={-1}>{children}</main>
      <Footer />
      <PorprovFloatingCountdown path={path} />
    </>
  );
}
