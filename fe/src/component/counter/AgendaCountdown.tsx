import { useCallback, useEffect, useState } from "react";
import {
  COUNTDOWN_INTERVAL_MS,
  MS_PER_DAY,
  MS_PER_HOUR,
  MS_PER_MINUTE,
} from "../../app/constants";
import { useApiData } from "../../app/useApiData";
import { agendaDetailHref, fetchAgendaList, type AgendaItem } from "../../data/agenda";

type TimeLeft = { days: number; hours: number; minutes: number };

function getTimeLeft(target: string): TimeLeft {
  const parsed = new Date(target).getTime();
  const distance = Number.isFinite(parsed) ? Math.max(0, parsed - Date.now()) : 0;
  return {
    days: Math.floor(distance / MS_PER_DAY),
    hours: Math.floor((distance % MS_PER_DAY) / MS_PER_HOUR),
    minutes: Math.floor((distance % MS_PER_HOUR) / MS_PER_MINUTE),
  };
}

function parseAgendaTarget(item: AgendaItem): string | null {
  if (!item.date) return null;
  const parts = item.date.split("-");
  if (parts.length !== 3) return null;
  const d = parts[0].padStart(2, "0");
  const m = parts[1].padStart(2, "0");
  const y = parts[2];
  if (!/^\d{4}$/.test(y) || !/^\d{1,2}$/.test(m) || !/^\d{1,2}$/.test(d)) return null;
  const timeRaw = item.timeStart?.trim() || "08:00";
  const hm = timeRaw.split(":");
  const hh = (hm[0] ?? "08").padStart(2, "0");
  const mm = (hm[1] ?? "00").padStart(2, "0");
  const ss = (hm[2] ?? "00").padStart(2, "0");
  const hhNum = Number(hh);
  const mmNum = Number(mm);
  if (!Number.isFinite(hhNum) || !Number.isFinite(mmNum)) return null;
  return `${y}-${m}-${d}T${hh}:${mm}:${ss}+07:00`;
}

function AgendaCountdownCard({ item }: { item: AgendaItem }) {
  const target = parseAgendaTarget(item);
  const calculate = useCallback(() => (target ? getTimeLeft(target) : { days: 0, hours: 0, minutes: 0 }), [target]);
  const [time, setTime] = useState<TimeLeft>(calculate);

  useEffect(() => {
    if (!target) return;
    setTime(calculate());
    const id = window.setInterval(() => setTime(calculate()), COUNTDOWN_INTERVAL_MS);
    return () => window.clearInterval(id);
  }, [calculate, target]);

  const href = agendaDetailHref(item);
  const metaParts = [item.dateLabel, item.timeStart ? `${item.timeStart}${item.timeEnd ? ` - ${item.timeEnd}` : ""}` : null, item.location].filter(Boolean);
  const isZero = time.days === 0 && time.hours === 0 && time.minutes === 0;

  const hasCountdown = Boolean(target && !isZero);

  return (
    <section className="ui-countdown-sec ui-gap" aria-label={`Agenda terbaru: ${item.title}`}>
      <div className="ui-wrap">
        <div
          className="ui-countdown-card"
          style={{
            justifyContent: hasCountdown ? "space-between" : "center",
            textAlign: hasCountdown ? "left" : "center",
            gap: "20px",
            padding: "26px 28px",
          }}
        >
          <div
            className="ui-countdown-left"
            style={{
              flex: hasCountdown ? "1 1 360px" : "0 1 720px",
              minWidth: 0,
              textAlign: hasCountdown ? "left" : "center",
              display: "grid",
              justifyItems: hasCountdown ? "start" : "center",
            }}
          >
            <span
              style={{
                display: "inline-block",
                padding: "3px 9px",
                borderRadius: "999px",
                background: "rgba(255,255,255,.18)",
                fontSize: "10px",
                fontWeight: 800,
                letterSpacing: ".07em",
                marginBottom: "8px",
              }}
            >
              AGENDA TERBARU
            </span>
            <h2 style={{ margin: 0, lineHeight: 1.25, fontSize: "clamp(18px, 2.2vw, 22px)" }}>
              <a href={href} style={{ color: "inherit", textDecoration: "none" }}>
                {item.title}
              </a>
            </h2>
            {metaParts.length > 0 && (
              <p style={{ margin: "8px 0 0", fontSize: "13px", opacity: 0.9, lineHeight: 1.4 }}>{metaParts.join(" • ")}</p>
            )}
            <a
              href={href}
              style={{
                display: "inline-flex",
                alignItems: "center",
                gap: "6px",
                marginTop: "14px",
                padding: "8px 18px",
                borderRadius: "999px",
                background: "#fff",
                color: "var(--ui-navy, #222262)",
                fontSize: "12px",
                fontWeight: 800,
                letterSpacing: ".04em",
                textDecoration: "none",
              }}
            >
              LIHAT DETAIL <span aria-hidden="true">›</span>
            </a>
          </div>

          {hasCountdown ? (
            <div className="ui-countdown-center" style={{ flex: "0 0 auto" }}>
              <div
                className="ui-countdown"
                role="timer"
                aria-label={`${time.days} hari ${time.hours} jam ${time.minutes} menit menuju ${item.title}`}
              >
                <div className="ui-time">
                  <span>{time.days}</span>
                  <small>Hari</small>
                </div>
                <div className="ui-sep" aria-hidden="true">
                  :
                </div>
                <div className="ui-time">
                  <span>{time.hours}</span>
                  <small>Jam</small>
                </div>
                <div className="ui-sep" aria-hidden="true">
                  :
                </div>
                <div className="ui-time">
                  <span>{time.minutes}</span>
                  <small>Menit</small>
                </div>
              </div>
            </div>
          ) : null}
        </div>
      </div>
    </section>
  );
}

export function AgendaCountdown() {
  const { data, loading, failed } = useApiData(() => fetchAgendaList({ perPage: 1 }), [], "agenda-latest");

  if (loading || failed) return null;
  const latest = data?.items?.[0];
  if (!latest) return null;
  return <AgendaCountdownCard item={latest} />;
}
