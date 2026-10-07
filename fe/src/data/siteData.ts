import { asset } from "../app/assets";
import { AGENDA_DETAIL_PATH, NEWS_DETAIL_PATH, OFFICIAL_DETAIL_PATH, PAGE_DETAIL_PATH, PHOTO_DETAIL_PATH } from "../app/constants";

export type News = { title: string; excerpt: string; image: string; date: string; category?: string; slug?: string; dateTime?: string };
export type DocumentPageContent = { title: string; color?: string; documents: string[] };
export type CalendarEvent = { day: string; month: string; title: string };
export type Officer = { name: string; role: string; image?: string };

export { PHOTO_DETAIL_PATH };

export const pageTitles: Record<string, string> = {
  "/": "Beranda", "/visi-misi": "Visi dan Misi", "/informasi-pejabat": "Informasi Pejabat",
  "/dokumen": "Dokumen",
  "/informasi-berkala": "Informasi Berkala",
  "/informasi-setiap-saat": "Informasi Setiap Saat",
  "/informasi-serta-merta": "Informasi Serta Merta",
  "/informasi-yang-dikecualikan": "Informasi yang Dikecualikan",
  "/berita": "Berita", "/galeri": "Galeri", "/album": "Album", "/event": "Event", "/pengumuman": "Pengumuman",
  "/layanan": "Layanan","/faq": "FAQ", "/teknis-peil-banjir": "Teknis Peil Banjir", "/pemanfaatan-ruang-jalan": "Pemanfaatan Ruang Jalan",
  "/404": "Halaman Tidak Ditemukan",
  [NEWS_DETAIL_PATH]: "Berita",
  [OFFICIAL_DETAIL_PATH]: "Pejabat",
  [AGENDA_DETAIL_PATH]: "Agenda",
  "/agenda": "Agenda",
  [PAGE_DETAIL_PATH]: "Halaman",
  [PHOTO_DETAIL_PATH]: "Menpora Erick Dampingi Presiden Prabowo Lepas 432 Atlet Indonesia",
};

// Pemetaan rute halaman -> slug kategori dokumen backend.
export const informationCategorySlugs: Record<string, string> = {
  "/informasi-berkala": "ppid-informasi-berkala",
  "/informasi-setiap-saat": "ppid-informasi-setiap-saat",
  "/informasi-serta-merta": "ppid-informasi-serta-merta",
  "/informasi-yang-dikecualikan": "ppid-informasi-yang-dikecualikan",
};

export const gallery = [
  { title: "DBMSDA Kota Bekasi Gelar Apel Pagi dan Pembinaan Pegawai", text: "Penguatan disiplin dan pelayanan infrastruktur untuk Kota Bekasi.", image: asset("assets/gallery-1.jpg") },
  { title: "Normalisasi Drainase dan Pengendalian Banjir Kota Bekasi", text: "Upaya berkelanjutan menjaga Kota Bekasi bebas genangan.", image: asset("assets/gallery-2.jpg") },
  { title: "DBMSDA Kota Bekasi Gelar Pemeliharaan Jalan dan Trotoar", text: "Momentum membangun infrastruktur yang aman dan nyaman bagi warga.", image: asset("assets/gallery-3.jpeg") },
];

export const announcements = [
  "PEMELIHARAAN RUTIN JALAN DAN DRAINASE KOTA BEKASI TRIWULAN I 2026",
  "HASIL EVALUASI KINERJA PENANGANAN GENANGAN TAHUN 2025",
  "PENYESUAIAN JADWAL PEMELIHARAAN JEMBATAN DAN TROTOAR 2026",
  "PANDUAN PENGADUAN MASYARAKAT TERKAIT JALAN DAN SALURAN AIR",
  "PEDOMAN TEKNIS PEIL BANJIR KOTA BEKASI 2026",
  "SELEKSI TERBUKA PENGAWAS LAPANGAN DBMSDA KOTA BEKASI TAHUN 2026",
];

export const policyPages: Record<string, DocumentPageContent> = {};

export const calendarEvents: CalendarEvent[] = [
  { day: "19", month: "SEP", title: "Pocari Sweat Run 2026" },
  { day: "20", month: "SEP", title: "Asian Games 2026" },
  { day: "03", month: "OKT", title: "Festival Pemuda Indonesia" },
  { day: "12", month: "OKT", title: "Forum Industri Olahraga" },
];

export const topLeaders: Officer[] = [
  { name: "Kepala Dinas DBMSDA", role: "Kepala Dinas Bina Marga dan Sumber Daya Air Kota Bekasi", image: asset("assets/minister.png") },
  { name: "Sekretaris DBMSDA", role: "Sekretaris Dinas Bina Marga dan Sumber Daya Air Kota Bekasi", image: asset("assets/vice.png") },
];

export const echelonOne: Officer[] = [
  { name: "Kabid Bina Marga", role: "Kepala Bidang Bina Marga DBMSDA Kota Bekasi" },
  { name: "Kabid Sumber Daya Air", role: "Kepala Bidang Sumber Daya Air DBMSDA Kota Bekasi" },
  { name: "Kabid Jasa Konstruksi", role: "Kepala Bidang Jasa Konstruksi DBMSDA Kota Bekasi" },
  { name: "Kabid Pemeliharaan", role: "Kepala Bidang Pemeliharaan Jalan & Drainase" },
  { name: "Kasubbag Umum", role: "Kepala Subbagian Umum & Kepegawaian DBMSDA" },
];
