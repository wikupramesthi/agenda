export function SectionHeading({
  title,
  actionLabel,
  actionHref,
  actionClassName = "bg-blue2",
}: {
  title: string;
  actionLabel?: string;
  actionHref?: string;
  actionClassName?: string;
}) {
  return (
    <div className="ui-sec-head">
      <h2 className="ui-sec-title">{title}</h2>
      {actionLabel && actionHref ? (
        <div className="ui-sec-more">
          <div className="ui-btn">
            <a className={actionClassName} href={actionHref}>
              <span className="ui-btn-text">{actionLabel}</span>
              <i aria-hidden="true">›</i>
            </a>
          </div>
        </div>
      ) : null}
    </div>
  );
}
