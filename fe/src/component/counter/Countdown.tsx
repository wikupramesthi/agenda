import { useCallback, useEffect, useState } from "react";
import {
  COUNTDOWN_INTERVAL_MS,
  MS_PER_DAY,
  MS_PER_HOUR,
  MS_PER_MINUTE,
} from "../../app/constants";

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

export function Countdown({ title, target, image }: { title: string; target: string; image: string }) {
  const calculate = useCallback(() => getTimeLeft(target), [target]);
  const [time, setTime] = useState<TimeLeft>(calculate);
  useEffect(() => {
    setTime(calculate());
    const id = window.setInterval(() => setTime(calculate()), COUNTDOWN_INTERVAL_MS);
    return () => window.clearInterval(id);
  }, [calculate]);
  return <section className="ui-countdown-sec ui-gap"><div className="ui-wrap"><div className="ui-countdown-card"><div className="ui-countdown-left"><h2>{title}</h2></div><div className="ui-countdown-center"><div className="ui-countdown" role="timer" aria-label={`${time.days} hari ${time.hours} jam ${time.minutes} menit menuju ${title}`}><div className="ui-time"><span>{time.days}</span><small>Hari</small></div><div className="ui-sep" aria-hidden="true">:</div><div className="ui-time"><span>{time.hours}</span><small>Jam</small></div><div className="ui-sep" aria-hidden="true">:</div><div className="ui-time"><span>{time.minutes}</span><small>Menit</small></div></div></div><div className="ui-countdown-right"><img alt={title} src={image} loading="lazy" /></div></div></div></section>;
}
