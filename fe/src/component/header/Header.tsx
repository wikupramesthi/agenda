import { useEffect, useRef, useState } from "react";

import { asset } from "../../app/assets";
import { useApiData } from "../../app/useApiData";
import { useWebsiteIdentity } from "../../app/WebsiteIdentityContext";
import { fetchHeaderMenu, toNavHref, type MenuItem } from "../../data/menus";

function MenuLink({ item, close }: { item: MenuItem; close?: () => void }) {
  const { href, external } = toNavHref(item);
  return (
    <a
      href={href}
      onClick={close}
      {...(external ? { target: "_blank", rel: "noopener noreferrer" } : {})}
    >
      {item.name}
    </a>
  );
}

function LinkList({ items, close }: { items: MenuItem[]; close?: () => void }) {
  return (
    <>
      {items.map((item) => (
        <li key={item.id}>
          <MenuLink item={item} close={close} />
        </li>
      ))}
    </>
  );
}

export function Header({ showAlert = true }: { showAlert?: boolean }) {
  const { data: apiItems } = useApiData(fetchHeaderMenu, [], "menus");
  const menuItems = apiItems ?? [];
  const { identity } = useWebsiteIdentity();
  const logoSrc = identity?.logo_url || asset("assets/logo.png");
  const logoAlt = identity?.site_name ? `logo ${identity.site_name}` : "logo DBMSDA";
  const contactPhone = identity?.phone || "112";
  const contactEmail = identity?.email || "dbmsdakotabekasi2018@gmail.com";
  const contactAddress = identity?.address || "Jl. Gerbang Pemuda No.3 Senayan, Jakarta Pusat 10270";

  const [dismissed, setDismissed] = useState(false);
  const [scrolled, setScrolled] = useState(false);
  const warningActive = showAlert && !dismissed && !scrolled;
  const [menuOpen, setMenuOpen] = useState(false);
  const [openDrop, setOpenDrop] = useState<string | null>(null);
  const closeButtonRef = useRef<HTMLButtonElement>(null);
  const menuButtonRef = useRef<HTMLButtonElement>(null);
  const panelRef = useRef<HTMLDivElement>(null);
  const warningRef = useRef<HTMLDivElement>(null);
  const closeMenu = () => {
    setMenuOpen(false);
    setOpenDrop(null);
  };
  const toggleDrop = (key: string) => setOpenDrop((value) => (value === key ? null : key));

  useEffect(() => {
    // Samakan perilaku situs referensi: banner merah meluncur naik saat halaman di-scroll,
    // muncul lagi saat kembali ke paling atas. Ditutup permanen via tombol ✕.
    let frame = 0;
    const threshold = 60;
    const update = () => {
      frame = 0;
      setScrolled(window.scrollY > threshold);
    };
    const onScroll = () => {
      if (frame) return;
      frame = window.requestAnimationFrame(update);
    };
    update();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => {
      window.removeEventListener("scroll", onScroll);
      if (frame) window.cancelAnimationFrame(frame);
    };
  }, []);

  useEffect(() => {
    // Saat meluncur naik (data-active=false) banner tidak boleh bisa di-Tab.
    const node = warningRef.current as unknown as { inert?: boolean } | null;
    if (node) node.inert = !warningActive;
  }, [warningActive]);

  useEffect(() => {
    // `inert` belum ada di tipe React 18, jadi diset imperatif agar panel
    // tertutup tidak bisa difokus via Tab.
    const panel = panelRef.current as unknown as { inert?: boolean } | null;
    if (panel) panel.inert = !menuOpen;
  }, [menuOpen]);

  useEffect(() => {
    if (!menuOpen) return;
    const previousOverflow = document.body.style.overflow;
    const handleKeys = (event: KeyboardEvent) => {
      if (event.key === "Escape") {
        setMenuOpen(false);
        return;
      }
      if (event.key !== "Tab") return;
      const panel = document.getElementById("site-menu");
      const focusable = panel
        ? Array.from(
            panel.querySelectorAll<HTMLElement>(
              "a[href], button:not([disabled]), input:not([disabled])",
            ),
          ).filter((element) => element.offsetParent !== null)
        : [];
      const first = focusable[0];
      const last = focusable.at(-1);
      if (!first || !last) return;
      if (event.shiftKey && document.activeElement === first) {
        event.preventDefault();
        last.focus();
      }
      if (!event.shiftKey && document.activeElement === last) {
        event.preventDefault();
        first.focus();
      }
    };
    document.body.style.overflow = "hidden";
    window.addEventListener("keydown", handleKeys);
    closeButtonRef.current?.focus();
    return () => {
      document.body.style.overflow = previousOverflow;
      window.removeEventListener("keydown", handleKeys);
      menuButtonRef.current?.focus({ preventScroll: true });
    };
  }, [menuOpen]);

  return (
    <>
      <header className="ui-header site-header-ready">
        <div className="ui-wrap">
          <div className={`ui-spacer${scrolled ? " is-block" : ""}`} />
          <div className={`ui-header-bar${scrolled ? " is-stuck" : ""}`}>
            <div className="ui-wrap">
              <div className="ui-logo">
                <a href="/" onClick={closeMenu}>
                  <img
                    alt={logoAlt}
                    src={logoSrc}
                    loading="lazy"
                    onError={(e) => {
                      const img = e.currentTarget as HTMLImageElement;
                      if (img.src !== asset("assets/logo.png")) img.src = asset("assets/logo.png");
                    }}
                  />
                </a>
              </div>
              {showAlert && (
              <div
                ref={warningRef}
                className="ui-alert"
                data-active={warningActive}
                aria-hidden={!warningActive}
              >
                <div className="ui-alert-row">
                  <div className="ui-alert-col ui-alert-media">
                    <div className="ui-alert-head">
                      <div className="ui-alert-icon">
                        <img alt="" src={asset("assets/warning.png")} />
                      </div>
                      <div className="ui-alert-title">
                        <strong>HIMBAUAN KEWASPADAAN</strong>
                        <span>WASPADA TERHADAP PENIPUAN</span>
                      </div>
                    </div>
                  </div>

                  <div className="ui-alert-col">
                    <div className="ui-alert-body">
                      <ol>
                        <li>
                          Masyarakat di himbau untuk{" "}
                          <strong>memastikan kebenaran informasi</strong> yang
                          mengatasnamakan DBMSDA Kota Bekasi melalui kanal resmi
                          Pemerintah Kota Bekasi.
                        </li>
                        <li>
                          DBMSDA Kota Bekasi{" "}
                          <strong>
                            tidak bertanggung jawab atas informasi atau tindakan
                          </strong>{" "}
                          yang dilakukan oleh pihak yang mengatasnamakan
                          instansi tanpa kewenangan resmi.
                        </li>
                        <li>
                          Apabila menemukan indikasi penipuan atau informasi
                          yang mencurigakan, masyarakat diharapkan{" "}
                          <strong>
                            segera melaporkannya melalui kanal pengaduan resmi Kota Bekasi di nomor 112.
                          </strong>
                        </li>
                      </ol>
                    </div>
                  </div>
                </div>

                <button
                  className="ui-alert-close"
                  type="button"
                  onClick={() => setDismissed(true)}
                  aria-label="Tutup peringatan"
                  tabIndex={warningActive ? 0 : -1}
                >
                  ✕
                </button>
              </div>
              )}
              <div className="ui-header-tools">
                <div className="ui-berakhlak">
                  <img alt="ASN BerAKHLAK" src={asset("assets/asn-berakhlak.png")} />
                </div>
                <button
                  ref={menuButtonRef}
                  className="ui-burger"
                  type="button"
                  onClick={() => setMenuOpen(true)}
                  aria-label="Buka menu"
                  aria-expanded={menuOpen}
                  aria-controls="site-menu"
                >
                  <img alt="" src={asset("assets/burger.png")} />
                </button>
                <div
                  id="site-menu"
                  ref={panelRef}
                  className={`ui-drawer${menuOpen ? " is-open" : ""}`}
                  aria-hidden={!menuOpen}
                >
                  <button
                    className="ui-drawer-bg"
                    type="button"
                    onClick={closeMenu}
                    aria-label="Tutup menu"
                    tabIndex={menuOpen ? 0 : -1}
                  />
                  <div className="ui-drawer-box">
                    <div className="ui-drawer-top">
                      <div className="only-mobile ui-drawer-logo">
                        <img
                          alt={logoAlt}
                          src={logoSrc}
                          loading="lazy"
                          onError={(e) => {
                            const img = e.currentTarget as HTMLImageElement;
                            if (img.src !== asset("assets/logo.png")) img.src = asset("assets/logo.png");
                          }}
                        />
                      </div>
                      <button
                        ref={closeButtonRef}
                        className="ui-drawer-close"
                        type="button"
                        onClick={closeMenu}
                        aria-label="Tutup menu"
                      >
                        ✕
                      </button>
                    </div>
                    <div className="ui-drawer-main">
                      <ul className="ui-drawer-nav">
                        {menuItems.map((item) =>
                          item.children.length > 0 ? (
                            <li key={item.id} className={`has-drop${openDrop === String(item.id) ? " is-open" : ""}`}>
                              <button
                                type="button"
                                className="drawer-drop-toggle"
                                aria-expanded={openDrop === String(item.id)}
                                onClick={() => toggleDrop(String(item.id))}
                              >
                                {item.name.toUpperCase()}
                              </button>
                              <ul className="ui-drop">
                                <LinkList items={item.children} close={closeMenu} />
                              </ul>
                            </li>
                          ) : (
                            <li key={item.id}>
                              <MenuLink item={item} close={closeMenu} />
                            </li>
                          ),
                        )}
                      </ul>
                      <div className="ui-drawer-foot">
                        <div className="ui-drawer-contact">
                          <div className="ui-drawer-contact-col ui-drawer-telp">
                            <p>Call Center: {contactPhone}</p>
                            <p>Email: {contactEmail}</p>
                          </div>
                          <div className="ui-drawer-contact-col ui-drawer-addr">
                            <p style={{ whiteSpace: "pre-line" }}>{contactAddress}</p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <nav className="ui-nav" aria-label="Navigasi utama">
                <div className="ui-nav-wrap">
                  <ul className="ui-nav-list">
                    {menuItems.map((item) =>
                      item.children.length > 0 ? (
                        <li key={item.id} className="ui-nav-drop-parent">
                          <MenuLink item={item} />
                          <ul className="ui-nav-drop">
                            <LinkList items={item.children} />
                          </ul>
                        </li>
                      ) : (
                        <li key={item.id}>
                          <MenuLink item={item} />
                        </li>
                      ),
                    )}
                  </ul>
                </div>
              </nav>
            </div>
          </div>
        </div>
      </header>
      <div className="ui-header-spacer" />
    </>
  );
}
