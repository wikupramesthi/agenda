import { useEffect, useRef } from "react";
import { asset } from "../../app/assets";
import { TOUCH_DISMISS_PX, WHEEL_DISMISS_DELTA } from "../../app/constants";

type Props = { visible: boolean; onDismiss: () => void };

export function StartScreen({ visible, onDismiss }: Props) {
  const dismissRef = useRef<HTMLButtonElement>(null);

  useEffect(() => {
    if (!visible) return;
    const previousOverflow = document.body.style.overflow;
    let touchStart = 0;
    // Hanya tombol non-karakter yang menutup splash agar Enter/Spasi pada
    // kontrol interaktif tidak memicu dismiss tak terduga.
    const closeOnKey = (event: KeyboardEvent) => {
      const target = event.target as HTMLElement | null;
      const isInteractive = !!target?.closest("button, a, input, textarea, select");
      if (event.key === "Escape" || event.key === "ArrowDown" || event.key === "PageDown") {
        onDismiss();
        return;
      }
      if ((event.key === "Enter" || event.key === " ") && !isInteractive) onDismiss();
    };
    const closeOnWheel = (event: WheelEvent) => { if (event.deltaY > WHEEL_DISMISS_DELTA) onDismiss(); };
    const rememberTouch = (event: TouchEvent) => { touchStart = event.touches[0]?.clientY ?? 0; };
    const closeOnTouch = (event: TouchEvent) => {
      const end = event.changedTouches[0]?.clientY ?? touchStart;
      if (touchStart - end > TOUCH_DISMISS_PX) onDismiss();
    };
    document.body.style.overflow = "hidden";
    window.addEventListener("keydown", closeOnKey);
    window.addEventListener("wheel", closeOnWheel, { passive: true });
    window.addEventListener("touchstart", rememberTouch, { passive: true });
    window.addEventListener("touchend", closeOnTouch, { passive: true });
    dismissRef.current?.focus({ preventScroll: true });
    return () => {
      document.body.style.overflow = previousOverflow;
      window.removeEventListener("keydown", closeOnKey);
      window.removeEventListener("wheel", closeOnWheel);
      window.removeEventListener("touchstart", rememberTouch);
      window.removeEventListener("touchend", closeOnTouch);
    };
  }, [onDismiss, visible]);

  if (!visible) return null;
  return (
    <div className="ui-intro is-ready" role="dialog" aria-modal="true" aria-label="Selamat datang">
      <div className="ui-intro-logo"><img alt="Dinas Bina Marga dan Sumber Daya Air Kota Bekasi" src={asset("assets/logo-tagline.png")} /></div>
      <div className="ui-intro-shapes" aria-hidden="true">
        {[1, 2, 3, 4].map((item) => (
          <div className={`ui-intro-shape ui-intro-shapes${item}`} key={item}>
            <img alt="" className="only-desktop" src={asset(`assets/welcome${item}.png`)} />
            <img alt="" className="only-mobile" src={asset(`assets/welcomem${item}.png`)} />
          </div>
        ))}
      </div>
<div className="ui-intro-welcome">
  <div className="ui-intro-kicker">SELAMAT DATANG</div>
  <div className="ui-intro-sub">
    di Situs Resmi Dinas Bina Marga dan Sumber Daya Air Kota Bekasi
  </div>
</div>
      <button ref={dismissRef} className="ui-intro-scroll" type="button" onClick={onDismiss}><span>Scroll</span><span className="ui-intro-scroll-icon">⌄</span></button>
    </div>
  );
}
