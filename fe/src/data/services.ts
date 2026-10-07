import { fetchJson } from "../app/api";

export type Service = {
  uuid: string;
  name: string;
  category: string;
  category_label: string;
  url: string | null;
  image_url: string | null;
  description: string | null;
  is_active: boolean;
  created_at: string | null;
};

type EnvelopePaginated<T> = {
  status: string;
  message: string;
  data: T;
  meta?: {
    current_page: number;
    per_page: number;
    total: number;
    last_page: number;
  };
};

export async function fetchServices(params?: { search?: string; category?: string }): Promise<Service[]> {
  const search = params?.search?.trim() ?? "";
  const category = params?.category?.trim() ?? "";
  const qs = new URLSearchParams();
  if (search) qs.set("search", search);
  if (category) qs.set("category", category);
  qs.set("per_page", "50");
  qs.set("status", "active");
  const query = qs.toString() ? `?${qs.toString()}` : "";
  const json = await fetchJson<EnvelopePaginated<Service[]>>(`/api/services${query}`);
  if (!Array.isArray(json.data)) throw new Error("Format respons layanan tak dikenal");
  return json.data;
}

export async function fetchServiceDetail(uuid: string): Promise<Service> {
  const json = await fetchJson<{ status: string; message: string; data: Service }>(`/api/services/${encodeURIComponent(uuid)}`);
  if (!json.data || Array.isArray(json.data)) throw new Error("Layanan tidak ditemukan");
  return json.data;
}
