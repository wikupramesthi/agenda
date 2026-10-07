import { useEffect, useState } from "react";

export type ApiDataState<T> = {
  data: T | null;
  loading: boolean;
  failed: boolean;
  error: unknown;
  reload: () => void;
};

// Hook generik pemuatan API sekali jalan: aman saat unmount (flag `alive`),
// hitung ulang via `reload()`, dan catat kegagalan ke console sekali saja.
// Dipakai semua seksi berita agar polanya tunggal dan ringan.
export function useApiData<T>(loader: () => Promise<T>, deps: unknown[], label: string): ApiDataState<T> {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<unknown>(null);
  const [reloadKey, setReloadKey] = useState(0);

  useEffect(() => {
    let alive = true;
    setLoading(true);
    setError(null);
    loader()
      .then((value) => {
        if (!alive) return;
        setData(value);
        setLoading(false);
      })
      .catch((err: unknown) => {
        if (!alive) return;
        setError(err);
        setLoading(false);
        console.warn(`[${label}] API tak terjangkau:`, err);
      });
    return () => {
      alive = false;
    };
    // `deps` dari pemanggil (mis. `[slug]`) digabung kunci muat-ulang internal.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [reloadKey, ...deps]);

  return {
    data,
    loading,
    failed: error !== null,
    error,
    reload: () => setReloadKey((key) => key + 1),
  };
}
