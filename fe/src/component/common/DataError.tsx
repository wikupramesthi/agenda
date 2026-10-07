// Blok error baku seksi berita: pesan + tombol muat ulang.
export function DataError({ onRetry }: { onRetry: () => void }) {
  return (
    <div className="ui-wrap">
      <div className="empty-state" role="status">
        <h3>Berita tidak dapat dimuat</h3>
        <p>Periksa koneksi ke server API, lalu coba lagi.</p>
        <div className="ui-btn">
          <button type="button" onClick={onRetry}>
            <span className="ui-btn-text">COBA LAGI</span>
            <i aria-hidden="true">›</i>
          </button>
        </div>
      </div>
    </div>
  );
}
