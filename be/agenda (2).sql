-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 08, 2026 at 02:06 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `agenda`
--

-- --------------------------------------------------------

--
-- Table structure for table `aduans`
--

CREATE TABLE `aduans` (
  `uuid` char(36) NOT NULL,
  `nomor_aduan` varchar(50) NOT NULL,
  `user_uuid` char(36) DEFAULT NULL,
  `is_anonim` tinyint(1) NOT NULL DEFAULT 0,
  `kategori` enum('Drainase','Sungai/Kali','Tanggul','Polder/Kolam Retensi','Irigasi','Pematusan','Bangunan/Sarana SDA','Banjir/Genangan','Lainnya') NOT NULL,
  `judul` varchar(255) NOT NULL,
  `isi_aduan` text NOT NULL,
  `lokasi` varchar(255) DEFAULT NULL,
  `kecamatan_id` bigint(20) UNSIGNED DEFAULT NULL,
  `kelurahan_id` bigint(20) UNSIGNED DEFAULT NULL,
  `foto_1` varchar(255) DEFAULT NULL,
  `foto_2` varchar(255) DEFAULT NULL,
  `foto_3` varchar(255) DEFAULT NULL,
  `tanggal_kejadian` date DEFAULT NULL,
  `tanggal_pengaduan` datetime DEFAULT NULL,
  `status` enum('menunggu','diverifikasi','diproses','selesai','ditolak') NOT NULL DEFAULT 'menunggu',
  `prioritas` enum('rendah','sedang','tinggi','darurat') NOT NULL DEFAULT 'sedang',
  `sifat` enum('biasa','penting','segera','rahasia') NOT NULL DEFAULT 'biasa',
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `archived_at` timestamp NULL DEFAULT NULL,
  `rating` tinyint(3) UNSIGNED DEFAULT NULL,
  `ulasan` text DEFAULT NULL,
  `rated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `aduan_tindak_lanjuts`
--

CREATE TABLE `aduan_tindak_lanjuts` (
  `uuid` char(36) NOT NULL,
  `aduan_uuid` char(36) NOT NULL,
  `user_uuid` char(36) DEFAULT NULL,
  `status` enum('menunggu','diverifikasi','diproses','selesai','ditolak') DEFAULT NULL,
  `catatan` text NOT NULL,
  `foto_1` varchar(255) DEFAULT NULL,
  `foto_2` varchar(255) DEFAULT NULL,
  `tanggal` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `agendas`
--

CREATE TABLE `agendas` (
  `uuid` char(36) NOT NULL,
  `user_uuid` char(36) NOT NULL,
  `category_uuid` char(36) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `excerpt` text DEFAULT NULL,
  `content` longtext NOT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `scheduled_at` timestamp NULL DEFAULT NULL,
  `views` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_popular` tinyint(1) NOT NULL DEFAULT 0,
  `tagging` varchar(255) DEFAULT NULL,
  `status` enum('draft','published','scheduled','pending') NOT NULL DEFAULT 'draft',
  `search_engine` enum('index','noindex') NOT NULL DEFAULT 'index',
  `link` varchar(255) DEFAULT NULL,
  `video` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `agendas`
--

INSERT INTO `agendas` (`uuid`, `user_uuid`, `category_uuid`, `title`, `slug`, `excerpt`, `content`, `featured_image`, `scheduled_at`, `views`, `is_featured`, `is_popular`, `tagging`, `status`, `search_engine`, `link`, `video`, `created_at`, `updated_at`, `deleted_at`) VALUES
('89355860-0de5-4a90-9567-f8c68d5fe4de', '0a091f5a-c510-4110-b2b2-2f992091fb1d', 'a58f5ebc-c8ec-48da-b6f9-a80b05ca40a0', 'dasd', 'dasd', 'dasda', '<p>dsada dsada</p>', 'images/bG1cr04Br6NCTiuxlyPaoCdH5LTcCkOzsqev3RYP.png', NULL, 1, 0, 0, NULL, 'published', 'index', NULL, NULL, '2026-10-07 14:17:16', '2026-10-07 23:42:30', NULL),
('fb3a98ff-7ded-4e38-a8f2-c1c21d13a3fb', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemerintah Kota Bekasi terus melak', 'pemerintah-kota-bekasi-terus-melakukan-upaya-pengendalian-daerah-aliran-sungai-(das)-rawa-tembaga-mulai-dari-hulu-hingga-hilir-guna-me', 'Pemerintah Kota Bekasi terus melakukan upaya pengendalian Daerah Aliran Sungai (DAS) Rawa Tembaga mulai dari...', '<p>Pemerintah Kota Bekasi terus melakukan upaya pengendalian Daerah Aliran Sungai (DAS) Rawa Tembaga mulai dari hulu hingga hilir guna meminimalisasi banjir di wilayah Kelurahan Pekayon Jaya dan Kayuringin Jaya, Kecamatan Bekasi Selatan.&nbsp;</p>\r\n\r\n<p>DAS Rawa Tembaga sejauh 5.872 kilometer dimulai dari&nbsp; hulunya di Pulau Sirih Utama hingga hulu di Kali Bekasi. Adapun wilayah penanganan DAS Rawa Tembaga melewati Perumahan Vila Jakasetia, Perumahan Green View, Perumahan Pondok Timur Mas, Perumahan Galaxy, Perumahan Pulo Permatasari, Perumahan Taman Cikas, Grand Kamala Lagoon, Perumahan Arjuna, sebagian saluran Pondok Pekayon, Perumahan BSK, Perumnas 1, dan Kompleks Kejaksaan.&nbsp;</p>\r\n\r\n<p>Pengendalian DAS Rawa Tembaga meliputi tindakan penanganan jangka pendek dan jangka panjang. Penanganan jangka pendek dilakukan dengan melakukan pengerukan dan pematusan saluran, penyediaan tiga buah pompa pengendali banjir, dan pemeliharaan pintu air.&nbsp;</p>\r\n\r\n<p>Sedangkan program jangka panjang, Pemerintah Kota Bekasi telah mempersiapkan master plan Pengendalian DAS Rawa Tembaga kemudian mengajukan permohonan bantuan kepada Pemerintah Provinsi Jawa Barat dan Balai Besar Wilayah Sungai Ciliwung Cisadane (BBWSCC) Kementerian Pekerjaan Umum dan Perumahan Rakyat (PUPR).&nbsp;</p>\r\n\r\n<p>Permohonan bantuan kepada Provinsi Jawa Barat disampaikan melalui Surat Nomor: 614/8025/Bekasikota, tanggal 29 Oktober 2021. Pemkot Bekasi mengajukan permohonan bantuan untuk pembangunan tanggul, pelebaran saluran, dan pembangunan long storage.</p>\r\n\r\n<p>Sementara kepada BBWSCC melalui Surat Nomor: 614/8026/Bekasikota, tanggal 29 Oktober 2021, Pemkot Bekasi mengajukan permohonan bantuan pelaksanaan kegiatan di tahun anggaran 2022. Usulan Pemerintah Kota Bekasi antara lain pembangunan tanggul, pelebaran saluran, pembangunan long storage, pemindahan pintu air Rawa Tembaga ke bagian hilir mendekati Kali Bekasi, dan pembangunan polder di hulu, tengah dan hilir DAS Rawa Tembaga. Selain itu, Pemkot Bekasi juga mengusulkan pembangunan saluran dari hilir crossing Tol Jakarta - Cikampek KM 12+100 sejajar dengan sisi selatan Jalan Kalimalang menuju Kali Bekasi, permohonan bantuan alat berat untuk pengerukan sedimentasi, dan permohonan bantuan pompa mobile yang akan ditempatkan di pintu Bendung Prisdo.</p>\r\n\r\n<p>Program penanganan DAS Rawa Tembaga telah dimulai sejak tahun 2003-2021 dan berlanjut pada rencana kegiatan tahun 2022.&nbsp;</p>\r\n\r\n<p>Realisasi kegiatan DAS Rawa Tembaga pada 2003 adalah pembangunan Polder Cikas, 2004 pembangunan kolam retensi sisi jalan tol, 2005 pembangunan Polde Jakasetia, 2010 pembangunan rumah pompa Rawa Tembaga, 2015-2016 pembangunan Polder Green View, 2017 pembangunan Polder PPS, 2018 pembangunan Polder PTM, 2018 pembangunan Polder BSK, dan 2021 pembangunan kolam retensi sisi jalan tol.&nbsp;</p>\r\n\r\n<p>Pemerintah Kota Bekasi juga mempersiapkan master plan DAS Rawa Tembaga dengan menerapkan lima kriteria penanganan yakni pembangunan polder/kolam retensi, duplikasi crossing saluran, normalisasi saluran berupa pelebaran dan peninggian tanggul, relokasi pintu bendung Rawa Tembaga, dan pembangunan saluran long storage.&nbsp;</p>\r\n\r\n<p>Identifikasi masalah telah dipetakan pada Penanganan DAS Rawa Tembaga di Segmen 6 mulai dari titik DAS Rawa Tembaga STA 2+750 di Outlet Kalimalang hingga titik STA 3+124 di pintu air Rawa Tembaga.</p>\r\n\r\n<p>Segmen 6 dimulai dari Outlet Kalimalang dengan elevasi 19,84 mdpl, kompleks BSK elevasi 16,10 mdpl dengan upaya peninggian tanggul 3-4 meter, Kantor kelurahan Kayuringin Jaya elevasi 17,60 mdpl dengan peninggian tanggul 2-2,5 meter, kompleks Kejaksaan elevasi 16,75 mdpl dengan peninggian tanggul 3-3,5 meter dan pintu air Rawa Tembaga elevasi 18,81 mdpl dengan peninggian tanggul 1 meter. (goeng/DNN)</p>\r\n', 'images/62b52a341904565e350bc28bee4fdf32.jpg', '2021-11-11 15:53:00', 1572, 0, 1, 'bekasi selatan, kota bekasi, jakasetia', 'published', 'index', NULL, NULL, '2021-11-11 15:53:00', '2026-10-07 23:56:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `agenda_images`
--

CREATE TABLE `agenda_images` (
  `uuid` char(36) NOT NULL,
  `agenda_uuid` char(36) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `albums`
--

CREATE TABLE `albums` (
  `uuid` char(36) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `cover` char(36) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `album_foto`
--

CREATE TABLE `album_foto` (
  `album_uuid` char(36) NOT NULL,
  `banner_uuid` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_uuid` char(36) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `event` varchar(30) NOT NULL,
  `auditable_type` varchar(255) DEFAULT NULL,
  `auditable_id` varchar(255) DEFAULT NULL,
  `auditable_label` varchar(255) DEFAULT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `url` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_uuid`, `user_name`, `user_email`, `event`, `auditable_type`, `auditable_id`, `auditable_label`, `old_values`, `new_values`, `url`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES
(407, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'created', 'App\\Models\\Article', 'a4ce109d-88de-423a-bb26-d11087f68a29', 'judul berita', NULL, '{\"user_uuid\":\"787b72ea-59d0-4d54-848b-c200bddafdd2\",\"category_uuid\":\"2162d145-9ef3-4e2f-8c55-81971a015bc5\",\"title\":\"judul berita\",\"slug\":\"judul-berita\",\"excerpt\":\"ringkasan\",\"content\":\"<p>isi berita<\\/p>\",\"scheduled_at\":\"2026-09-01 00:00:00\",\"tagging\":\"kota bekasi, walikota bekasi\",\"video\":null,\"status\":\"published\",\"search_engine\":\"index\",\"is_featured\":false,\"is_popular\":false,\"featured_image\":\"images\\/4vWMjOtHfGlFugvZ84preK7RAnVcqHFGWUIjJaeD.png\",\"uuid\":\"a4ce109d-88de-423a-bb26-d11087f68a29\",\"updated_at\":\"2026-09-20 18:19:34\",\"created_at\":\"2026-09-20 18:19:34\"}', 'http://localhost:8000/backend/articles', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 11:19:34', '2026-09-20 11:19:34'),
(408, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\User', '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin Bekasikota', '{\"name\":\"ESPRO Property\",\"email\":\"esproproperty.bekasi@gmail.com\",\"email_verified_at\":\"2026-09-19T02:27:18.000000Z\"}', '{\"name\":\"Admin Bekasikota\",\"email\":\"bekasikotakotabekasi2018@gmail.com\",\"email_verified_at\":\"2026-09-20 18:21:48\"}', 'http://localhost:8000/backend/user/9c513953-32d1-4415-a921-8a6baf246d44', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 11:21:48', '2026-09-20 11:21:48'),
(409, NULL, NULL, NULL, 'created', 'App\\Models\\LoginLockout', '35', 'LoginLockout #35', NULL, '{\"type\":\"ip\",\"value\":\"127.0.0.1\",\"attempts\":1,\"last_attempt_at\":\"2026-09-20 18:22:10\",\"updated_at\":\"2026-09-20 18:22:10\",\"created_at\":\"2026-09-20 18:22:10\",\"id\":35}', 'http://localhost:8000/auth/login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 11:22:10', '2026-09-20 11:22:10'),
(410, NULL, NULL, NULL, 'created', 'App\\Models\\LoginLockout', '36', 'LoginLockout #36', NULL, '{\"type\":\"email\",\"value\":\"bekasikotakotabekasi2018@gmail.com\",\"attempts\":1,\"last_attempt_at\":\"2026-09-20 18:22:10\",\"updated_at\":\"2026-09-20 18:22:10\",\"created_at\":\"2026-09-20 18:22:10\",\"id\":36}', 'http://localhost:8000/auth/login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 11:22:10', '2026-09-20 11:22:10'),
(411, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin Bekasikota', 'bekasikotakotabekasi2018@gmail.com', 'deleted', 'App\\Models\\Article', 'a4ce109d-88de-423a-bb26-d11087f68a29', 'judul berita', '{\"uuid\":\"a4ce109d-88de-423a-bb26-d11087f68a29\",\"user_uuid\":\"787b72ea-59d0-4d54-848b-c200bddafdd2\",\"category_uuid\":\"2162d145-9ef3-4e2f-8c55-81971a015bc5\",\"title\":\"judul berita\",\"slug\":\"judul-berita\",\"excerpt\":\"ringkasan\",\"content\":\"<p>isi berita<\\/p>\",\"featured_image\":\"images\\/4vWMjOtHfGlFugvZ84preK7RAnVcqHFGWUIjJaeD.png\",\"views\":0,\"is_featured\":false,\"is_popular\":false,\"tagging\":\"kota bekasi, walikota bekasi\",\"status\":\"published\",\"search_engine\":\"index\",\"link\":null,\"video\":null}', NULL, 'http://localhost:8000/backend/articles/a4ce109d-88de-423a-bb26-d11087f68a29', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 12:08:17', '2026-09-20 12:08:17'),
(412, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin Bekasikota', 'bekasikotakotabekasi2018@gmail.com', 'created', 'App\\Models\\Article', '2fa27e87-b4b5-4224-900d-26e44764d1e4', 'judul berita 2', NULL, '{\"user_uuid\":\"9c513953-32d1-4415-a921-8a6baf246d44\",\"category_uuid\":\"2162d145-9ef3-4e2f-8c55-81971a015bc5\",\"title\":\"judul berita 2\",\"slug\":\"judul-berita-2\",\"excerpt\":\"ringkasan\",\"content\":\"<p>isi berita<\\/p>\",\"scheduled_at\":\"2026-09-01 00:00:00\",\"tagging\":\"kota bekasi, walikota bekasi\",\"video\":null,\"status\":\"published\",\"search_engine\":\"index\",\"is_featured\":true,\"is_popular\":false,\"uuid\":\"2fa27e87-b4b5-4224-900d-26e44764d1e4\",\"updated_at\":\"2026-09-20 19:09:25\",\"created_at\":\"2026-09-20 19:09:25\"}', 'http://localhost:8000/backend/articles', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 12:09:25', '2026-09-20 12:09:25'),
(413, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin Bekasikota', 'bekasikotakotabekasi2018@gmail.com', 'updated', 'App\\Models\\Article', '2fa27e87-b4b5-4224-900d-26e44764d1e4', 'judul berita 2', '{\"featured_image\":null}', '{\"featured_image\":\"images\\/j6y3qSWN6dYvXjXiE41yWMTz0Z53cyxzaJD6YQWm.png\"}', 'http://localhost:8000/backend/articles/2fa27e87-b4b5-4224-900d-26e44764d1e4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 12:10:17', '2026-09-20 12:10:17'),
(414, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin Bekasikota', 'bekasikotakotabekasi2018@gmail.com', 'created', 'App\\Models\\DocumentCategory', 'a6d14f40-5032-40dc-9ef2-349d4300636f', 'IKM', NULL, '{\"uuid\":\"a6d14f40-5032-40dc-9ef2-349d4300636f\",\"name\":\"IKM\",\"slug\":\"ikm\",\"description\":\"Indeks Kepuasan Masyarakat\",\"status\":\"active\",\"updated_at\":\"2026-09-20 20:02:23\",\"created_at\":\"2026-09-20 20:02:23\"}', 'http://localhost:8000/backend/document-categories', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 13:02:23', '2026-09-20 13:02:23'),
(415, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin Bekasikota', 'bekasikotakotabekasi2018@gmail.com', 'created', 'App\\Models\\Document', '01a0beea-4a72-723e-a71b-5f20668c45b1', 'Indeks Kepuasan Masyarakat', NULL, '{\"category_uuid\":\"a6d14f40-5032-40dc-9ef2-349d4300636f\",\"title\":\"Indeks Kepuasan Masyarakat\",\"slug\":\"indeks-kepuasan-masyarakat\",\"excerpt\":\"Indeks Kepuasan Masyarakat\",\"description\":\"Indeks Kepuasan Masyarakat Tahun 2021\",\"published_at\":\"2021-09-21 00:00:00\",\"file\":\"documents\\/files\\/F7zMS5DOuHBcyaZIUiT5k4h5OFG69vxj3JT8Vhvh.pdf\",\"thumbnail\":null,\"status\":\"active\",\"uuid\":\"01a0beea-4a72-723e-a71b-5f20668c45b1\",\"updated_at\":\"2026-09-20 20:03:40\",\"created_at\":\"2026-09-20 20:03:40\"}', 'http://localhost:8000/backend/documents', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 13:03:40', '2026-09-20 13:03:40'),
(416, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'deleted', 'App\\Models\\ManagementAccess\\MenuGroup', '12', 'Profil Website', '{\"id\":12,\"name\":\"Profil Website\",\"status\":true,\"permission_name\":\"layanan.kontak\",\"icon\":\"bx-package\",\"position\":1}', NULL, 'http://127.0.0.1:8000/backend/menu/eyJpdiI6IkZ0MGdkUnMyQ0ZEQi9JWWMvZWVXWEE9PSIsInZhbHVlIjoiajhiZEF6NnkwblNmQzRna1dvNTZQQT09IiwibWFjIjoiMGZlNWJmYTE3MDI3N2M1NDM3YTczMjYwNGRkOWY0NGFjNzVmOWQ0NmE0ZDY0Njg1MjNhNTZhMzJmYWMyMThjYyIsInRhZyI6IiJ9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 13:13:10', '2026-10-07 13:13:10'),
(417, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\ManagementAccess\\Route', '163', 'Route #163', '{\"route\":\"specializations.destroy\",\"permission_name\":\"specializations.destroy\"}', '{\"route\":\"services.destroy\",\"permission_name\":\"services.destroy\"}', 'http://127.0.0.1:8000/backend/route/163', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 13:28:51', '2026-10-07 13:28:51'),
(418, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\ManagementAccess\\Route', '164', 'Route #164', '{\"route\":\"specializations.index\",\"permission_name\":\"specializations.index\"}', '{\"route\":\"services.index\",\"permission_name\":\"services.index\"}', 'http://127.0.0.1:8000/backend/route/164', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 13:29:11', '2026-10-07 13:29:11'),
(419, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\ManagementAccess\\Route', '165', 'Route #165', '{\"route\":\"specializations.store\",\"permission_name\":\"specializations.store\"}', '{\"route\":\"services.store\",\"permission_name\":\"services.store\"}', 'http://127.0.0.1:8000/backend/route/165', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 13:29:30', '2026-10-07 13:29:30'),
(420, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\ManagementAccess\\Route', '166', 'Route #166', '{\"route\":\"specializations.update\",\"permission_name\":\"specializations.update\"}', '{\"route\":\"services.update\",\"permission_name\":\"services.update\"}', 'http://127.0.0.1:8000/backend/route/166', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 13:29:55', '2026-10-07 13:29:55'),
(421, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\ManagementAccess\\MenuGroup', '22', 'Layanan Publik', '{\"permission_name\":\"class-schedules.index\"}', '{\"permission_name\":\"services.index\"}', 'http://127.0.0.1:8000/backend/menu/22', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 13:30:20', '2026-10-07 13:30:20'),
(422, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'deleted', 'App\\Models\\ManagementAccess\\MenuItem', '47', 'Schedule', '{\"id\":47,\"name\":\"Schedule\",\"icon\":null,\"route\":\"pages.index\",\"status\":true,\"permission_name\":\"classes.index\",\"menu_group_id\":22,\"position\":2}', NULL, 'http://127.0.0.1:8000/backend/menu/22/item/47', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 13:31:56', '2026-10-07 13:31:56'),
(423, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\ManagementAccess\\MenuItem', '46', 'Daftar Layanan', '{\"name\":\"Class List\",\"route\":\"pages.index\",\"permission_name\":\"classes.index\"}', '{\"name\":\"Daftar Layanan\",\"route\":\"services.index\",\"permission_name\":\"services.index\"}', 'http://127.0.0.1:8000/backend/menu/22/item/46', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 13:32:18', '2026-10-07 13:32:18'),
(424, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\ManagementAccess\\MenuGroup', '7', 'Publikasi', '{\"permission_name\":\"articles.index\"}', '{\"permission_name\":\"agendas.index\"}', 'http://127.0.0.1:8000/backend/menu/7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 13:55:13', '2026-10-07 13:55:13'),
(425, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\Category', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemerintahan', '{\"name\":\"Berita\",\"slug\":\"berita\",\"description\":\"Informasi terkini seputar program, kebijakan, dan perkembangan BMSDA.\"}', '{\"name\":\"Pemerintahan\",\"slug\":\"pemerintahan\",\"description\":\"Agenda resmi yang berkaitan dengan penyelenggaraan pemerintahan dan kebijakan daerah.\"}', 'http://127.0.0.1:8000/backend/categories/2162d145-9ef3-4e2f-8c55-81971a015bc5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:02:07', '2026-10-07 14:02:07'),
(426, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\Category', '34103609-8116-4baf-bd17-557fc6989e8e', 'Pelayanan & Masyarakat', '{\"name\":\"Pemeliharaan\",\"slug\":\"pemeliharaan\",\"description\":\"Perbaikan dan pemeliharaan infrastruktur.\"}', '{\"name\":\"Pelayanan & Masyarakat\",\"slug\":\"pelayanan-masyarakat\",\"description\":\"Kegiatan yang berkaitan dengan pelayanan publik dan interaksi langsung dengan masyarakat.\"}', 'http://127.0.0.1:8000/backend/categories/34103609-8116-4baf-bd17-557fc6989e8e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:02:30', '2026-10-07 14:02:30'),
(427, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\Category', '72561291-cdcb-484b-a556-0400fbd53c3d', 'Rapat & Koordinasi', '{\"name\":\"Pembangunan\",\"slug\":\"pembangunan\",\"description\":\"Perkembangan pembangunan infrastruktur daerah.\"}', '{\"name\":\"Rapat & Koordinasi\",\"slug\":\"rapat-koordinasi\",\"description\":\"Rapat, koordinasi, pembahasan, dan kegiatan internal pemerintahan.\"}', 'http://127.0.0.1:8000/backend/categories/72561291-cdcb-484b-a556-0400fbd53c3d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:02:50', '2026-10-07 14:02:50'),
(428, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\Category', 'a58f5ebc-c8ec-48da-b6f9-a80b05ca40a0', 'Acara & Seremonial', '{\"name\":\"Kegiatan\",\"slug\":\"kegiatan\",\"description\":\"Informasi event, workshop, retreat, dan berbagai kegiatan YogaRoots.\"}', '{\"name\":\"Acara & Seremonial\",\"slug\":\"acara-seremonial\",\"description\":\"Peresmian, upacara, peringatan, pelantikan, dan kegiatan seremonial lainnya.\"}', 'http://127.0.0.1:8000/backend/categories/a58f5ebc-c8ec-48da-b6f9-a80b05ca40a0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:03:08', '2026-10-07 14:03:08'),
(429, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'created', 'App\\Models\\Category', '773cd47c-dc89-4546-b6f0-bfb26f74a0a2', 'Lainnya', NULL, '{\"uuid\":\"773cd47c-dc89-4546-b6f0-bfb26f74a0a2\",\"name\":\"Lainnya\",\"slug\":\"lainnya\",\"description\":\"Agenda yang tidak termasuk dalam kategori yang tersedia.\",\"icon\":null,\"updated_at\":\"2026-10-07 21:03:26\",\"created_at\":\"2026-10-07 21:03:26\"}', 'http://127.0.0.1:8000/backend/categories', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:03:26', '2026-10-07 14:03:26'),
(430, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\User', '58cbfa68-69aa-4cd1-95cc-9520046d9ceb', 'Wiku Pramesthi Bagaswara', '{\"email_verified_at\":\"2026-09-19T00:40:13.000000Z\"}', '{\"email_verified_at\":\"2026-10-07 21:14:58\"}', 'http://127.0.0.1:8000/backend/user/58cbfa68-69aa-4cd1-95cc-9520046d9ceb', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:14:58', '2026-10-07 14:14:58'),
(431, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'created', 'App\\Models\\User', '0a091f5a-c510-4110-b2b2-2f992091fb1d', 'Diskominfostandi', NULL, '{\"name\":\"Diskominfostandi\",\"email\":\"diskominfostandi@bekasikota.go.id\",\"email_verified_at\":\"2026-10-07 21:15:33\",\"uuid\":\"0a091f5a-c510-4110-b2b2-2f992091fb1d\",\"updated_at\":\"2026-10-07 21:15:33\",\"created_at\":\"2026-10-07 21:15:33\"}', 'http://127.0.0.1:8000/backend/user', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:15:33', '2026-10-07 14:15:33'),
(432, '0a091f5a-c510-4110-b2b2-2f992091fb1d', 'Diskominfostandi', 'diskominfostandi@bekasikota.go.id', 'created', 'App\\Models\\Agenda', '89355860-0de5-4a90-9567-f8c68d5fe4de', 'dasd', NULL, '{\"user_uuid\":\"0a091f5a-c510-4110-b2b2-2f992091fb1d\",\"category_uuid\":\"a58f5ebc-c8ec-48da-b6f9-a80b05ca40a0\",\"title\":\"dasd\",\"slug\":\"dasd\",\"excerpt\":\"dasda\",\"content\":\"<p>dsada dsada<\\/p>\",\"scheduled_at\":null,\"tagging\":null,\"video\":null,\"status\":\"pending\",\"search_engine\":\"index\",\"is_featured\":false,\"is_popular\":false,\"featured_image\":\"images\\/Bap5YmJ5EmzA4lt77YqoONbVI76K1U4Q2j6u0alD.jpg\",\"uuid\":\"89355860-0de5-4a90-9567-f8c68d5fe4de\",\"updated_at\":\"2026-10-07 21:17:16\",\"created_at\":\"2026-10-07 21:17:16\"}', 'http://127.0.0.1:8000/backend/agendas', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:17:16', '2026-10-07 14:17:16'),
(433, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\Agenda', '89355860-0de5-4a90-9567-f8c68d5fe4de', 'dasd', '{\"status\":\"pending\"}', '{\"status\":\"draft\"}', 'http://127.0.0.1:8000/backend/agendas/89355860-0de5-4a90-9567-f8c68d5fe4de/reject', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:17:44', '2026-10-07 14:17:44'),
(434, '0a091f5a-c510-4110-b2b2-2f992091fb1d', 'Diskominfostandi', 'diskominfostandi@bekasikota.go.id', 'updated', 'App\\Models\\Agenda', '89355860-0de5-4a90-9567-f8c68d5fe4de', 'dasd', '{\"featured_image\":\"images\\/Bap5YmJ5EmzA4lt77YqoONbVI76K1U4Q2j6u0alD.jpg\",\"status\":\"draft\"}', '{\"featured_image\":\"images\\/bG1cr04Br6NCTiuxlyPaoCdH5LTcCkOzsqev3RYP.png\",\"status\":\"pending\"}', 'http://127.0.0.1:8000/backend/agendas/89355860-0de5-4a90-9567-f8c68d5fe4de', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:19:58', '2026-10-07 14:19:58'),
(435, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\Agenda', '89355860-0de5-4a90-9567-f8c68d5fe4de', 'dasd', '{\"status\":\"pending\"}', '{\"status\":\"published\"}', 'http://127.0.0.1:8000/backend/agendas/89355860-0de5-4a90-9567-f8c68d5fe4de/approve', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:20:07', '2026-10-07 14:20:07'),
(436, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'deleted', 'App\\Models\\ManagementAccess\\MenuGroup', '10', 'Profil Pejabat', '{\"id\":10,\"name\":\"Profil Pejabat\",\"status\":true,\"permission_name\":\"instruktur.index\",\"icon\":\"bx-user\",\"position\":6}', NULL, 'http://127.0.0.1:8000/backend/menu/eyJpdiI6IkkzVHQrVzQvdXJieU9uM2k1Slorb2c9PSIsInZhbHVlIjoiN3JzUmduWUdIZ04ydVEzdlVJa3o3UT09IiwibWFjIjoiMzgzN2FiYTAxNDU2OTUyYjM3OWM2N2E3MDgyZWNhY2FjYmY3ODNmMjQxMjhkNmVhMzgzNWE3OGZkZGFiODBkNCIsInRhZyI6IiJ9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:21:14', '2026-10-07 14:21:14'),
(437, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\ManagementAccess\\MenuGroup', '8', 'Galeri', '{\"name\":\"Pustaka Media\"}', '{\"name\":\"Galeri\"}', 'http://127.0.0.1:8000/backend/menu/8', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:21:52', '2026-10-07 14:21:52'),
(438, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\ManagementAccess\\MenuGroup', '8', 'Galeri Media', '{\"name\":\"Galeri\"}', '{\"name\":\"Galeri Media\"}', 'http://127.0.0.1:8000/backend/menu/8', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:22:09', '2026-10-07 14:22:09'),
(439, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'deleted', 'App\\Models\\Banner', '9c1f2fe3-0075-42bd-91dd-ff3b778be1d1', 'Banner #9c1f2fe3-0075-42bd-91dd-ff3b778be1d1', '{\"uuid\":\"9c1f2fe3-0075-42bd-91dd-ff3b778be1d1\",\"nama\":\"Kunjungan Kerja dalam rangka koordinasi dan konsultasi menca\",\"deskripsi\":\"Kunjungan Kerja dalam rangka koordinasi dan konsultasi menca\",\"link\":null,\"gambar\":\"banners\\/TV1O2hyrUIE9J5NDSHMoPwI3ecHvnm0gqhkQWEAT.jpg\",\"posisi\":\"galeri\",\"tipe\":\"foto\",\"video_url\":null,\"status\":\"active\"}', NULL, 'http://127.0.0.1:8000/backend/banner/9c1f2fe3-0075-42bd-91dd-ff3b778be1d1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:44:54', '2026-10-07 14:44:54'),
(440, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'deleted', 'App\\Models\\Banner', '06c5d7af-ea7a-490a-8908-5aac3b6e20c1', 'Banner #06c5d7af-ea7a-490a-8908-5aac3b6e20c1', '{\"uuid\":\"06c5d7af-ea7a-490a-8908-5aac3b6e20c1\",\"nama\":\"kunjungan kerja Pansus VI DPRD Kota Banjarbaru\",\"deskripsi\":\"kunjungan kerja Pansus VI DPRD Kota Banjarbaru\",\"link\":null,\"gambar\":\"banners\\/K9kbIQDeNG02yCQ78pB5ipqbjuFJuMiZ6C9j0f6n.jpg\",\"posisi\":\"galeri\",\"tipe\":\"foto\",\"video_url\":null,\"status\":\"active\"}', NULL, 'http://127.0.0.1:8000/backend/banner/06c5d7af-ea7a-490a-8908-5aac3b6e20c1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:44:59', '2026-10-07 14:44:59'),
(441, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'deleted', 'App\\Models\\Banner', 'c72bd89f-0849-40a1-927c-b9774e84bd2b', 'Banner #c72bd89f-0849-40a1-927c-b9774e84bd2b', '{\"uuid\":\"c72bd89f-0849-40a1-927c-b9774e84bd2b\",\"nama\":\"Rapat persiapan dan sinkronisasi\",\"deskripsi\":\"Rapat persiapan dan sinkronisasi\",\"link\":null,\"gambar\":\"banners\\/KdNt0w5McAu941Cf4qGF6n48HiBIRRlMBDCPtLGm.jpg\",\"posisi\":\"galeri\",\"tipe\":\"foto\",\"video_url\":null,\"status\":\"active\"}', NULL, 'http://127.0.0.1:8000/backend/banner/c72bd89f-0849-40a1-927c-b9774e84bd2b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:45:15', '2026-10-07 14:45:15'),
(442, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'deleted', 'App\\Models\\Banner', '8da02e21-bc7f-4816-ac56-1d762d11a546', 'Banner #8da02e21-bc7f-4816-ac56-1d762d11a546', '{\"uuid\":\"8da02e21-bc7f-4816-ac56-1d762d11a546\",\"nama\":\"Sosialisasi Rencana Pelaksanaan CASN dan Himbauan Netralitas\",\"deskripsi\":\"Sosialisasi Rencana Pelaksanaan CASN dan Himbauan Netralitas\",\"link\":null,\"gambar\":\"banners\\/wV5Acw9bGraRZlfprQDjzlPNW40xLn4uPcVNuzIH.jpg\",\"posisi\":\"galeri\",\"tipe\":\"foto\",\"video_url\":null,\"status\":\"active\"}', NULL, 'http://127.0.0.1:8000/backend/banner/8da02e21-bc7f-4816-ac56-1d762d11a546', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:45:19', '2026-10-07 14:45:19'),
(443, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'deleted', 'App\\Models\\Banner', '47618df4-1983-4686-b9fd-f67aa7fae89f', 'Banner #47618df4-1983-4686-b9fd-f67aa7fae89f', '{\"uuid\":\"47618df4-1983-4686-b9fd-f67aa7fae89f\",\"nama\":\"Penghargaan Peringkat X Evaluasi Akuntabilitas Kinerja tahun\",\"deskripsi\":\"Penghargaan Peringkat X Evaluasi Akuntabilitas Kinerja tahun\",\"link\":null,\"gambar\":\"banners\\/LYTwX1r9jIUlU0hAEUiW0ioEL9Qedq7aWKg3XEV4.jpg\",\"posisi\":\"galeri\",\"tipe\":\"foto\",\"video_url\":null,\"status\":\"active\"}', NULL, 'http://127.0.0.1:8000/backend/banner/47618df4-1983-4686-b9fd-f67aa7fae89f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:45:24', '2026-10-07 14:45:24'),
(444, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'deleted', 'App\\Models\\Banner', 'f7bd2370-bdad-42dc-909b-1239c040d0d3', 'Banner #f7bd2370-bdad-42dc-909b-1239c040d0d3', '{\"uuid\":\"f7bd2370-bdad-42dc-909b-1239c040d0d3\",\"nama\":\"Sosialisasi pengendalian gratifikasi\",\"deskripsi\":\"Sosialisasi pengendalian gratifikasi\",\"link\":null,\"gambar\":\"banners\\/OrXZyrmNIp2hXdxa5WXkeWArSDrgnTZ2EzSfumja.jpg\",\"posisi\":\"galeri\",\"tipe\":\"foto\",\"video_url\":null,\"status\":\"active\"}', NULL, 'http://127.0.0.1:8000/backend/banner/f7bd2370-bdad-42dc-909b-1239c040d0d3', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:45:28', '2026-10-07 14:45:28'),
(445, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\DocumentCategory', 'a6d14f40-5032-40dc-9ef2-349d4300636f', 'Undangan', '{\"name\":\"IKM\",\"slug\":\"ikm\",\"description\":\"Indeks Kepuasan Masyarakat\"}', '{\"name\":\"Undangan\",\"slug\":\"undangan\",\"description\":\"Dokumen undangan untuk agenda atau kegiatan pemerintah.\"}', 'http://127.0.0.1:8000/backend/document-categories/a6d14f40-5032-40dc-9ef2-349d4300636f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:51:04', '2026-10-07 14:51:04'),
(446, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\DocumentCategory', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'Materi Agenda', '{\"name\":\"Dokumen Lainnya\",\"slug\":\"dokumen-lainnya\",\"description\":\"Dokumen pendukung lainnya yang berkaitan dengan tugas dan fungsi organisasi.\"}', '{\"name\":\"Materi Agenda\",\"slug\":\"materi-agenda\",\"description\":\"Materi Agenda\"}', 'http://127.0.0.1:8000/backend/document-categories/01a9274f-003b-4ebc-b62a-b22f1091afd5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:51:21', '2026-10-07 14:51:21'),
(447, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\DocumentCategory', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'Materi Agenda', '{\"description\":\"Materi Agenda\"}', '{\"description\":\"Materi, paparan, atau bahan yang digunakan dalam agenda.\"}', 'http://127.0.0.1:8000/backend/document-categories/01a9274f-003b-4ebc-b62a-b22f1091afd5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:51:35', '2026-10-07 14:51:35'),
(448, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\DocumentCategory', 'd5394429-10b1-4222-86b4-68c6da8dfe0d', 'Hasil Kegiatan', '{\"name\":\"SPBE\",\"slug\":\"spbe\",\"description\":\"Dokumen terkait penyelenggaraan pemerintahan berbasis elektronik.\"}', '{\"name\":\"Hasil Kegiatan\",\"slug\":\"hasil-kegiatan\",\"description\":\"Berita acara, notulen, atau hasil dari pelaksanaan agenda.\"}', 'http://127.0.0.1:8000/backend/document-categories/d5394429-10b1-4222-86b4-68c6da8dfe0d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:51:50', '2026-10-07 14:51:50'),
(449, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\DocumentCategory', '9c0c6f74-224c-4af9-b1cf-dd9d46a8c685', 'Laporan', '{\"name\":\"Pelayanan Publik\",\"slug\":\"pelayanan-publik\",\"description\":\"Dokumen terkait penyelenggaraan dan peningkatan kualitas pelayanan publik.\"}', '{\"name\":\"Laporan\",\"slug\":\"laporan\",\"description\":\"Laporan pelaksanaan atau dokumentasi hasil kegiatan.\"}', 'http://127.0.0.1:8000/backend/document-categories/9c0c6f74-224c-4af9-b1cf-dd9d46a8c685', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:52:06', '2026-10-07 14:52:06'),
(450, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\DocumentCategory', 'b8d57474-3500-4caa-8d20-a3f1141c47e6', 'Dokumen Pendukung', '{\"name\":\"SAKIP\",\"slug\":\"sakip\",\"description\":\"Dokumen terkait sistem akuntabilitas dan pengelolaan kinerja organisasi.\"}', '{\"name\":\"Dokumen Pendukung\",\"slug\":\"dokumen-pendukung\",\"description\":\"Dokumen lain yang berkaitan dengan agenda.\"}', 'http://127.0.0.1:8000/backend/document-categories/b8d57474-3500-4caa-8d20-a3f1141c47e6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 14:52:24', '2026-10-07 14:52:24'),
(451, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\Agenda', '89355860-0de5-4a90-9567-f8c68d5fe4de', 'dasd', '{\"views\":0}', '{\"views\":1}', 'http://127.0.0.1:8000/backend/agendas/dasd', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 23:42:30', '2026-10-07 23:42:30'),
(452, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\Agenda', 'fb3a98ff-7ded-4e38-a8f2-c1c21d13a3fb', 'Pemerintah Kota Bekasi terus melak', '{\"views\":1571}', '{\"views\":1572}', 'http://127.0.0.1:8000/backend/agendas/pemerintah-kota-bekasi-terus-melakukan-upaya-pengendalian-daerah-aliran-sungai-%28das%29-rawa-tembaga-mulai-dari-hulu-hingga-hilir-guna-me', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 23:56:44', '2026-10-07 23:56:44');

-- --------------------------------------------------------

--
-- Table structure for table `banner`
--

CREATE TABLE `banner` (
  `uuid` char(36) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `gambar` varchar(255) NOT NULL,
  `posisi` enum('slider','pengumuman','infografis','galeri','popup','mitra','lainnya') NOT NULL,
  `tipe` enum('foto','video') NOT NULL DEFAULT 'foto',
  `video_url` varchar(500) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('captcha_5bb2c009825a67ed5350a3d0fa6db553', 'a:6:{i:0;s:1:\"c\";i:1;s:1:\"s\";i:2;s:1:\"9\";i:3;s:1:\"7\";i:4;s:1:\"g\";i:5;s:1:\"t\";}', 1791416441),
('dashboard_20260907_20261007_visitor', 'a:4:{s:12:\"total_visits\";i:9;s:15:\"unique_visitors\";i:6;s:5:\"daily\";a:3:{s:6:\"labels\";a:32:{i:0;s:6:\"07 Sep\";i:1;s:6:\"08 Sep\";i:2;s:6:\"09 Sep\";i:3;s:6:\"10 Sep\";i:4;s:6:\"11 Sep\";i:5;s:6:\"12 Sep\";i:6;s:6:\"13 Sep\";i:7;s:6:\"14 Sep\";i:8;s:6:\"15 Sep\";i:9;s:6:\"16 Sep\";i:10;s:6:\"17 Sep\";i:11;s:6:\"18 Sep\";i:12;s:6:\"19 Sep\";i:13;s:6:\"20 Sep\";i:14;s:6:\"21 Sep\";i:15;s:6:\"22 Sep\";i:16;s:6:\"23 Sep\";i:17;s:6:\"24 Sep\";i:18;s:6:\"25 Sep\";i:19;s:6:\"26 Sep\";i:20;s:6:\"27 Sep\";i:21;s:6:\"28 Sep\";i:22;s:6:\"29 Sep\";i:23;s:6:\"30 Sep\";i:24;s:6:\"01 Oct\";i:25;s:6:\"02 Oct\";i:26;s:6:\"03 Oct\";i:27;s:6:\"04 Oct\";i:28;s:6:\"05 Oct\";i:29;s:6:\"06 Oct\";i:30;s:6:\"07 Oct\";i:31;s:6:\"08 Oct\";}s:5:\"total\";a:32:{i:0;i:0;i:1;i:0;i:2;i:0;i:3;i:0;i:4;i:0;i:5;i:0;i:6;i:0;i:7;i:0;i:8;i:0;i:9;i:0;i:10;i:0;i:11;i:0;i:12;i:0;i:13;i:0;i:14;i:0;i:15;i:0;i:16;i:0;i:17;i:0;i:18;i:0;i:19;i:0;i:20;i:0;i:21;i:0;i:22;i:0;i:23;i:0;i:24;i:0;i:25;i:0;i:26;i:0;i:27;i:0;i:28;i:0;i:29;i:0;i:30;i:0;i:31;i:0;}s:6:\"unique\";a:32:{i:0;i:0;i:1;i:0;i:2;i:0;i:3;i:0;i:4;i:0;i:5;i:0;i:6;i:0;i:7;i:0;i:8;i:0;i:9;i:0;i:10;i:0;i:11;i:0;i:12;i:0;i:13;i:0;i:14;i:0;i:15;i:0;i:16;i:0;i:17;i:0;i:18;i:0;i:19;i:0;i:20;i:0;i:21;i:0;i:22;i:0;i:23;i:0;i:24;i:0;i:25;i:0;i:26;i:0;i:27;i:0;i:28;i:0;i:29;i:0;i:30;i:0;i:31;i:0;}}s:7:\"monthly\";a:3:{s:6:\"labels\";a:2:{i:0;s:8:\"Aug 2026\";i:1;s:8:\"Sep 2026\";}s:5:\"total\";a:2:{i:0;i:8;i:1;i:13;}s:6:\"unique\";a:2:{i:0;i:5;i:1;i:10;}}}', 1791385752),
('dashboard_20260908_20261008_visitor', 'a:4:{s:12:\"total_visits\";i:9;s:15:\"unique_visitors\";i:6;s:5:\"daily\";a:3:{s:6:\"labels\";a:32:{i:0;s:6:\"08 Sep\";i:1;s:6:\"09 Sep\";i:2;s:6:\"10 Sep\";i:3;s:6:\"11 Sep\";i:4;s:6:\"12 Sep\";i:5;s:6:\"13 Sep\";i:6;s:6:\"14 Sep\";i:7;s:6:\"15 Sep\";i:8;s:6:\"16 Sep\";i:9;s:6:\"17 Sep\";i:10;s:6:\"18 Sep\";i:11;s:6:\"19 Sep\";i:12;s:6:\"20 Sep\";i:13;s:6:\"21 Sep\";i:14;s:6:\"22 Sep\";i:15;s:6:\"23 Sep\";i:16;s:6:\"24 Sep\";i:17;s:6:\"25 Sep\";i:18;s:6:\"26 Sep\";i:19;s:6:\"27 Sep\";i:20;s:6:\"28 Sep\";i:21;s:6:\"29 Sep\";i:22;s:6:\"30 Sep\";i:23;s:6:\"01 Oct\";i:24;s:6:\"02 Oct\";i:25;s:6:\"03 Oct\";i:26;s:6:\"04 Oct\";i:27;s:6:\"05 Oct\";i:28;s:6:\"06 Oct\";i:29;s:6:\"07 Oct\";i:30;s:6:\"08 Oct\";i:31;s:6:\"09 Oct\";}s:5:\"total\";a:32:{i:0;i:0;i:1;i:0;i:2;i:0;i:3;i:0;i:4;i:0;i:5;i:0;i:6;i:0;i:7;i:0;i:8;i:0;i:9;i:0;i:10;i:0;i:11;i:0;i:12;i:0;i:13;i:0;i:14;i:0;i:15;i:0;i:16;i:0;i:17;i:0;i:18;i:0;i:19;i:0;i:20;i:0;i:21;i:0;i:22;i:0;i:23;i:0;i:24;i:0;i:25;i:0;i:26;i:0;i:27;i:0;i:28;i:0;i:29;i:0;i:30;i:0;i:31;i:0;}s:6:\"unique\";a:32:{i:0;i:0;i:1;i:0;i:2;i:0;i:3;i:0;i:4;i:0;i:5;i:0;i:6;i:0;i:7;i:0;i:8;i:0;i:9;i:0;i:10;i:0;i:11;i:0;i:12;i:0;i:13;i:0;i:14;i:0;i:15;i:0;i:16;i:0;i:17;i:0;i:18;i:0;i:19;i:0;i:20;i:0;i:21;i:0;i:22;i:0;i:23;i:0;i:24;i:0;i:25;i:0;i:26;i:0;i:27;i:0;i:28;i:0;i:29;i:0;i:30;i:0;i:31;i:0;}}s:7:\"monthly\";a:3:{s:6:\"labels\";a:2:{i:0;s:8:\"Aug 2026\";i:1;s:8:\"Sep 2026\";}s:5:\"total\";a:2:{i:0;i:8;i:1;i:13;}s:6:\"unique\";a:2:{i:0;i:5;i:1;i:10;}}}', 1791418300),
('dashboard_aduan_total_selesai', 'i:0;', 1791417833),
('dashboard_aduan_total_total', 'i:0;', 1791417833),
('dashboard_stats_20260907_20261007', 'a:7:{s:12:\"totalAgendas\";i:1;s:16:\"publishedAgendas\";i:1;s:13:\"totalMessages\";i:0;s:14:\"unreadMessages\";i:0;s:8:\"totalFaq\";i:6;s:10:\"totalPages\";i:2;s:14:\"totalDocuments\";i:0;}', 1791385583),
('dashboard_stats_20260908_20261008', 'a:9:{s:12:\"totalAgendas\";i:1;s:16:\"publishedAgendas\";i:1;s:13:\"totalMessages\";i:0;s:14:\"unreadMessages\";i:0;s:8:\"totalFaq\";i:6;s:10:\"totalPages\";i:2;s:14:\"totalDocuments\";i:0;s:13:\"totalOpdAktif\";i:2;s:11:\"totalGaleri\";i:0;}', 1791418060);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('sidebar_menus_0a091f5a-c510-4110-b2b2-2f992091fb1d_opd', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:9:{i:0;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:4;s:4:\"name\";s:7:\"Dokumen\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:4:\"icon\";s:10:\"bx-receipt\";s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:35:30\";s:10:\"updated_at\";s:19:\"2026-09-16 05:51:58\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:4;s:4:\"name\";s:7:\"Dokumen\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:4:\"icon\";s:10:\"bx-receipt\";s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:35:30\";s:10:\"updated_at\";s:19:\"2026-09-16 05:51:58\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:54;s:4:\"name\";s:13:\"Semua Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:15:\"documents.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"documents.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-13 21:23:49\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:42\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:54;s:4:\"name\";s:13:\"Semua Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:15:\"documents.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"documents.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-13 21:23:49\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:42\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:55;s:4:\"name\";s:17:\"Kategori  Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:25:\"document-categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-13 21:27:33\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:54\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:55;s:4:\"name\";s:17:\"Kategori  Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:25:\"document-categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-13 21:27:33\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:56;s:4:\"name\";s:14:\"Tambah Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:16:\"documents.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"documents.create\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-16 07:39:08\";s:10:\"updated_at\";s:19:\"2026-09-16 07:39:08\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:56;s:4:\"name\";s:14:\"Tambah Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:16:\"documents.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"documents.create\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-16 07:39:08\";s:10:\"updated_at\";s:19:\"2026-09-16 07:39:08\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:7;s:4:\"name\";s:9:\"Publikasi\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"agendas.index\";s:4:\"icon\";s:8:\"bxs-file\";s:8:\"position\";i:7;s:10:\"created_at\";s:19:\"2024-09-29 19:37:06\";s:10:\"updated_at\";s:19:\"2026-10-07 20:55:13\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:7;s:4:\"name\";s:9:\"Publikasi\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"agendas.index\";s:4:\"icon\";s:8:\"bxs-file\";s:8:\"position\";i:7;s:10:\"created_at\";s:19:\"2024-09-29 19:37:06\";s:10:\"updated_at\";s:19:\"2026-10-07 20:55:13\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:9;s:4:\"name\";s:6:\"Agenda\";s:4:\"icon\";N;s:5:\"route\";s:13:\"agendas.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"agendas.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-30 19:08:38\";s:10:\"updated_at\";s:19:\"2026-09-17 08:51:37\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:9;s:4:\"name\";s:6:\"Agenda\";s:4:\"icon\";N;s:5:\"route\";s:13:\"agendas.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"agendas.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-30 19:08:38\";s:10:\"updated_at\";s:19:\"2026-09-17 08:51:37\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:12;s:4:\"name\";s:13:\"Tambah Agenda\";s:4:\"icon\";N;s:5:\"route\";s:14:\"agendas.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"agendas.create\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2025-07-22 19:59:27\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:32\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:12;s:4:\"name\";s:13:\"Tambah Agenda\";s:4:\"icon\";N;s:5:\"route\";s:14:\"agendas.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"agendas.create\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2025-07-22 19:59:27\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:32\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:8;s:4:\"name\";s:8:\"Kategori\";s:4:\"icon\";N;s:5:\"route\";s:16:\"categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"categories.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-29 19:39:24\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:41\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:8;s:4:\"name\";s:8:\"Kategori\";s:4:\"icon\";N;s:5:\"route\";s:16:\"categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"categories.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-29 19:39:24\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:41\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:8;s:4:\"name\";s:12:\"Galeri Media\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:4:\"icon\";s:9:\"bx-camera\";s:8:\"position\";i:8;s:10:\"created_at\";s:19:\"2024-10-14 05:33:06\";s:10:\"updated_at\";s:19:\"2026-10-07 21:22:09\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:8;s:4:\"name\";s:12:\"Galeri Media\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:4:\"icon\";s:9:\"bx-camera\";s:8:\"position\";i:8;s:10:\"created_at\";s:19:\"2024-10-14 05:33:06\";s:10:\"updated_at\";s:19:\"2026-10-07 21:22:09\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:10;s:4:\"name\";s:11:\"Semua Media\";s:4:\"icon\";N;s:5:\"route\";s:12:\"banner.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:13:\"menu_group_id\";i:8;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-10-14 05:38:24\";s:10:\"updated_at\";s:19:\"2026-09-17 12:23:32\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:10;s:4:\"name\";s:11:\"Semua Media\";s:4:\"icon\";N;s:5:\"route\";s:12:\"banner.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:13:\"menu_group_id\";i:8;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-10-14 05:38:24\";s:10:\"updated_at\";s:19:\"2026-09-17 12:23:32\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:26;s:4:\"name\";s:9:\"Pengaduan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:4:\"icon\";s:8:\"bx-phone\";s:8:\"position\";i:9;s:10:\"created_at\";s:19:\"2026-09-19 09:03:39\";s:10:\"updated_at\";s:19:\"2026-09-19 09:03:39\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:26;s:4:\"name\";s:9:\"Pengaduan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:4:\"icon\";s:8:\"bx-phone\";s:8:\"position\";i:9;s:10:\"created_at\";s:19:\"2026-09-19 09:03:39\";s:10:\"updated_at\";s:19:\"2026-09-19 09:03:39\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:63;s:4:\"name\";s:13:\"Riwayat Aduan\";s:4:\"icon\";N;s:5:\"route\";s:12:\"aduans.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:13:\"menu_group_id\";i:26;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-19 09:04:40\";s:10:\"updated_at\";s:19:\"2026-09-19 09:04:40\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:63;s:4:\"name\";s:13:\"Riwayat Aduan\";s:4:\"icon\";N;s:5:\"route\";s:12:\"aduans.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:13:\"menu_group_id\";i:26;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-19 09:04:40\";s:10:\"updated_at\";s:19:\"2026-09-19 09:04:40\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:22;s:4:\"name\";s:14:\"Layanan Publik\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"services.index\";s:4:\"icon\";s:7:\"bx-book\";s:8:\"position\";i:10;s:10:\"created_at\";s:19:\"2026-09-02 22:16:09\";s:10:\"updated_at\";s:19:\"2026-10-07 20:30:20\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:22;s:4:\"name\";s:14:\"Layanan Publik\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"services.index\";s:4:\"icon\";s:7:\"bx-book\";s:8:\"position\";i:10;s:10:\"created_at\";s:19:\"2026-09-02 22:16:09\";s:10:\"updated_at\";s:19:\"2026-10-07 20:30:20\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:46;s:4:\"name\";s:14:\"Daftar Layanan\";s:4:\"icon\";N;s:5:\"route\";s:14:\"services.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"services.index\";s:13:\"menu_group_id\";i:22;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-02 22:18:03\";s:10:\"updated_at\";s:19:\"2026-10-07 20:32:18\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:46;s:4:\"name\";s:14:\"Daftar Layanan\";s:4:\"icon\";N;s:5:\"route\";s:14:\"services.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"services.index\";s:13:\"menu_group_id\";i:22;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-02 22:18:03\";s:10:\"updated_at\";s:19:\"2026-10-07 20:32:18\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:9;s:4:\"name\";s:11:\"Master Data\";s:6:\"status\";i:1;s:15:\"permission_name\";s:9:\"faq.index\";s:4:\"icon\";s:14:\"bx-folder-open\";s:8:\"position\";i:11;s:10:\"created_at\";s:19:\"2025-07-22 00:56:19\";s:10:\"updated_at\";s:19:\"2026-08-31 02:07:27\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:9;s:4:\"name\";s:11:\"Master Data\";s:6:\"status\";i:1;s:15:\"permission_name\";s:9:\"faq.index\";s:4:\"icon\";s:14:\"bx-folder-open\";s:8:\"position\";i:11;s:10:\"created_at\";s:19:\"2025-07-22 00:56:19\";s:10:\"updated_at\";s:19:\"2026-08-31 02:07:27\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:40;s:4:\"name\";s:14:\"Halaman Statis\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"pages.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2025-10-21 10:46:02\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:02\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:40;s:4:\"name\";s:14:\"Halaman Statis\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"pages.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2025-10-21 10:46:02\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:02\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:50;s:4:\"name\";s:7:\"Polling\";s:4:\"icon\";N;s:5:\"route\";s:10:\"poll.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"poll.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-08 06:00:45\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:23\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:50;s:4:\"name\";s:7:\"Polling\";s:4:\"icon\";N;s:5:\"route\";s:10:\"poll.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"poll.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-08 06:00:45\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:23\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:51;s:4:\"name\";s:12:\"Faq & Answer\";s:4:\"icon\";N;s:5:\"route\";s:9:\"faq.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:9:\"faq.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-08 06:04:55\";s:10:\"updated_at\";s:19:\"2026-09-08 06:04:55\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:51;s:4:\"name\";s:12:\"Faq & Answer\";s:4:\"icon\";N;s:5:\"route\";s:9:\"faq.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:9:\"faq.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-08 06:04:55\";s:10:\"updated_at\";s:19:\"2026-09-08 06:04:55\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:6;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:2;s:4:\"name\";s:14:\"Role dan Akses\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"menu.role-permission\";s:4:\"icon\";s:17:\"bx-shield-quarter\";s:8:\"position\";i:12;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:56:50\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:2;s:4:\"name\";s:14:\"Role dan Akses\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"menu.role-permission\";s:4:\"icon\";s:17:\"bx-shield-quarter\";s:8:\"position\";i:12;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:56:50\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:2:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:2;s:4:\"name\";s:11:\"Module Role\";s:4:\"icon\";N;s:5:\"route\";s:16:\"permission.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"permission.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:37\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:2;s:4:\"name\";s:11:\"Module Role\";s:4:\"icon\";N;s:5:\"route\";s:16:\"permission.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"permission.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:37\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:3;s:4:\"name\";s:11:\"Master Role\";s:4:\"icon\";N;s:5:\"route\";s:10:\"role.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"role.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:15\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:3;s:4:\"name\";s:11:\"Master Role\";s:4:\"icon\";N;s:5:\"route\";s:10:\"role.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"role.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:15\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:7;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:3;s:4:\"name\";s:10:\"Pengaturan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"menu-item.index\";s:4:\"icon\";s:6:\"bx-cog\";s:8:\"position\";i:13;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2026-09-17 10:28:38\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:3;s:4:\"name\";s:10:\"Pengaturan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"menu-item.index\";s:4:\"icon\";s:6:\"bx-cog\";s:8:\"position\";i:13;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2026-09-17 10:28:38\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:6:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Daftar Pengguna\";s:4:\"icon\";N;s:5:\"route\";s:10:\"user.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"user.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:39:25\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Daftar Pengguna\";s:4:\"icon\";N;s:5:\"route\";s:10:\"user.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"user.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:39:25\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:5;s:4:\"name\";s:15:\"Module Aplikasi\";s:4:\"icon\";N;s:5:\"route\";s:11:\"route.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"route.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:54\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:5;s:4:\"name\";s:15:\"Module Aplikasi\";s:4:\"icon\";N;s:5:\"route\";s:11:\"route.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"route.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:6;s:4:\"name\";s:12:\"Menu Manager\";s:4:\"icon\";N;s:5:\"route\";s:10:\"menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"menu-group.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:09\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:6;s:4:\"name\";s:12:\"Menu Manager\";s:4:\"icon\";N;s:5:\"route\";s:10:\"menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"menu-group.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:09\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:48;s:4:\"name\";s:11:\"Pesan Masuk\";s:4:\"icon\";N;s:5:\"route\";s:14:\"layanan.kontak\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"layanan.kontak\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-07 02:44:23\";s:10:\"updated_at\";s:19:\"2026-09-17 21:13:26\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:48;s:4:\"name\";s:11:\"Pesan Masuk\";s:4:\"icon\";N;s:5:\"route\";s:14:\"layanan.kontak\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"layanan.kontak\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-07 02:44:23\";s:10:\"updated_at\";s:19:\"2026-09-17 21:13:26\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:49;s:4:\"name\";s:12:\"Menu Website\";s:4:\"icon\";N;s:5:\"route\";s:18:\"website-menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"agendas.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-07 03:40:53\";s:10:\"updated_at\";s:19:\"2026-09-17 20:56:47\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:49;s:4:\"name\";s:12:\"Menu Website\";s:4:\"icon\";N;s:5:\"route\";s:18:\"website-menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"agendas.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-07 03:40:53\";s:10:\"updated_at\";s:19:\"2026-09-17 20:56:47\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:62;s:4:\"name\";s:19:\"Konfigurasi Website\";s:4:\"icon\";N;s:5:\"route\";s:21:\"website-identity.edit\";s:6:\"status\";i:1;s:15:\"permission_name\";s:21:\"website-identity.edit\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2026-09-18 10:00:37\";s:10:\"updated_at\";s:19:\"2026-09-18 10:00:37\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:62;s:4:\"name\";s:19:\"Konfigurasi Website\";s:4:\"icon\";N;s:5:\"route\";s:21:\"website-identity.edit\";s:6:\"status\";i:1;s:15:\"permission_name\";s:21:\"website-identity.edit\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2026-09-18 10:00:37\";s:10:\"updated_at\";s:19:\"2026-09-18 10:00:37\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:8;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:24;s:4:\"name\";s:8:\"Keamanan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"menu.keamanan\";s:4:\"icon\";s:15:\"bx-shield-alt-2\";s:8:\"position\";i:14;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:24;s:4:\"name\";s:8:\"Keamanan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"menu.keamanan\";s:4:\"icon\";s:15:\"bx-shield-alt-2\";s:8:\"position\";i:14;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:4:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:57;s:4:\"name\";s:14:\"Login Activity\";s:4:\"icon\";N;s:5:\"route\";s:29:\"security.login-activity.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"login-activity.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:57;s:4:\"name\";s:14:\"Login Activity\";s:4:\"icon\";N;s:5:\"route\";s:29:\"security.login-activity.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"login-activity.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:58;s:4:\"name\";s:9:\"Audit Log\";s:4:\"icon\";N;s:5:\"route\";s:24:\"security.audit-log.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"audit-log.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:58;s:4:\"name\";s:9:\"Audit Log\";s:4:\"icon\";N;s:5:\"route\";s:24:\"security.audit-log.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"audit-log.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:59;s:4:\"name\";s:12:\"Failed Login\";s:4:\"icon\";N;s:5:\"route\";s:27:\"security.failed-login.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:18:\"failed-login.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:59;s:4:\"name\";s:12:\"Failed Login\";s:4:\"icon\";N;s:5:\"route\";s:27:\"security.failed-login.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:18:\"failed-login.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:60;s:4:\"name\";s:12:\"Blokir Login\";s:4:\"icon\";N;s:5:\"route\";s:28:\"security.login-lockout.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:19:\"login-lockout.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-17 10:25:22\";s:10:\"updated_at\";s:19:\"2026-09-17 10:25:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:60;s:4:\"name\";s:12:\"Blokir Login\";s:4:\"icon\";N;s:5:\"route\";s:28:\"security.login-lockout.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:19:\"login-lockout.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-17 10:25:22\";s:10:\"updated_at\";s:19:\"2026-09-17 10:25:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 1791383650);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('sidebar_menus_787b72ea-59d0-4d54-848b-c200bddafdd2_super-admin', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:9:{i:0;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:7;s:4:\"name\";s:9:\"Publikasi\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"agendas.index\";s:4:\"icon\";s:8:\"bxs-file\";s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-29 19:37:06\";s:10:\"updated_at\";s:19:\"2026-10-07 20:55:13\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:7;s:4:\"name\";s:9:\"Publikasi\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"agendas.index\";s:4:\"icon\";s:8:\"bxs-file\";s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-29 19:37:06\";s:10:\"updated_at\";s:19:\"2026-10-07 20:55:13\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:9;s:4:\"name\";s:6:\"Agenda\";s:4:\"icon\";N;s:5:\"route\";s:13:\"agendas.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"agendas.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-30 19:08:38\";s:10:\"updated_at\";s:19:\"2026-09-17 08:51:37\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:9;s:4:\"name\";s:6:\"Agenda\";s:4:\"icon\";N;s:5:\"route\";s:13:\"agendas.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"agendas.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-30 19:08:38\";s:10:\"updated_at\";s:19:\"2026-09-17 08:51:37\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:12;s:4:\"name\";s:13:\"Tambah Agenda\";s:4:\"icon\";N;s:5:\"route\";s:14:\"agendas.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"agendas.create\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2025-07-22 19:59:27\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:32\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:12;s:4:\"name\";s:13:\"Tambah Agenda\";s:4:\"icon\";N;s:5:\"route\";s:14:\"agendas.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"agendas.create\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2025-07-22 19:59:27\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:32\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:8;s:4:\"name\";s:8:\"Kategori\";s:4:\"icon\";N;s:5:\"route\";s:16:\"categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"categories.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-29 19:39:24\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:41\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:8;s:4:\"name\";s:8:\"Kategori\";s:4:\"icon\";N;s:5:\"route\";s:16:\"categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"categories.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-29 19:39:24\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:41\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:8;s:4:\"name\";s:12:\"Galeri Media\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:4:\"icon\";s:9:\"bx-camera\";s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-10-14 05:33:06\";s:10:\"updated_at\";s:19:\"2026-10-07 21:22:09\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:8;s:4:\"name\";s:12:\"Galeri Media\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:4:\"icon\";s:9:\"bx-camera\";s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-10-14 05:33:06\";s:10:\"updated_at\";s:19:\"2026-10-07 21:22:09\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:10;s:4:\"name\";s:11:\"Semua Media\";s:4:\"icon\";N;s:5:\"route\";s:12:\"banner.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:13:\"menu_group_id\";i:8;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-10-14 05:38:24\";s:10:\"updated_at\";s:19:\"2026-09-17 12:23:32\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:10;s:4:\"name\";s:11:\"Semua Media\";s:4:\"icon\";N;s:5:\"route\";s:12:\"banner.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:13:\"menu_group_id\";i:8;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-10-14 05:38:24\";s:10:\"updated_at\";s:19:\"2026-09-17 12:23:32\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:4;s:4:\"name\";s:7:\"Dokumen\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:4:\"icon\";s:10:\"bx-receipt\";s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2024-09-27 06:35:30\";s:10:\"updated_at\";s:19:\"2026-09-16 05:51:58\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:4;s:4:\"name\";s:7:\"Dokumen\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:4:\"icon\";s:10:\"bx-receipt\";s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2024-09-27 06:35:30\";s:10:\"updated_at\";s:19:\"2026-09-16 05:51:58\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:54;s:4:\"name\";s:13:\"Semua Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:15:\"documents.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"documents.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-13 21:23:49\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:42\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:54;s:4:\"name\";s:13:\"Semua Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:15:\"documents.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"documents.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-13 21:23:49\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:42\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:55;s:4:\"name\";s:17:\"Kategori  Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:25:\"document-categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-13 21:27:33\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:54\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:55;s:4:\"name\";s:17:\"Kategori  Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:25:\"document-categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-13 21:27:33\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:56;s:4:\"name\";s:14:\"Tambah Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:16:\"documents.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"documents.create\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-16 07:39:08\";s:10:\"updated_at\";s:19:\"2026-09-16 07:39:08\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:56;s:4:\"name\";s:14:\"Tambah Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:16:\"documents.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"documents.create\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-16 07:39:08\";s:10:\"updated_at\";s:19:\"2026-09-16 07:39:08\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:22;s:4:\"name\";s:14:\"Layanan Publik\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"services.index\";s:4:\"icon\";s:7:\"bx-book\";s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2026-09-02 22:16:09\";s:10:\"updated_at\";s:19:\"2026-10-07 20:30:20\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:22;s:4:\"name\";s:14:\"Layanan Publik\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"services.index\";s:4:\"icon\";s:7:\"bx-book\";s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2026-09-02 22:16:09\";s:10:\"updated_at\";s:19:\"2026-10-07 20:30:20\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:46;s:4:\"name\";s:14:\"Daftar Layanan\";s:4:\"icon\";N;s:5:\"route\";s:14:\"services.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"services.index\";s:13:\"menu_group_id\";i:22;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-02 22:18:03\";s:10:\"updated_at\";s:19:\"2026-10-07 20:32:18\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:46;s:4:\"name\";s:14:\"Daftar Layanan\";s:4:\"icon\";N;s:5:\"route\";s:14:\"services.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"services.index\";s:13:\"menu_group_id\";i:22;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-02 22:18:03\";s:10:\"updated_at\";s:19:\"2026-10-07 20:32:18\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:26;s:4:\"name\";s:9:\"Pengaduan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:4:\"icon\";s:8:\"bx-phone\";s:8:\"position\";i:7;s:10:\"created_at\";s:19:\"2026-09-19 09:03:39\";s:10:\"updated_at\";s:19:\"2026-09-19 09:03:39\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:26;s:4:\"name\";s:9:\"Pengaduan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:4:\"icon\";s:8:\"bx-phone\";s:8:\"position\";i:7;s:10:\"created_at\";s:19:\"2026-09-19 09:03:39\";s:10:\"updated_at\";s:19:\"2026-09-19 09:03:39\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:63;s:4:\"name\";s:13:\"Riwayat Aduan\";s:4:\"icon\";N;s:5:\"route\";s:12:\"aduans.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:13:\"menu_group_id\";i:26;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-19 09:04:40\";s:10:\"updated_at\";s:19:\"2026-09-19 09:04:40\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:63;s:4:\"name\";s:13:\"Riwayat Aduan\";s:4:\"icon\";N;s:5:\"route\";s:12:\"aduans.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:13:\"menu_group_id\";i:26;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-19 09:04:40\";s:10:\"updated_at\";s:19:\"2026-09-19 09:04:40\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:9;s:4:\"name\";s:11:\"Master Data\";s:6:\"status\";i:1;s:15:\"permission_name\";s:9:\"faq.index\";s:4:\"icon\";s:14:\"bx-folder-open\";s:8:\"position\";i:8;s:10:\"created_at\";s:19:\"2025-07-22 00:56:19\";s:10:\"updated_at\";s:19:\"2026-08-31 02:07:27\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:9;s:4:\"name\";s:11:\"Master Data\";s:6:\"status\";i:1;s:15:\"permission_name\";s:9:\"faq.index\";s:4:\"icon\";s:14:\"bx-folder-open\";s:8:\"position\";i:8;s:10:\"created_at\";s:19:\"2025-07-22 00:56:19\";s:10:\"updated_at\";s:19:\"2026-08-31 02:07:27\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:40;s:4:\"name\";s:14:\"Halaman Statis\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"pages.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2025-10-21 10:46:02\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:02\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:40;s:4:\"name\";s:14:\"Halaman Statis\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"pages.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2025-10-21 10:46:02\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:02\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:50;s:4:\"name\";s:7:\"Polling\";s:4:\"icon\";N;s:5:\"route\";s:10:\"poll.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"poll.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-08 06:00:45\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:23\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:50;s:4:\"name\";s:7:\"Polling\";s:4:\"icon\";N;s:5:\"route\";s:10:\"poll.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"poll.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-08 06:00:45\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:23\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:51;s:4:\"name\";s:12:\"Faq & Answer\";s:4:\"icon\";N;s:5:\"route\";s:9:\"faq.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:9:\"faq.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-08 06:04:55\";s:10:\"updated_at\";s:19:\"2026-09-08 06:04:55\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:51;s:4:\"name\";s:12:\"Faq & Answer\";s:4:\"icon\";N;s:5:\"route\";s:9:\"faq.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:9:\"faq.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-08 06:04:55\";s:10:\"updated_at\";s:19:\"2026-09-08 06:04:55\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:6;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:2;s:4:\"name\";s:14:\"Role dan Akses\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"menu.role-permission\";s:4:\"icon\";s:17:\"bx-shield-quarter\";s:8:\"position\";i:9;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:56:50\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:2;s:4:\"name\";s:14:\"Role dan Akses\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"menu.role-permission\";s:4:\"icon\";s:17:\"bx-shield-quarter\";s:8:\"position\";i:9;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:56:50\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:2:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:2;s:4:\"name\";s:11:\"Module Role\";s:4:\"icon\";N;s:5:\"route\";s:16:\"permission.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"permission.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:37\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:2;s:4:\"name\";s:11:\"Module Role\";s:4:\"icon\";N;s:5:\"route\";s:16:\"permission.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"permission.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:37\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:3;s:4:\"name\";s:11:\"Master Role\";s:4:\"icon\";N;s:5:\"route\";s:10:\"role.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"role.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:15\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:3;s:4:\"name\";s:11:\"Master Role\";s:4:\"icon\";N;s:5:\"route\";s:10:\"role.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"role.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:15\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:7;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:3;s:4:\"name\";s:10:\"Pengaturan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"menu-item.index\";s:4:\"icon\";s:6:\"bx-cog\";s:8:\"position\";i:10;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2026-09-17 10:28:38\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:3;s:4:\"name\";s:10:\"Pengaturan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"menu-item.index\";s:4:\"icon\";s:6:\"bx-cog\";s:8:\"position\";i:10;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2026-09-17 10:28:38\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:6:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Daftar Pengguna\";s:4:\"icon\";N;s:5:\"route\";s:10:\"user.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"user.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:39:25\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Daftar Pengguna\";s:4:\"icon\";N;s:5:\"route\";s:10:\"user.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"user.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:39:25\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:5;s:4:\"name\";s:15:\"Module Aplikasi\";s:4:\"icon\";N;s:5:\"route\";s:11:\"route.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"route.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:54\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:5;s:4:\"name\";s:15:\"Module Aplikasi\";s:4:\"icon\";N;s:5:\"route\";s:11:\"route.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"route.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:6;s:4:\"name\";s:12:\"Menu Manager\";s:4:\"icon\";N;s:5:\"route\";s:10:\"menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"menu-group.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:09\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:6;s:4:\"name\";s:12:\"Menu Manager\";s:4:\"icon\";N;s:5:\"route\";s:10:\"menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"menu-group.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:09\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:48;s:4:\"name\";s:11:\"Pesan Masuk\";s:4:\"icon\";N;s:5:\"route\";s:14:\"layanan.kontak\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"layanan.kontak\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-07 02:44:23\";s:10:\"updated_at\";s:19:\"2026-09-17 21:13:26\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:48;s:4:\"name\";s:11:\"Pesan Masuk\";s:4:\"icon\";N;s:5:\"route\";s:14:\"layanan.kontak\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"layanan.kontak\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-07 02:44:23\";s:10:\"updated_at\";s:19:\"2026-09-17 21:13:26\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:49;s:4:\"name\";s:12:\"Menu Website\";s:4:\"icon\";N;s:5:\"route\";s:18:\"website-menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"agendas.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-07 03:40:53\";s:10:\"updated_at\";s:19:\"2026-09-17 20:56:47\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:49;s:4:\"name\";s:12:\"Menu Website\";s:4:\"icon\";N;s:5:\"route\";s:18:\"website-menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"agendas.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-07 03:40:53\";s:10:\"updated_at\";s:19:\"2026-09-17 20:56:47\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:62;s:4:\"name\";s:19:\"Konfigurasi Website\";s:4:\"icon\";N;s:5:\"route\";s:21:\"website-identity.edit\";s:6:\"status\";i:1;s:15:\"permission_name\";s:21:\"website-identity.edit\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2026-09-18 10:00:37\";s:10:\"updated_at\";s:19:\"2026-09-18 10:00:37\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:62;s:4:\"name\";s:19:\"Konfigurasi Website\";s:4:\"icon\";N;s:5:\"route\";s:21:\"website-identity.edit\";s:6:\"status\";i:1;s:15:\"permission_name\";s:21:\"website-identity.edit\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2026-09-18 10:00:37\";s:10:\"updated_at\";s:19:\"2026-09-18 10:00:37\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:8;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:24;s:4:\"name\";s:8:\"Keamanan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"menu.keamanan\";s:4:\"icon\";s:15:\"bx-shield-alt-2\";s:8:\"position\";i:11;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:24;s:4:\"name\";s:8:\"Keamanan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"menu.keamanan\";s:4:\"icon\";s:15:\"bx-shield-alt-2\";s:8:\"position\";i:11;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:4:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:57;s:4:\"name\";s:14:\"Login Activity\";s:4:\"icon\";N;s:5:\"route\";s:29:\"security.login-activity.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"login-activity.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:57;s:4:\"name\";s:14:\"Login Activity\";s:4:\"icon\";N;s:5:\"route\";s:29:\"security.login-activity.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"login-activity.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:58;s:4:\"name\";s:9:\"Audit Log\";s:4:\"icon\";N;s:5:\"route\";s:24:\"security.audit-log.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"audit-log.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:58;s:4:\"name\";s:9:\"Audit Log\";s:4:\"icon\";N;s:5:\"route\";s:24:\"security.audit-log.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"audit-log.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:59;s:4:\"name\";s:12:\"Failed Login\";s:4:\"icon\";N;s:5:\"route\";s:27:\"security.failed-login.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:18:\"failed-login.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:59;s:4:\"name\";s:12:\"Failed Login\";s:4:\"icon\";N;s:5:\"route\";s:27:\"security.failed-login.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:18:\"failed-login.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:60;s:4:\"name\";s:12:\"Blokir Login\";s:4:\"icon\";N;s:5:\"route\";s:28:\"security.login-lockout.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:19:\"login-lockout.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-17 10:25:22\";s:10:\"updated_at\";s:19:\"2026-09-17 10:25:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:60;s:4:\"name\";s:12:\"Blokir Login\";s:4:\"icon\";N;s:5:\"route\";s:28:\"security.login-lockout.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:19:\"login-lockout.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-17 10:25:22\";s:10:\"updated_at\";s:19:\"2026-09-17 10:25:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 1791418301);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('spatie.permission.cache', 'a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:109:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:14:\"menu.main-menu\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:20:\"menu.role-permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:22:\"menu.access-management\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:15:\"dashboard.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:10:\"user.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:10:\"user.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:11:\"user.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:12:\"user.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:8;a:4:{s:1:\"a\";i:9;s:1:\"b\";s:16:\"menu-group.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:16:\"menu-group.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:17:\"menu-group.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:18:\"menu-group.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:15:\"menu-item.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:15:\"menu-item.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:16:\"menu-item.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:17:\"menu-item.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:11:\"route.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:11:\"route.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:12:\"route.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:13:\"route.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:10:\"role.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:10:\"role.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:11:\"role.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:12:\"role.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:16:\"permission.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:16:\"permission.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:17:\"permission.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:18:\"permission.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:11:\"faq.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:29;a:4:{s:1:\"a\";i:30;s:1:\"b\";s:9:\"faq.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:9:\"faq.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:31;a:4:{s:1:\"a\";i:32;s:1:\"b\";s:10:\"faq.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:32;a:4:{s:1:\"a\";i:33;s:1:\"b\";s:20:\"menu.main-portofolio\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:33;a:4:{s:1:\"a\";i:38;s:1:\"b\";s:18:\"categories.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:34;a:4:{s:1:\"a\";i:39;s:1:\"b\";s:16:\"categories.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:35;a:4:{s:1:\"a\";i:40;s:1:\"b\";s:16:\"categories.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:36;a:4:{s:1:\"a\";i:41;s:1:\"b\";s:17:\"categories.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:37;a:4:{s:1:\"a\";i:46;s:1:\"b\";s:14:\"banner.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:38;a:4:{s:1:\"a\";i:47;s:1:\"b\";s:12:\"banner.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:39;a:4:{s:1:\"a\";i:48;s:1:\"b\";s:12:\"banner.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:40;a:4:{s:1:\"a\";i:49;s:1:\"b\";s:13:\"banner.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:41;a:4:{s:1:\"a\";i:50;s:1:\"b\";s:15:\"agendas.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:42;a:4:{s:1:\"a\";i:51;s:1:\"b\";s:14:\"agendas.create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:43;a:4:{s:1:\"a\";i:52;s:1:\"b\";s:13:\"agendas.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:44;a:4:{s:1:\"a\";i:53;s:1:\"b\";s:13:\"agendas.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:45;a:4:{s:1:\"a\";i:54;s:1:\"b\";s:14:\"agendas.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:46;a:4:{s:1:\"a\";i:55;s:1:\"b\";s:14:\"dashboard.form\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:47;a:4:{s:1:\"a\";i:60;s:1:\"b\";s:12:\"poll.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:48;a:4:{s:1:\"a\";i:65;s:1:\"b\";s:10:\"poll.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:49;a:4:{s:1:\"a\";i:70;s:1:\"b\";s:10:\"poll.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:50;a:4:{s:1:\"a\";i:75;s:1:\"b\";s:11:\"poll.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:51;a:4:{s:1:\"a\";i:85;s:1:\"b\";s:13:\"account.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:52;a:4:{s:1:\"a\";i:90;s:1:\"b\";s:14:\"account.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:53;a:4:{s:1:\"a\";i:125;s:1:\"b\";s:27:\"document-categories.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:54;a:4:{s:1:\"a\";i:130;s:1:\"b\";s:25:\"document-categories.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:55;a:4:{s:1:\"a\";i:135;s:1:\"b\";s:25:\"document-categories.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:56;a:4:{s:1:\"a\";i:140;s:1:\"b\";s:26:\"document-categories.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:57;a:4:{s:1:\"a\";i:145;s:1:\"b\";s:14:\"layanan.kontak\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:58;a:4:{s:1:\"a\";i:147;s:1:\"b\";s:12:\"pages.create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:59;a:4:{s:1:\"a\";i:148;s:1:\"b\";s:13:\"pages.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:60;a:4:{s:1:\"a\";i:149;s:1:\"b\";s:11:\"pages.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:61;a:4:{s:1:\"a\";i:150;s:1:\"b\";s:11:\"pages.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:62;a:4:{s:1:\"a\";i:151;s:1:\"b\";s:12:\"pages.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:63;a:4:{s:1:\"a\";i:163;s:1:\"b\";s:14:\"services.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:64;a:4:{s:1:\"a\";i:164;s:1:\"b\";s:16:\"services.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:65;a:4:{s:1:\"a\";i:165;s:1:\"b\";s:15:\"services.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:66;a:4:{s:1:\"a\";i:166;s:1:\"b\";s:14:\"services.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:67;a:4:{s:1:\"a\";i:172;s:1:\"b\";s:15:\"classes.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:68;a:4:{s:1:\"a\";i:173;s:1:\"b\";s:13:\"classes.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:69;a:4:{s:1:\"a\";i:174;s:1:\"b\";s:13:\"classes.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:70;a:4:{s:1:\"a\";i:175;s:1:\"b\";s:14:\"classes.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:71;a:4:{s:1:\"a\";i:176;s:1:\"b\";s:22:\"dashboard.submitSumber\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:2;}}i:72;a:4:{s:1:\"a\";i:177;s:1:\"b\";s:14:\"classes.create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:73;a:4:{s:1:\"a\";i:178;s:1:\"b\";s:12:\"classes.edit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:74;a:4:{s:1:\"a\";i:185;s:1:\"b\";s:14:\"pengguna.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:75;a:4:{s:1:\"a\";i:186;s:1:\"b\";s:15:\"pengguna.export\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:76;a:4:{s:1:\"a\";i:187;s:1:\"b\";s:15:\"documents.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:77;a:4:{s:1:\"a\";i:188;s:1:\"b\";s:17:\"documents.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:78;a:4:{s:1:\"a\";i:189;s:1:\"b\";s:16:\"documents.create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:79;a:4:{s:1:\"a\";i:190;s:1:\"b\";s:15:\"documents.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:80;a:4:{s:1:\"a\";i:191;s:1:\"b\";s:16:\"documents.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:81;a:4:{s:1:\"a\";i:197;s:1:\"b\";s:13:\"menu.keamanan\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:82;a:4:{s:1:\"a\";i:198;s:1:\"b\";s:20:\"login-activity.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:83;a:4:{s:1:\"a\";i:199;s:1:\"b\";s:22:\"login-activity.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:84;a:4:{s:1:\"a\";i:200;s:1:\"b\";s:15:\"audit-log.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:85;a:4:{s:1:\"a\";i:201;s:1:\"b\";s:17:\"audit-log.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:86;a:4:{s:1:\"a\";i:202;s:1:\"b\";s:18:\"failed-login.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:87;a:4:{s:1:\"a\";i:203;s:1:\"b\";s:20:\"failed-login.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:88;a:4:{s:1:\"a\";i:204;s:1:\"b\";s:19:\"login-lockout.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:89;a:4:{s:1:\"a\";i:205;s:1:\"b\";s:21:\"login-lockout.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:90;a:4:{s:1:\"a\";i:206;s:1:\"b\";s:21:\"website-identity.edit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:91;a:4:{s:1:\"a\";i:207;s:1:\"b\";s:23:\"website-identity.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:92;a:4:{s:1:\"a\";i:208;s:1:\"b\";s:19:\"menu.website-config\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:93;a:4:{s:1:\"a\";i:209;s:1:\"b\";s:12:\"aduans.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:94;a:4:{s:1:\"a\";i:210;s:1:\"b\";s:12:\"aduans.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:95;a:4:{s:1:\"a\";i:211;s:1:\"b\";s:11:\"aduans.show\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:96;a:4:{s:1:\"a\";i:212;s:1:\"b\";s:13:\"aduans.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:97;a:4:{s:1:\"a\";i:213;s:1:\"b\";s:14:\"aduans.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:98;a:4:{s:1:\"a\";i:214;s:1:\"b\";s:13:\"aduans.create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:99;a:4:{s:1:\"a\";i:215;s:1:\"b\";s:11:\"aduans.edit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:100;a:4:{s:1:\"a\";i:216;s:1:\"b\";s:14:\"aduans.restore\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:101;a:4:{s:1:\"a\";i:217;s:1:\"b\";s:18:\"aduans.forceDelete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:102;a:4:{s:1:\"a\";i:218;s:1:\"b\";s:25:\"aduans.tindaklanjut.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:103;a:4:{s:1:\"a\";i:219;s:1:\"b\";s:27:\"aduans.tindaklanjut.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:104;a:4:{s:1:\"a\";i:220;s:1:\"b\";s:13:\"aduans.export\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:105;a:4:{s:1:\"a\";i:221;s:1:\"b\";s:12:\"aduans.arsip\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:106;a:4:{s:1:\"a\";i:222;s:1:\"b\";s:17:\"aduans.batalArsip\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:107;a:4:{s:1:\"a\";i:223;s:1:\"b\";s:11:\"health.page\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:108;a:4:{s:1:\"a\";i:224;s:1:\"b\";s:15:\"agendas.approve\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}}s:5:\"roles\";a:4:{i:0;a:3:{s:1:\"a\";i:1;s:1:\"b\";s:11:\"super-admin\";s:1:\"c\";s:3:\"web\";}i:1;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:5:\"admin\";s:1:\"c\";s:3:\"web\";}i:2;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:4:\"user\";s:1:\"c\";s:3:\"web\";}i:3;a:3:{s:1:\"a\";i:5;s:1:\"b\";s:3:\"opd\";s:1:\"c\";s:3:\"web\";}}}', 1791469453),
('visitor_buffer_2026-10-07 21:31', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:35:\"http://127.0.0.1:8000/notifications\";s:3:\"ref\";s:37:\"http://127.0.0.1:8000/backend/agendas\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"21:31:22\";}}', 1791384082),
('visitor_buffer_2026-10-07 21:31_count', 'i:1;', 1791384082),
('visitor_buffer_2026-10-07 21:32', 'a:4:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:35:\"http://127.0.0.1:8000/notifications\";s:3:\"ref\";s:37:\"http://127.0.0.1:8000/backend/agendas\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"21:32:23\";}i:1;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:49:\"http://127.0.0.1:8000/notifications?filter=unread\";s:3:\"ref\";s:35:\"http://127.0.0.1:8000/notifications\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"21:32:27\";}i:2;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:35:\"http://127.0.0.1:8000/notifications\";s:3:\"ref\";s:49:\"http://127.0.0.1:8000/notifications?filter=unread\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"21:32:34\";}i:3;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:35:\"http://127.0.0.1:8000/notifications\";s:3:\"ref\";s:49:\"http://127.0.0.1:8000/notifications?filter=unread\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"21:32:54\";}}', 1791384174),
('visitor_buffer_2026-10-07 21:32_count', 'i:4;', 1791384174),
('visitor_buffer_2026-10-07 21:33', 'a:2:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:35:\"http://127.0.0.1:8000/notifications\";s:3:\"ref\";s:49:\"http://127.0.0.1:8000/notifications?filter=unread\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"21:33:25\";}i:1;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:35:\"http://127.0.0.1:8000/notifications\";s:3:\"ref\";s:49:\"http://127.0.0.1:8000/notifications?filter=unread\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"21:33:32\";}}', 1791384212),
('visitor_buffer_2026-10-07 21:33_count', 'i:2;', 1791384212),
('visitor_buffer_2026-10-07 21:34', 'a:3:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:35:\"http://127.0.0.1:8000/notifications\";s:3:\"ref\";s:49:\"http://127.0.0.1:8000/notifications?filter=unread\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"21:34:36\";}i:1;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:35:\"http://127.0.0.1:8000/notifications\";s:3:\"ref\";s:49:\"http://127.0.0.1:8000/notifications?filter=unread\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"21:34:41\";}i:2;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:35:\"http://127.0.0.1:8000/notifications\";s:3:\"ref\";s:49:\"http://127.0.0.1:8000/notifications?filter=unread\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"21:34:53\";}}', 1791384293),
('visitor_buffer_2026-10-07 21:34_count', 'i:3;', 1791384293),
('visitor_buffer_2026-10-07 21:35', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:35:\"http://127.0.0.1:8000/notifications\";s:3:\"ref\";s:49:\"http://127.0.0.1:8000/notifications?filter=unread\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"21:35:43\";}}', 1791384343),
('visitor_buffer_2026-10-07 21:35_count', 'i:1;', 1791384343),
('visitor_buffer_2026-10-07 21:36', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:35:\"http://127.0.0.1:8000/notifications\";s:3:\"ref\";s:49:\"http://127.0.0.1:8000/notifications?filter=unread\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"21:36:41\";}}', 1791384401),
('visitor_buffer_2026-10-07 21:36_count', 'i:1;', 1791384401),
('visitor_buffer_2026-10-07 21:39', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:35:\"http://127.0.0.1:8000/notifications\";s:3:\"ref\";s:49:\"http://127.0.0.1:8000/notifications?filter=unread\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"21:39:01\";}}', 1791384541),
('visitor_buffer_2026-10-07 21:39_count', 'i:1;', 1791384541),
('visitor_buffer_2026-10-07 22:00', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:29:\"http://127.0.0.1:8000/profile\";s:3:\"ref\";s:39:\"http://127.0.0.1:8000/backend/dashboard\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"22:00:20\";}}', 1791385820),
('visitor_buffer_2026-10-07 22:00_count', 'i:1;', 1791385820),
('visitor_buffer_2026-10-08 06:22', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://127.0.0.1:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://127.0.0.1:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"06:22:34\";}}', 1791415954),
('visitor_buffer_2026-10-08 06:22_count', 'i:1;', 1791415954),
('visitor_buffer_2026-10-08 06:39', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://127.0.0.1:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://127.0.0.1:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"06:39:42\";}}', 1791416982),
('visitor_buffer_2026-10-08 06:39_count', 'i:1;', 1791416982),
('visitor_buffer_2026-10-08 06:45', 'a:2:{i:0;a:8:{s:2:\"ip\";s:3:\"::1\";s:2:\"ua\";s:11:\"curl/8.21.0\";s:3:\"url\";s:33:\"http://localhost/agenda/be/public\";s:3:\"ref\";N;s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:5:\"Other\";s:2:\"os\";s:5:\"Other\";s:4:\"time\";s:8:\"06:45:03\";}i:1;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:11:\"curl/8.21.0\";s:3:\"url\";s:21:\"http://localhost:8000\";s:3:\"ref\";N;s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:5:\"Other\";s:2:\"os\";s:5:\"Other\";s:4:\"time\";s:8:\"06:45:35\";}}', 1791417335),
('visitor_buffer_2026-10-08 06:45_count', 'i:2;', 1791417335);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `uuid` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`uuid`, `name`, `slug`, `description`, `icon`, `created_at`, `updated_at`) VALUES
('2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemerintahan', 'pemerintahan', 'Agenda resmi yang berkaitan dengan penyelenggaraan pemerintahan dan kebijakan daerah.', 'fa-newspaper', '2025-09-16 01:03:22', '2026-10-07 14:02:07'),
('34103609-8116-4baf-bd17-557fc6989e8e', 'Pelayanan & Masyarakat', 'pelayanan-masyarakat', 'Kegiatan yang berkaitan dengan pelayanan publik dan interaksi langsung dengan masyarakat.', 'fa-screwdriver-wrenc', '2025-09-16 01:03:16', '2026-10-07 14:02:30'),
('72561291-cdcb-484b-a556-0400fbd53c3d', 'Rapat & Koordinasi', 'rapat-koordinasi', 'Rapat, koordinasi, pembahasan, dan kegiatan internal pemerintahan.', 'fa-road', '2025-10-31 03:07:08', '2026-10-07 14:02:50'),
('773cd47c-dc89-4546-b6f0-bfb26f74a0a2', 'Lainnya', 'lainnya', 'Agenda yang tidak termasuk dalam kategori yang tersedia.', NULL, '2026-10-07 14:03:26', '2026-10-07 14:03:26'),
('a58f5ebc-c8ec-48da-b6f9-a80b05ca40a0', 'Acara & Seremonial', 'acara-seremonial', 'Peresmian, upacara, peringatan, pelantikan, dan kegiatan seremonial lainnya.', 'fa-calendar-days', '2026-06-20 12:47:44', '2026-10-07 14:03:08');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `uuid` char(36) NOT NULL,
  `category_uuid` char(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `excerpt` text DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `published_at` date DEFAULT NULL,
  `file` varchar(255) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_categories`
--

CREATE TABLE `document_categories` (
  `uuid` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `document_categories`
--

INSERT INTO `document_categories` (`uuid`, `name`, `slug`, `description`, `status`, `created_at`, `updated_at`) VALUES
('01a9274f-003b-4ebc-b62a-b22f1091afd5', 'Materi Agenda', 'materi-agenda', 'Materi, paparan, atau bahan yang digunakan dalam agenda.', 'active', '2026-09-15 16:14:43', '2026-10-07 14:51:35'),
('9c0c6f74-224c-4af9-b1cf-dd9d46a8c685', 'Laporan', 'laporan', 'Laporan pelaksanaan atau dokumentasi hasil kegiatan.', 'active', '2026-09-15 16:14:05', '2026-10-07 14:52:06'),
('a6d14f40-5032-40dc-9ef2-349d4300636f', 'Undangan', 'undangan', 'Dokumen undangan untuk agenda atau kegiatan pemerintah.', 'active', '2026-09-20 13:02:23', '2026-10-07 14:51:04'),
('b8d57474-3500-4caa-8d20-a3f1141c47e6', 'Dokumen Pendukung', 'dokumen-pendukung', 'Dokumen lain yang berkaitan dengan agenda.', 'active', '2026-09-15 16:13:55', '2026-10-07 14:52:24'),
('d5394429-10b1-4222-86b4-68c6da8dfe0d', 'Hasil Kegiatan', 'hasil-kegiatan', 'Berita acara, notulen, atau hasil dari pelaksanaan agenda.', 'active', '2026-09-15 16:14:28', '2026-10-07 14:51:50');

-- --------------------------------------------------------

--
-- Table structure for table `document_versions`
--

CREATE TABLE `document_versions` (
  `uuid` char(36) NOT NULL,
  `document_uuid` char(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `file` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `user_uuid` char(36) DEFAULT NULL,
  `versi` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_logins`
--

CREATE TABLE `failed_logins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `user_uuid` char(36) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `attempted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `failed_logins`
--

INSERT INTO `failed_logins` (`id`, `email`, `user_uuid`, `ip_address`, `user_agent`, `reason`, `attempted_at`, `created_at`, `updated_at`) VALUES
(17, 'tapayoga@yogaroots.id', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'credentials', '2026-09-17 21:34:34', '2026-09-17 21:34:34', '2026-09-17 21:34:34'),
(18, 'tapayoga@yogaroots.id', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'credentials', '2026-09-17 21:34:34', '2026-09-17 21:34:34', '2026-09-17 21:34:34'),
(19, 'super@admin.com', '787b72ea-59d0-4d54-848b-c200bddafdd2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'credentials', '2026-09-18 02:05:58', '2026-09-18 02:05:58', '2026-09-18 02:05:58'),
(20, 'super@admin.com', '787b72ea-59d0-4d54-848b-c200bddafdd2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'credentials', '2026-09-18 02:05:58', '2026-09-18 02:05:58', '2026-09-18 02:05:58'),
(42, 'super@admin.com', '787b72ea-59d0-4d54-848b-c200bddafdd2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'credentials', '2026-09-18 22:47:18', '2026-09-18 22:47:18', '2026-09-18 22:47:18'),
(43, 'superadmin@gmail.com', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'credentials', '2026-09-18 22:48:32', '2026-09-18 22:48:32', '2026-09-18 22:48:32'),
(44, 'tapayoga@yogaroots.id', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'credentials', '2026-09-18 22:51:01', '2026-09-18 22:51:01', '2026-09-18 22:51:01'),
(45, 'bekasikotakotabekasi2018@gmail.com', '9c513953-32d1-4415-a921-8a6baf246d44', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'credentials', '2026-09-20 11:22:10', '2026-09-20 11:22:10', '2026-09-20 11:22:10');

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `uuid` char(36) NOT NULL,
  `pertanyaan` varchar(255) NOT NULL,
  `jawaban` text NOT NULL,
  `kategori` enum('informasi-umum','layanan','infrastruktur-pemeliharaan','pengaduan-permohonan','program-kegiatan') DEFAULT NULL,
  `urutan` int(11) NOT NULL DEFAULT 0,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`uuid`, `pertanyaan`, `jawaban`, `kategori`, `urutan`, `status`, `created_at`, `updated_at`) VALUES
('4b9411a3-ccc5-44fd-bc24-e8dc7065773c', 'What should I bring to class?', 'Wear comfortable clothes that allow you to move freely. Bring a water bottle and your own yoga mat if needed.', NULL, 2, 'active', '2025-09-17 20:19:23', '2026-09-10 17:00:55'),
('6bb623f8-916a-436b-85b3-a57035fe5ac5', 'How often should I practice yoga?', 'It depends on your goals and routine. For most people, practicing 2–3 times a week is a great way to build consistency while giving your body enough time to rest.', NULL, 4, 'active', '2025-09-17 20:20:44', '2026-09-10 17:01:41'),
('95b200f1-69c7-4f1b-a76b-172bcf5fcc55', 'How long is each class?', 'Most Yoga Roots classes run for 60–90 minutes, depending on the type of class. Each session gives you time to move, breathe, and slow down.', NULL, 5, 'active', '2025-09-17 20:21:00', '2026-09-10 17:02:03'),
('9f25d34e-2a60-42cf-8379-ed069dc50ac0', 'How can I join Yoga Roots?', 'Choose the class that feels right for you, select your preferred schedule, and register through our website. We’ll be happy to have you join us.', NULL, 6, 'active', '2026-09-10 17:02:30', '2026-09-10 17:02:30'),
('fa2b17f9-f0d4-4849-8373-8d787b80113e', 'Is Yoga Roots suitable for beginners?', 'Absolutely. Yoga Roots welcomes everyone, whether you’re completely new to yoga or have been practicing for years. Our classes are designed to help you feel comfortable and progress at your own pace.', NULL, 1, 'active', '2025-09-17 20:13:33', '2026-09-10 17:00:36'),
('fd90f57c-53aa-4b5d-8e11-faea4808686d', 'Do I need to be flexible to practice yoga?', 'Not at all. You don’t need to be flexible to start yoga. With regular practice, you’ll gradually build flexibility, strength, balance, and a better connection with your body.', NULL, 3, 'active', '2025-09-17 20:20:22', '2026-09-10 17:01:17');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(1, 'image-optimization', '{\"uuid\":\"3231014d-ea90-4cda-acd5-d2cce7b89c63\",\"displayName\":\"App\\\\Jobs\\\\OptimizeImageJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":\"30\",\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\OptimizeImageJob\",\"command\":\"O:25:\\\"App\\\\Jobs\\\\OptimizeImageJob\\\":3:{s:4:\\\"path\\\";s:51:\\\"images\\/4vWMjOtHfGlFugvZ84preK7RAnVcqHFGWUIjJaeD.png\\\";s:4:\\\"disk\\\";s:6:\\\"public\\\";s:5:\\\"queue\\\";s:18:\\\"image-optimization\\\";}\",\"batchId\":null},\"createdAt\":1789903175,\"delay\":null}', 0, NULL, 1789903175, 1789903175),
(2, 'default', '{\"uuid\":\"a474ffb0-525a-4e0c-a6ab-9e2be171a3b7\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"command\":\"O:33:\\\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Article\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"a4ce109d-88de-423a-bb26-d11087f68a29\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1789903175,\"delay\":null}', 0, NULL, 1789903175, 1789903175),
(3, 'default', '{\"uuid\":\"7ac5953b-91b2-4673-8b88-5cbf7617df14\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\RemoveFromSearch\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\RemoveFromSearch\",\"command\":\"O:35:\\\"Laravel\\\\Scout\\\\Jobs\\\\RemoveFromSearch\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Article\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"a4ce109d-88de-423a-bb26-d11087f68a29\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";s:44:\\\"Laravel\\\\Scout\\\\Jobs\\\\RemoveableScoutCollection\\\";}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1789906097,\"delay\":null}', 0, NULL, 1789906097, 1789906097),
(4, 'default', '{\"uuid\":\"7eb4f152-027e-45d0-b5a2-56ad397d6413\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"command\":\"O:33:\\\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Article\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"2fa27e87-b4b5-4224-900d-26e44764d1e4\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1789906165,\"delay\":null}', 0, NULL, 1789906165, 1789906165),
(5, 'image-optimization', '{\"uuid\":\"a2f6b386-baad-49e1-bdbe-7d56bc674c7f\",\"displayName\":\"App\\\\Jobs\\\\OptimizeImageJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":\"30\",\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\OptimizeImageJob\",\"command\":\"O:25:\\\"App\\\\Jobs\\\\OptimizeImageJob\\\":3:{s:4:\\\"path\\\";s:51:\\\"images\\/j6y3qSWN6dYvXjXiE41yWMTz0Z53cyxzaJD6YQWm.png\\\";s:4:\\\"disk\\\";s:6:\\\"public\\\";s:5:\\\"queue\\\";s:18:\\\"image-optimization\\\";}\",\"batchId\":null},\"createdAt\":1789906217,\"delay\":null}', 0, NULL, 1789906217, 1789906217),
(6, 'default', '{\"uuid\":\"648191fa-b036-4ca0-92ae-ce12fdd85b9c\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"command\":\"O:33:\\\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Article\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"2fa27e87-b4b5-4224-900d-26e44764d1e4\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1789906217,\"delay\":null}', 0, NULL, 1789906217, 1789906217),
(7, 'image-optimization', '{\"uuid\":\"9f9b0cb6-bf80-4d13-844c-77233b99ee3c\",\"displayName\":\"App\\\\Jobs\\\\OptimizeImageJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":\"30\",\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\OptimizeImageJob\",\"command\":\"O:25:\\\"App\\\\Jobs\\\\OptimizeImageJob\\\":3:{s:4:\\\"path\\\";s:60:\\\"documents\\/files\\/F7zMS5DOuHBcyaZIUiT5k4h5OFG69vxj3JT8Vhvh.pdf\\\";s:4:\\\"disk\\\";s:6:\\\"public\\\";s:5:\\\"queue\\\";s:18:\\\"image-optimization\\\";}\",\"batchId\":null},\"createdAt\":1789909420,\"delay\":null}', 0, NULL, 1789909420, 1789909420),
(8, 'default', '{\"uuid\":\"0ab8cfeb-beab-4953-a84b-0dbfcf5ed6e0\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"command\":\"O:33:\\\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Document\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"01a0beea-4a72-723e-a71b-5f20668c45b1\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1789909420,\"delay\":null}', 0, NULL, 1789909420, 1789909420),
(9, 'default', '{\"uuid\":\"dd82570f-8737-4f34-a620-7b317a172086\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"command\":\"O:33:\\\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Category\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"2162d145-9ef3-4e2f-8c55-81971a015bc5\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1791381729,\"delay\":null}', 0, NULL, 1791381729, 1791381729),
(10, 'default', '{\"uuid\":\"21f6d01f-1ad6-48ee-af75-63a45e9fa834\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"command\":\"O:33:\\\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Category\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"34103609-8116-4baf-bd17-557fc6989e8e\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1791381750,\"delay\":null}', 0, NULL, 1791381750, 1791381750),
(11, 'default', '{\"uuid\":\"fbec9933-98d7-4108-818b-841f6c030571\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"command\":\"O:33:\\\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Category\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"72561291-cdcb-484b-a556-0400fbd53c3d\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1791381770,\"delay\":null}', 0, NULL, 1791381770, 1791381770),
(12, 'default', '{\"uuid\":\"6a627d09-c1da-4c58-9834-6247e5cc4ed2\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"command\":\"O:33:\\\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Category\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"a58f5ebc-c8ec-48da-b6f9-a80b05ca40a0\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1791381788,\"delay\":null}', 0, NULL, 1791381788, 1791381788),
(13, 'default', '{\"uuid\":\"5cbd1877-c73d-4669-aae4-9a7079f4bc41\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"command\":\"O:33:\\\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Category\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"773cd47c-dc89-4546-b6f0-bfb26f74a0a2\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1791381806,\"delay\":null}', 0, NULL, 1791381806, 1791381806),
(14, 'image-optimization', '{\"uuid\":\"ed43a6cb-dc98-414a-b29b-bb390580e391\",\"displayName\":\"App\\\\Jobs\\\\OptimizeImageJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":\"30\",\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\OptimizeImageJob\",\"command\":\"O:25:\\\"App\\\\Jobs\\\\OptimizeImageJob\\\":3:{s:4:\\\"path\\\";s:51:\\\"images\\/Bap5YmJ5EmzA4lt77YqoONbVI76K1U4Q2j6u0alD.jpg\\\";s:4:\\\"disk\\\";s:6:\\\"public\\\";s:5:\\\"queue\\\";s:18:\\\"image-optimization\\\";}\",\"batchId\":null},\"createdAt\":1791382636,\"delay\":null}', 0, NULL, 1791382636, 1791382636),
(15, 'default', '{\"uuid\":\"760bddd5-4ac6-4773-a046-4805dd34bb74\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\RemoveFromSearch\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\RemoveFromSearch\",\"command\":\"O:35:\\\"Laravel\\\\Scout\\\\Jobs\\\\RemoveFromSearch\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:17:\\\"App\\\\Models\\\\Agenda\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"89355860-0de5-4a90-9567-f8c68d5fe4de\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";s:44:\\\"Laravel\\\\Scout\\\\Jobs\\\\RemoveableScoutCollection\\\";}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1791382636,\"delay\":null}', 0, NULL, 1791382636, 1791382636),
(16, 'default', '{\"uuid\":\"99e0a827-a1ab-4b4a-9022-4f94c484e51e\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\RemoveFromSearch\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\RemoveFromSearch\",\"command\":\"O:35:\\\"Laravel\\\\Scout\\\\Jobs\\\\RemoveFromSearch\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:17:\\\"App\\\\Models\\\\Agenda\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"89355860-0de5-4a90-9567-f8c68d5fe4de\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";s:44:\\\"Laravel\\\\Scout\\\\Jobs\\\\RemoveableScoutCollection\\\";}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1791382664,\"delay\":null}', 0, NULL, 1791382664, 1791382664),
(17, 'image-optimization', '{\"uuid\":\"e7d9cc2c-077b-4588-b34c-734636a2cc20\",\"displayName\":\"App\\\\Jobs\\\\OptimizeImageJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":\"30\",\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\OptimizeImageJob\",\"command\":\"O:25:\\\"App\\\\Jobs\\\\OptimizeImageJob\\\":3:{s:4:\\\"path\\\";s:51:\\\"images\\/bG1cr04Br6NCTiuxlyPaoCdH5LTcCkOzsqev3RYP.png\\\";s:4:\\\"disk\\\";s:6:\\\"public\\\";s:5:\\\"queue\\\";s:18:\\\"image-optimization\\\";}\",\"batchId\":null},\"createdAt\":1791382798,\"delay\":null}', 0, NULL, 1791382798, 1791382798),
(18, 'default', '{\"uuid\":\"d3e5ff9e-f6e3-418c-a8da-59cf9958309d\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\RemoveFromSearch\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\RemoveFromSearch\",\"command\":\"O:35:\\\"Laravel\\\\Scout\\\\Jobs\\\\RemoveFromSearch\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:17:\\\"App\\\\Models\\\\Agenda\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"89355860-0de5-4a90-9567-f8c68d5fe4de\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";s:44:\\\"Laravel\\\\Scout\\\\Jobs\\\\RemoveableScoutCollection\\\";}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1791382798,\"delay\":null}', 0, NULL, 1791382798, 1791382798),
(19, 'default', '{\"uuid\":\"749d45ea-52b1-477c-ae7b-da75347c098c\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"command\":\"O:33:\\\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:17:\\\"App\\\\Models\\\\Agenda\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"89355860-0de5-4a90-9567-f8c68d5fe4de\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1791382807,\"delay\":null}', 0, NULL, 1791382807, 1791382807);

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kecamatans`
--

CREATE TABLE `kecamatans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kecamatans`
--

INSERT INTO `kecamatans` (`id`, `nama`, `created_at`, `updated_at`) VALUES
(1, 'Bantar Gebang', NULL, NULL),
(2, 'Bekasi Barat', NULL, NULL),
(3, 'Bekasi Selatan', NULL, NULL),
(4, 'Bekasi Timur', NULL, NULL),
(5, 'Bekasi Utara', NULL, NULL),
(6, 'Jatiasih', NULL, NULL),
(7, 'Jatisampurna', NULL, NULL),
(8, 'Medan Satria', NULL, NULL),
(9, 'Mustika Jaya', NULL, NULL),
(10, 'Pondok Gede', NULL, NULL),
(11, 'Pondok Melati', NULL, NULL),
(12, 'Rawalumbu', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kelurahans`
--

CREATE TABLE `kelurahans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kecamatan_id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) NOT NULL,
  `kodepos` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kelurahans`
--

INSERT INTO `kelurahans` (`id`, `kecamatan_id`, `nama`, `kodepos`, `created_at`, `updated_at`) VALUES
(1, 1, 'Bantargebang', 17151, NULL, NULL),
(2, 1, 'Ciketing Udik', 17153, NULL, NULL),
(3, 1, 'Cikiwul', 17152, NULL, NULL),
(4, 1, 'Sumur Batu', 17154, NULL, NULL),
(5, 2, 'Bintara', 17134, NULL, NULL),
(6, 2, 'Bintara Jaya', 17136, NULL, NULL),
(7, 2, 'Jakasampurna', 17145, NULL, NULL),
(8, 2, 'Kota Baru', 17133, NULL, NULL),
(9, 2, 'Kranji', 17135, NULL, NULL),
(10, 3, 'Jakamulya', 17146, NULL, NULL),
(11, 3, 'Jakasetia', 17147, NULL, NULL),
(12, 3, 'Kayuringin Jaya', 17144, NULL, NULL),
(13, 3, 'Marga Jaya', 17141, NULL, NULL),
(14, 3, 'Pekayon Jaya', 17148, NULL, NULL),
(15, 4, 'Aren Jaya', 17111, NULL, NULL),
(16, 4, 'Bekasi Jaya', 17112, NULL, NULL),
(17, 4, 'Duren Jaya', 17111, NULL, NULL),
(18, 4, 'Margahayu', 17113, NULL, NULL),
(19, 5, 'Harapan Baru', 17123, NULL, NULL),
(20, 5, 'Harapan Jaya', 17124, NULL, NULL),
(21, 5, 'Kaliabang Tengah', 17125, NULL, NULL),
(22, 5, 'Marga Mulya', 17142, NULL, NULL),
(23, 5, 'Perwira', 17122, NULL, NULL),
(24, 5, 'Teluk Pucung', 17121, NULL, NULL),
(25, 6, 'Jatiasih', 17423, NULL, NULL),
(26, 6, 'Jatikramat', 17421, NULL, NULL),
(27, 6, 'Jatiluhur', 17425, NULL, NULL),
(28, 6, 'Jatimekar', 17422, NULL, NULL),
(29, 6, 'Jatirasa', 17424, NULL, NULL),
(30, 6, 'Jatisari', 17426, NULL, NULL),
(31, 7, 'Jatikarya', 17435, NULL, NULL),
(32, 7, 'Jatiraden', 17433, NULL, NULL),
(33, 7, 'Jatirangga', 17434, NULL, NULL),
(34, 7, 'Jatiranggon', 17432, NULL, NULL),
(35, 7, 'Jatisampurna', 17433, NULL, NULL),
(36, 8, 'Harapan Mulya', 17143, NULL, NULL),
(37, 8, 'Kali Baru', 17133, NULL, NULL),
(38, 8, 'Medan Satria', 17132, NULL, NULL),
(39, 8, 'Pejuang', 17131, NULL, NULL),
(40, 9, 'Cimuning', 17155, NULL, NULL),
(41, 9, 'Mustikajaya', 17158, NULL, NULL),
(42, 9, 'Mustikasari', 17157, NULL, NULL),
(43, 9, 'Padurenan', 17156, NULL, NULL),
(44, 10, 'Jatibening', 17412, NULL, NULL),
(45, 10, 'Jatibening Baru', 17412, NULL, NULL),
(46, 10, 'Jaticempaka', 17411, NULL, NULL),
(47, 10, 'Jatimakmur', 17413, NULL, NULL),
(48, 10, 'Jatiwaringin', 17411, NULL, NULL),
(49, 11, 'Jatimelati', 17414, NULL, NULL),
(50, 11, 'Jatimurni', 17431, NULL, NULL),
(51, 11, 'Jatirahayu', 17414, NULL, NULL),
(52, 11, 'Jatiwarna', 17415, NULL, NULL),
(53, 12, 'Bojong Menteng', 17117, NULL, NULL),
(54, 12, 'Bojong Rawalumbu', 17116, NULL, NULL),
(55, 12, 'Pengasinan', 17115, NULL, NULL),
(56, 12, 'Sepanjang Jaya', 17114, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kontak`
--

CREATE TABLE `kontak` (
  `uuid` char(36) NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `no_telp` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `isi` text DEFAULT NULL,
  `respon` text DEFAULT NULL,
  `status` enum('open','in_progress','resolved','closed','rejected') NOT NULL DEFAULT 'open',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login_activities`
--

CREATE TABLE `login_activities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_uuid` char(36) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `guard` varchar(50) DEFAULT NULL,
  `logged_in_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login_activities`
--

INSERT INTO `login_activities` (`id`, `user_uuid`, `name`, `email`, `ip_address`, `user_agent`, `guard`, `logged_in_at`, `created_at`, `updated_at`) VALUES
(13, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'curl/8.21.0', 'web', '2026-09-17 03:36:23', '2026-09-17 03:36:23', '2026-09-17 03:36:23'),
(15, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Symfony', 'web', '2026-09-17 03:39:58', '2026-09-17 03:39:58', '2026-09-17 03:39:58'),
(19, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-17 13:48:33', '2026-09-17 13:48:33', '2026-09-17 13:48:33'),
(20, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-17 13:48:33', '2026-09-17 13:48:33', '2026-09-17 13:48:33'),
(21, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-17 14:38:41', '2026-09-17 14:38:41', '2026-09-17 14:38:41'),
(22, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-17 14:38:41', '2026-09-17 14:38:41', '2026-09-17 14:38:41'),
(23, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-17 21:34:53', '2026-09-17 21:34:53', '2026-09-17 21:34:53'),
(24, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-17 21:34:53', '2026-09-17 21:34:53', '2026-09-17 21:34:53'),
(25, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-18 00:55:55', '2026-09-18 00:55:55', '2026-09-18 00:55:55'),
(26, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-18 00:55:55', '2026-09-18 00:55:55', '2026-09-18 00:55:55'),
(27, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-18 01:53:49', '2026-09-18 01:53:49', '2026-09-18 01:53:49'),
(28, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-18 01:53:49', '2026-09-18 01:53:49', '2026-09-18 01:53:49'),
(29, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-18 02:06:21', '2026-09-18 02:06:21', '2026-09-18 02:06:21'),
(30, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-18 02:06:21', '2026-09-18 02:06:21', '2026-09-18 02:06:21'),
(31, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-18 02:23:26', '2026-09-18 02:23:26', '2026-09-18 02:23:26'),
(32, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'web', '2026-09-18 02:23:26', '2026-09-18 02:23:26', '2026-09-18 02:23:26'),
(33, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-18 09:14:53', '2026-09-18 09:14:53', '2026-09-18 09:14:53'),
(34, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-18 09:14:53', '2026-09-18 09:14:53', '2026-09-18 09:14:53'),
(35, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-18 13:00:24', '2026-09-18 13:00:24', '2026-09-18 13:00:24'),
(36, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-18 13:00:24', '2026-09-18 13:00:24', '2026-09-18 13:00:24'),
(37, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-18 20:46:08', '2026-09-18 20:46:08', '2026-09-18 20:46:08'),
(38, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-18 20:46:08', '2026-09-18 20:46:08', '2026-09-18 20:46:08'),
(39, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-18 22:23:31', '2026-09-18 22:23:31', '2026-09-18 22:23:31'),
(40, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-18 22:23:31', '2026-09-18 22:23:31', '2026-09-18 22:23:31'),
(41, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-18 22:46:18', '2026-09-18 22:46:18', '2026-09-18 22:46:18'),
(42, '58cbfa68-69aa-4cd1-95cc-9520046d9ceb', 'Wiku Pramesthi Bagaswara', 'wikupb@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 00:40:15', '2026-09-19 00:40:15', '2026-09-19 00:40:15'),
(43, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 01:01:09', '2026-09-19 01:01:09', '2026-09-19 01:01:09'),
(44, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 01:04:27', '2026-09-19 01:04:27', '2026-09-19 01:04:27'),
(45, '58cbfa68-69aa-4cd1-95cc-9520046d9ceb', 'Wiku Pramesthi Bagaswara', 'wikupb@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 02:18:38', '2026-09-19 02:18:38', '2026-09-19 02:18:38'),
(46, '9c513953-32d1-4415-a921-8a6baf246d44', 'ESPRO Property', 'esproproperty.bekasi@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 02:27:18', '2026-09-19 02:27:18', '2026-09-19 02:27:18'),
(47, '9c513953-32d1-4415-a921-8a6baf246d44', 'ESPRO Property', 'esproproperty.bekasi@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 03:10:43', '2026-09-19 03:10:43', '2026-09-19 03:10:43'),
(48, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 03:11:29', '2026-09-19 03:11:29', '2026-09-19 03:11:29'),
(49, '58cbfa68-69aa-4cd1-95cc-9520046d9ceb', 'Wiku Pramesthi Bagaswara', 'wikupb@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 04:07:41', '2026-09-19 04:07:41', '2026-09-19 04:07:41'),
(50, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 04:08:04', '2026-09-19 04:08:04', '2026-09-19 04:08:04'),
(51, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 04:27:45', '2026-09-19 04:27:45', '2026-09-19 04:27:45'),
(52, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 04:59:48', '2026-09-19 04:59:48', '2026-09-19 04:59:48'),
(53, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 06:37:43', '2026-09-19 06:37:43', '2026-09-19 06:37:43'),
(54, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 13:28:39', '2026-09-19 13:28:39', '2026-09-19 13:28:39'),
(55, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 13:30:55', '2026-09-19 13:30:55', '2026-09-19 13:30:55'),
(56, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 22:14:04', '2026-09-19 22:14:04', '2026-09-19 22:14:04'),
(57, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-19 23:42:27', '2026-09-19 23:42:27', '2026-09-19 23:42:27'),
(58, '58cbfa68-69aa-4cd1-95cc-9520046d9ceb', 'Wiku Pramesthi Bagaswara', 'wikupb@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-20 00:28:56', '2026-09-20 00:28:56', '2026-09-20 00:28:56'),
(59, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-20 00:29:20', '2026-09-20 00:29:20', '2026-09-20 00:29:20'),
(60, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-20 01:15:28', '2026-09-20 01:15:28', '2026-09-20 01:15:28'),
(61, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 27 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/27 Mobile/15E148 Safari/604.1', 'web', '2026-09-20 05:36:28', '2026-09-20 05:36:28', '2026-09-20 05:36:28'),
(62, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-20 09:09:39', '2026-09-20 09:09:39', '2026-09-20 09:09:39'),
(63, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-20 11:18:01', '2026-09-20 11:18:01', '2026-09-20 11:18:01'),
(64, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin Bekasikota', 'bekasikotakotabekasi2018@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-20 12:07:38', '2026-09-20 12:07:38', '2026-09-20 12:07:38'),
(65, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin Bekasikota', 'bekasikotakotabekasi2018@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-20 12:40:58', '2026-09-20 12:40:58', '2026-09-20 12:40:58'),
(66, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin Bekasikota', 'bekasikotakotabekasi2018@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-20 13:36:13', '2026-09-20 13:36:13', '2026-09-20 13:36:13'),
(67, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'web', '2026-10-07 12:24:54', '2026-10-07 12:24:54', '2026-10-07 12:24:54'),
(68, '0a091f5a-c510-4110-b2b2-2f992091fb1d', 'Diskominfostandi', 'diskominfostandi@bekasikota.go.id', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'web', '2026-10-07 14:16:12', '2026-10-07 14:16:12', '2026-10-07 14:16:12'),
(69, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'web', '2026-10-07 23:22:47', '2026-10-07 23:22:47', '2026-10-07 23:22:47');

-- --------------------------------------------------------

--
-- Table structure for table `login_lockouts`
--

CREATE TABLE `login_lockouts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(10) NOT NULL,
  `value` varchar(255) NOT NULL,
  `attempts` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `reason` varchar(255) DEFAULT NULL,
  `blocked_until` timestamp NULL DEFAULT NULL,
  `last_attempt_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login_lockouts`
--

INSERT INTO `login_lockouts` (`id`, `type`, `value`, `attempts`, `reason`, `blocked_until`, `last_attempt_at`, `created_at`, `updated_at`) VALUES
(33, 'email', 'superadmin@gmail.com', 1, NULL, NULL, '2026-09-18 22:48:32', '2026-09-18 22:48:32', '2026-09-18 22:48:32'),
(34, 'email', 'tapayoga@yogaroots.id', 1, NULL, NULL, '2026-09-18 22:51:01', '2026-09-18 22:51:01', '2026-09-18 22:51:01');

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_schedules`
--

CREATE TABLE `maintenance_schedules` (
  `uuid` char(36) NOT NULL,
  `aduan_uuid` char(36) DEFAULT NULL,
  `judul` varchar(255) NOT NULL,
  `keterangan` text DEFAULT NULL,
  `tanggal_rencana` date DEFAULT NULL,
  `tanggal_selesai` date DEFAULT NULL,
  `status` enum('terjadwal','berjalan','selesai','tertunda') NOT NULL DEFAULT 'terjadwal',
  `petugas_uuid` char(36) DEFAULT NULL,
  `prioritas` varchar(20) NOT NULL DEFAULT 'sedang',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menu_groups`
--

CREATE TABLE `menu_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `permission_name` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `position` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_groups`
--

INSERT INTO `menu_groups` (`id`, `name`, `status`, `permission_name`, `icon`, `position`, `created_at`, `updated_at`) VALUES
(2, 'Role dan Akses', 1, 'menu.role-permission', 'bx-shield-quarter', 9, '2024-09-26 23:27:05', '2024-09-26 23:56:50'),
(3, 'Pengaturan', 1, 'menu-item.index', 'bx-cog', 10, '2024-09-26 23:27:05', '2026-09-17 03:28:38'),
(4, 'Dokumen', 1, 'document-categories.index', 'bx-receipt', 5, '2024-09-26 23:35:30', '2026-09-15 22:51:58'),
(7, 'Publikasi', 1, 'agendas.index', 'bxs-file', 2, '2024-09-29 12:37:06', '2026-10-07 13:55:13'),
(8, 'Galeri Media', 1, 'banner.index', 'bx-camera', 3, '2024-10-13 22:33:06', '2026-10-07 14:22:09'),
(9, 'Master Data', 1, 'faq.index', 'bx-folder-open', 8, '2025-07-21 17:56:19', '2026-08-30 19:07:27'),
(22, 'Layanan Publik', 1, 'services.index', 'bx-book', 6, '2026-09-02 15:16:09', '2026-10-07 13:30:20'),
(24, 'Keamanan', 1, 'menu.keamanan', 'bx-shield-alt-2', 11, '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(26, 'Pengaduan', 1, 'aduans.index', 'bx-phone', 7, '2026-09-19 02:03:39', '2026-09-19 02:03:39');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `route` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `permission_name` varchar(255) NOT NULL,
  `menu_group_id` bigint(20) UNSIGNED NOT NULL,
  `position` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `name`, `icon`, `route`, `status`, `permission_name`, `menu_group_id`, `position`, `created_at`, `updated_at`) VALUES
(2, 'Module Role', NULL, 'permission.index', 1, 'permission.index', 2, 1, '2024-09-26 23:27:05', '2024-09-26 23:58:37'),
(3, 'Master Role', NULL, 'role.index', 1, 'role.index', 2, 2, '2024-09-26 23:27:05', '2024-09-26 23:58:15'),
(4, 'Daftar Pengguna', NULL, 'user.index', 1, 'user.index', 3, 1, '2024-09-26 23:27:05', '2024-09-26 23:39:25'),
(5, 'Module Aplikasi', NULL, 'route.index', 1, 'route.index', 3, 2, '2024-09-26 23:27:05', '2024-09-26 23:44:54'),
(6, 'Menu Manager', NULL, 'menu.index', 1, 'menu-group.index', 3, 3, '2024-09-26 23:27:05', '2024-09-26 23:44:09'),
(8, 'Kategori', NULL, 'categories.index', 1, 'categories.index', 7, 3, '2024-09-29 12:39:24', '2026-09-17 02:21:41'),
(9, 'Agenda', NULL, 'agendas.index', 1, 'agendas.index', 7, 1, '2024-09-30 12:08:38', '2026-09-17 01:51:37'),
(10, 'Semua Media', NULL, 'banner.index', 1, 'banner.index', 8, 1, '2024-10-13 22:38:24', '2026-09-17 05:23:32'),
(12, 'Tambah Agenda', NULL, 'agendas.create', 1, 'agendas.create', 7, 2, '2025-07-22 12:59:27', '2026-09-17 02:21:32'),
(40, 'Halaman Statis', NULL, 'pages.index', 1, 'pages.index', 9, 3, '2025-10-21 03:46:02', '2026-09-17 03:30:02'),
(46, 'Daftar Layanan', NULL, 'services.index', 1, 'services.index', 22, 1, '2026-09-02 15:18:03', '2026-10-07 13:32:18'),
(48, 'Pesan Masuk', NULL, 'layanan.kontak', 1, 'layanan.kontak', 3, 4, '2026-09-06 19:44:23', '2026-09-17 14:13:26'),
(49, 'Menu Website', NULL, 'website-menu.index', 1, 'agendas.index', 3, 5, '2026-09-06 20:40:53', '2026-09-17 13:56:47'),
(50, 'Polling', NULL, 'poll.index', 1, 'poll.index', 9, 4, '2026-09-07 23:00:45', '2026-09-17 03:30:23'),
(51, 'Faq & Answer', NULL, 'faq.index', 1, 'faq.index', 9, 5, '2026-09-07 23:04:55', '2026-09-07 23:04:55'),
(52, 'All Studios', NULL, 'studios.index', 1, 'studios.index', 23, 1, '2026-09-08 07:14:52', '2026-09-08 07:14:52'),
(53, 'Add Studio', NULL, 'studios.create', 1, 'studios.create', 23, 2, '2026-09-08 07:15:14', '2026-09-08 07:15:14'),
(54, 'Semua Dokumen', NULL, 'documents.index', 1, 'documents.index', 4, 1, '2026-09-13 14:23:49', '2026-09-17 14:18:42'),
(55, 'Kategori  Dokumen', NULL, 'document-categories.index', 1, 'document-categories.index', 4, 2, '2026-09-13 14:27:33', '2026-09-17 14:18:54'),
(56, 'Tambah Dokumen', NULL, 'documents.create', 1, 'documents.create', 4, 3, '2026-09-16 00:39:08', '2026-09-16 00:39:08'),
(57, 'Login Activity', NULL, 'security.login-activity.index', 1, 'login-activity.index', 24, 1, '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(58, 'Audit Log', NULL, 'security.audit-log.index', 1, 'audit-log.index', 24, 2, '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(59, 'Failed Login', NULL, 'security.failed-login.index', 1, 'failed-login.index', 24, 3, '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(60, 'Blokir Login', NULL, 'security.login-lockout.index', 1, 'login-lockout.index', 24, 4, '2026-09-17 03:25:22', '2026-09-17 03:25:22'),
(61, 'Identitas Website', NULL, 'website-identity.edit', 1, 'website-identity.edit', 25, 1, '2026-09-18 02:42:55', '2026-09-18 02:42:55'),
(62, 'Konfigurasi Website', NULL, 'website-identity.edit', 1, 'website-identity.edit', 3, 6, '2026-09-18 03:00:37', '2026-09-18 03:00:37'),
(63, 'Riwayat Aduan', NULL, 'aduans.index', 1, 'aduans.index', 26, 1, '2026-09-19 02:04:40', '2026-09-19 02:04:40');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2014_10_12_100000_create_password_resets_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2024_07_25_034354_create_permission_tables', 1),
(7, '2024_07_25_045022_create_routes_table', 1),
(8, '2024_07_26_043548_create_menu_groups_table', 1),
(9, '2024_07_31_012301_create_banners_table', 1),
(10, '2024_07_31_033121_create_kontaks_table', 1),
(11, '2024_08_26_084211_create_menu_items_table', 1),
(12, '2024_10_15_032323_create_categories_table', 1),
(13, '2024_10_16_032117_create_articles_table', 1),
(14, '2024_10_16_032437_create_seo_table', 1),
(15, '2025_07_21_125740_add_google_id_column', 1),
(16, '2025_07_22_061051_create_ebooks_table', 1),
(17, '2025_07_24_021857_create_kecamatans_table', 1),
(18, '2025_07_24_021932_create_kelurahans_table', 1),
(19, '2025_07_24_071157_add_profile_fields_to_users_table', 1),
(20, '2025_07_25_120837_create_file_downloads_table', 1),
(21, '2025_07_30_070942_create_programs_table', 1),
(22, '2025_08_06_040605_create_pages_table', 1),
(23, '2025_08_08_023001_change_model_id_to_uuid_in_seo_table', 1),
(24, '2025_08_15_025639_add_tagging_status_searchengine_to_articles_table', 1),
(25, '2025_09_16_021217_create_notifications_table', 1),
(26, '2025_09_16_023931_alter_notifications_table_for_uuid', 1),
(27, '2025_09_16_061424_create_faqs_table', 1),
(29, '2025_09_16_063145_create_polls_table', 1),
(30, '2025_09_16_074843_create_poll_votes_table', 1),
(31, '2025_09_22_030137_add_deleted_at_to_users_table', 2),
(32, '2025_10_03_015100_add_socials_and_biografi_to_users_table', 3),
(33, '2024_10_16_012301_create_banners_table', 4),
(34, '2025_10_20_120827_create_services_table', 5),
(35, '2025_10_19_120827_create_services_table', 6),
(36, '2025_10_21_120827_create_services_table', 7),
(37, '2025_11_11_033008_create_disabilities_table', 8),
(38, '2025_11_11_070942_create_programs_table', 9),
(39, '2026_08_28_033008_create_specializations_table', 10),
(41, '2026_08_31_125113_create_user_specialization_table', 12),
(42, '2026_09_02_073504_create_packages_table', 13),
(43, '2026_09_02_073857_create_package_features_table', 13),
(44, '2026_09_02_073943_create_classes_table', 13),
(45, '2026_09_02_074219_create_class_schedules_table', 13),
(46, '2026_09_02_074643_add_membership_fields_to_users_table', 13),
(47, '2026_09_02_074803_create_orders_table', 13),
(48, '2026_09_02_074832_create_payments_table', 13),
(49, '2026_09_02_074849_create_class_bookings_table', 13),
(50, '2026_09_06_222620_create_user_packages_table', 14),
(51, '2026_09_08_131616_create_user_studios_table', 15),
(52, '2026_09_08_131617_create_studios_table', 16),
(53, '2026_09_12_195535_create_package_options_table', 17),
(54, '2026_09_12_195536_create_package_options_table', 18),
(55, '2026_09_16_051254_create_document_categories_table', 19),
(56, '2026_09_16_131617_create_documents_table', 19),
(57, '2026_09_16_131618_create_documents_table', 20),
(58, '2026_09_17_000001_add_tipe_and_video_url_to_banner_table', 21),
(59, '2026_09_17_000002_create_albums_table', 22),
(60, '2026_09_17_000003_create_album_foto_table', 23),
(61, '2026_09_16_051255_create_document_categories_table', 24),
(62, '2026_09_16_131619_create_documents_table', 24),
(63, '2026_09_17_000004_add_featured_popular_to_articles_table', 25),
(64, '2026_09_17_000005_create_article_images_table', 25),
(65, '2026_09_17_000006_create_login_activities_table', 26),
(66, '2026_09_17_000007_create_failed_logins_table', 26),
(67, '2026_09_17_000008_create_audit_logs_table', 26),
(68, '2026_09_17_000009_create_login_lockouts_table', 27),
(69, '2026_09_17_193653_create_website_menus_table', 28),
(70, '2026_09_17_193656_create_website_menus_table', 29),
(71, '2026_09_17_193657_create_website_menu_items_table', 30),
(72, '2026_09_18_044538_create_visitor_logs_table', 31),
(73, '2026_09_18_051353_create_visitor_daily_stats_table', 32),
(74, '2026_09_18_100000_create_website_identities_table', 33),
(77, '2026_09_19_000001_create_aduans_table', 35),
(78, '2026_09_19_000002_change_kategori_to_enum_on_aduans_table', 36),
(79, '2026_09_19_000003_add_soft_deletes_to_aduans_table', 37),
(80, '2026_09_19_000004_add_is_anonim_to_aduans_table', 38),
(81, '2026_09_19_000005_create_aduan_tindak_lanjuts_table', 39),
(82, '2026_09_19_000006_add_pelapor_to_aduans_table', 40),
(83, '2026_09_19_000007_add_archived_at_to_aduans_table', 41),
(84, '2026_09_19_000008_drop_pelapor_from_aduans_table', 42),
(85, '2026_09_19_000009_add_rating_to_aduans_table', 43),
(86, '2026_09_19_000010_create_tindak_lanjut_templates_table', 44),
(87, '2026_09_20_000001_add_missing_indexes', 44),
(88, '2026_09_20_000002_create_maintenance_schedules_table', 44),
(90, '2026_09_20_000004_create_document_versions_table', 45),
(91, '2026_09_22_000001_make_avatar_nullable_on_users_table', 45),
(92, '2026_09_22_000002_protect_bulk_routes', 45),
(93, '2026_09_22_000003_create_services_table', 45),
(94, '2026_09_22_000004_uuid_morph_keys', 45),
(95, '2026_09_23_031538_add_kategori_to_faqs_table', 45),
(96, '2026_09_23_034017_change_kategori_to_enum_on_faqs', 45),
(97, '2026_09_23_035421_update_kategori_enum_to_new_set', 45),
(99, '2026_10_07_000001_rename_articles_to_agendas', 46),
(100, '2026_10_07_000002_add_pending_to_agendas', 47),
(101, '2026_10_07_000003_drop_pejabat_columns_from_users', 48);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', '3099cb1c-6c37-4e5a-bbb5-d11615a1b0ff'),
(1, 'App\\Models\\User', '5e21baa9-0ca0-4c94-9939-85068e363f57'),
(1, 'App\\Models\\User', '70e15b9f-535a-42a2-8ea0-9a26ad7952e5'),
(1, 'App\\Models\\User', '787b72ea-59d0-4d54-848b-c200bddafdd2'),
(2, 'App\\Models\\User', '0dd616be-4e66-463c-9b42-6529b1c7cb4f'),
(2, 'App\\Models\\User', '130214ce-3612-455f-ae39-f6f2a5c2b90d'),
(2, 'App\\Models\\User', '370a8be5-8531-453a-a504-2a610ed8538f'),
(2, 'App\\Models\\User', '3e354d68-8b35-410c-9fd1-827ec786b007'),
(2, 'App\\Models\\User', '57621d3c-c299-4cd2-b96a-9b887752cb73'),
(2, 'App\\Models\\User', '6bdf7417-66c8-407c-828b-77577006dda2'),
(2, 'App\\Models\\User', '70e15b9f-535a-42a2-8ea0-9a26ad7952e5'),
(2, 'App\\Models\\User', '95271004-d8a8-41a4-93eb-62a766c2758d'),
(2, 'App\\Models\\User', 'a82db5a8-5d69-499b-a9a1-3d98ad0c47e4'),
(2, 'App\\Models\\User', 'b5a9eb64-a547-4464-a576-e261ede0d4db'),
(2, 'App\\Models\\User', 'c4536499-9979-4be5-a0ad-775fe9bec19d'),
(2, 'App\\Models\\User', 'd56cc48a-b1fa-4c03-9b72-c8f92766efb3'),
(2, 'App\\Models\\User', 'd91ccba3-e95b-4692-8f8c-63d543549331'),
(2, 'App\\Models\\User', 'dfd391fa-c167-4547-ad17-27d52d9ffc28'),
(2, 'App\\Models\\User', 'e5a05967-00cb-49f6-97bf-95c1bccee6e0'),
(3, 'App\\Models\\User', '44af87c7-cd3f-4f9d-af63-177da19727fb'),
(3, 'App\\Models\\User', '57f63489-134b-498c-ad05-78a3652cb916'),
(3, 'App\\Models\\User', '9c513953-32d1-4415-a921-8a6baf246d44'),
(3, 'App\\Models\\User', 'e2c23ff6-eda1-4c5c-86a4-d2d1782ed930'),
(5, 'App\\Models\\User', '0a091f5a-c510-4110-b2b2-2f992091fb1d'),
(5, 'App\\Models\\User', '0ba0b18a-64e7-44ce-8042-8b282ab9c5b3'),
(5, 'App\\Models\\User', '1c3ea59a-f83a-4bdf-aa70-f38ff66f49a2'),
(5, 'App\\Models\\User', '2f040883-ec48-424e-872d-3691d7c1a714'),
(5, 'App\\Models\\User', '33b681e2-efc3-4017-9415-e5d5d197f2fe'),
(5, 'App\\Models\\User', '4a85c36a-caa6-4cc9-9ab6-47f77c0a9a67'),
(5, 'App\\Models\\User', '4c0ff420-34e5-4ecd-bb07-358862f9906a'),
(5, 'App\\Models\\User', '514d04e5-f79b-403a-95f4-2254784db0f0'),
(5, 'App\\Models\\User', '537f352e-a1e3-4daa-86b2-fc6b3366881c'),
(5, 'App\\Models\\User', '56f0bbe7-c52e-4d97-833f-17fba920421f'),
(5, 'App\\Models\\User', '58cbfa68-69aa-4cd1-95cc-9520046d9ceb'),
(5, 'App\\Models\\User', '755e0eaa-50e4-46db-9003-7c1fc6674876'),
(5, 'App\\Models\\User', '7d84490a-7661-415a-921c-141c05f38ded'),
(5, 'App\\Models\\User', '896ff4a7-ec81-4be5-ad12-ba4e3bb277de'),
(5, 'App\\Models\\User', '897f6253-86e1-4866-9072-e3e10bb51e5e'),
(5, 'App\\Models\\User', '950e18b7-9af4-468a-8468-edc338b7deec'),
(5, 'App\\Models\\User', '95294c43-b3d8-4b46-b938-e4eea1f3a359'),
(5, 'App\\Models\\User', 'a52ef0ee-6805-4b04-9f23-d6d6410829c5'),
(5, 'App\\Models\\User', 'b497082d-dd9f-4d1c-a611-9e1331eb5393'),
(5, 'App\\Models\\User', 'b55eb675-019c-4fa5-936e-579e2835527d'),
(5, 'App\\Models\\User', 'bace7196-8ce8-4253-baa7-04901e31592e'),
(5, 'App\\Models\\User', 'beaaf326-874c-48c2-b6b8-6bbe655c4df2'),
(5, 'App\\Models\\User', 'd405298f-5481-4038-8474-2ec0283b7608'),
(5, 'App\\Models\\User', 'dc25dea7-9969-46eb-b1ac-fd7f1b8dab77'),
(5, 'App\\Models\\User', 'dffd1060-8999-4d7b-8623-74caf47ab546'),
(5, 'App\\Models\\User', 'f7010485-3236-4341-a22a-48b70260a607'),
(5, 'App\\Models\\User', 'fab7c79d-a7dc-421f-b343-aaf81bdd20da');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` varchar(255) NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('32e1f1c5-9072-4825-83cd-1018cb73d62f', 'App\\Notifications\\ProgramStatusChanged', 'App\\Models\\User', 'b5a9eb64-a547-4464-a576-e261ede0d4db', '{\"program_id\":null,\"judul_kegiatan\":null,\"old_status\":\"pending\",\"new_status\":\"hadir\",\"message\":\"Status program \'\' berubah dari \'pending\' menjadi \'hadir\'.\"}', '2026-06-17 19:03:03', '2026-06-17 19:02:26', '2026-06-17 19:03:03'),
('683fd199-57df-4eb6-b595-269e239b5cf0', 'App\\Notifications\\KontakBaruNotification', 'App\\Models\\User', '787b72ea-59d0-4d54-848b-c200bddafdd2', '{\"title\":\"Pesan kontak baru\",\"message\":\"Dari Pengirim Tes: Pesan pengujian kontak.\",\"url\":\"http:\\/\\/localhost\\/backend\\/kontak\",\"icon\":\"bi-envelope\"}', '2026-09-19 05:18:33', '2026-09-19 05:15:32', '2026-09-19 05:18:33'),
('6f95fb80-2e8d-441d-850a-741dcdc7d1bc', 'App\\Notifications\\ProgramStatusChanged', 'App\\Models\\User', '70e15b9f-535a-42a2-8ea0-9a26ad7952e5', '{\"program_id\":null,\"judul_kegiatan\":null,\"old_status\":\"pending\",\"new_status\":\"hadir\",\"message\":\"Status program \'\' berubah dari \'pending\' menjadi \'hadir\'.\"}', '2026-09-02 06:50:51', '2026-05-24 21:21:26', '2026-09-02 06:50:51'),
('ac5b2d37-85ab-4267-b572-70b998039556', 'App\\Notifications\\ProgramStatusChanged', 'App\\Models\\User', 'dfd391fa-c167-4547-ad17-27d52d9ffc28', '{\"program_id\":null,\"judul_kegiatan\":null,\"old_status\":\"pending\",\"new_status\":\"hadir\",\"message\":\"Status program \'\' berubah dari \'pending\' menjadi \'hadir\'.\"}', '2026-05-24 21:51:12', '2026-05-24 21:48:19', '2026-05-24 21:51:12'),
('f071f5b7-d4aa-44ba-9449-cbd36724f7c8', 'App\\Notifications\\ProgramStatusChanged', 'App\\Models\\User', '70e15b9f-535a-42a2-8ea0-9a26ad7952e5', '{\"program_id\":null,\"judul_kegiatan\":null,\"old_status\":\"pending\",\"new_status\":\"hadir\",\"message\":\"Status program \'\' berubah dari \'pending\' menjadi \'hadir\'.\"}', '2026-05-25 20:36:48', '2026-05-24 21:41:40', '2026-05-25 20:36:48');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `uuid` char(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `excerpt` text DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT 0,
  `published_at` timestamp NULL DEFAULT NULL,
  `user_uuid` char(36) DEFAULT NULL,
  `has_sidebar` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`uuid`, `title`, `slug`, `excerpt`, `content`, `featured_image`, `is_published`, `published_at`, `user_uuid`, `has_sidebar`, `created_at`, `updated_at`) VALUES
('5380a3e5-adfa-437c-a0fa-bc2193d55cb2', 'Privacy Policy', 'privacy-policy', 'By accessing and using the YogaRoots website and services, you acknowledge that you have read, understood, and agreed to this Privacy Policy.', '<h2><strong style=\"color: rgb(71, 85, 105); font-size: 16px; letter-spacing: 0.1px;\">Last Updated:</strong><span style=\"color: rgb(71, 85, 105); font-size: 16px; font-weight: 400; letter-spacing: 0.1px;\"> August 30, 2026</span></h2>\r\n\r\n<p>\r\n  Welcome to <strong>YogaRoots</strong>.\r\n</p>\r\n\r\n<p>\r\n  We value your trust and are committed to protecting the privacy and security of your personal information. This Privacy Policy explains how YogaRoots collects, uses, stores, and protects your information when you visit our website, register for an account, contact us, or use our services.\r\n</p>\r\n\r\n<p>\r\n  By accessing and using the YogaRoots website and services, you acknowledge that you have read, understood, and agreed to this Privacy Policy.\r\n</p>\r\n\r\n<h3>1. Information We Collect</h3>\r\n\r\n<p>\r\n  We may collect information that you voluntarily provide when using the YogaRoots website or services, including:\r\n</p>\r\n\r\n<ul>\r\n  <li>Full name</li>\r\n  <li>Email address</li>\r\n  <li>Phone number</li>\r\n  <li>Information submitted through contact forms</li>\r\n  <li>Class registration or booking information</li>\r\n  <li>Account information if you use our login features</li>\r\n  <li>Other information you voluntarily provide to us</li>\r\n</ul>\r\n\r\n<p>\r\n  We may also automatically collect certain technical information when you access our website, such as your device type, browser type, IP address, and information about your interactions with and use of the website.\r\n</p>\r\n\r\n<h3>2. How We Use Your Information</h3>\r\n\r\n<p>\r\n  The information we collect may be used to:\r\n</p>\r\n\r\n<ul>\r\n  <li>Process class registrations and bookings</li>\r\n  <li>Manage your account and membership</li>\r\n  <li>Respond to your questions, requests, or inquiries</li>\r\n  <li>Provide information about YogaRoots classes, schedules, programs, and services</li>\r\n  <li>Send important information related to the services you use</li>\r\n  <li>Improve our website, services, and overall user experience</li>\r\n  <li>Maintain website security and prevent misuse or unauthorized activity</li>\r\n  <li>Comply with applicable legal and regulatory requirements</li>\r\n</ul>\r\n\r\n<p>\r\n  We strive to use your personal information only for purposes that are relevant and necessary to provide and improve YogaRoots services.\r\n</p>\r\n\r\n<h3>3. Protection of Your Information</h3>\r\n\r\n<p>\r\n  YogaRoots takes reasonable administrative, technical, and organizational measures to protect your personal information from unauthorized access, use, alteration, disclosure, or loss.\r\n</p>\r\n\r\n<p>\r\n  However, no storage system or transmission of information over the internet can be guaranteed to be completely secure. Therefore, while we make reasonable efforts to protect your information, we cannot guarantee absolute security.\r\n</p>\r\n\r\n<h3>4. Third-Party Services</h3>\r\n\r\n<p>\r\n  To operate and improve our services, YogaRoots may work with trusted third-party service providers, including technology providers, payment processors, authentication services, analytics providers, communication platforms, and other service partners.\r\n</p>\r\n\r\n<p>\r\n  Information may be shared with these third parties only to the extent reasonably necessary to provide, maintain, or improve the relevant services.\r\n</p>\r\n\r\n<p>\r\n  Third-party providers may have their own privacy policies and terms of use. We encourage you to review the privacy policies of any third-party services you choose to use.\r\n</p>\r\n\r\n<h3>5. Cookies</h3>\r\n\r\n<p>\r\n  The YogaRoots website may use cookies and similar technologies to help the website function properly, remember your preferences, understand how visitors use our website, and improve your overall experience.\r\n</p>\r\n\r\n<p>\r\n  You can manage or disable cookies through your browser settings. Please note that disabling certain cookies may affect the functionality or availability of some features on our website.\r\n</p>\r\n\r\n<h3>6. Information You Provide to Us</h3>\r\n\r\n<p>\r\n  When you contact YogaRoots through our contact forms, email, WhatsApp, or other communication channels, the information you provide may be used to respond to your inquiry and provide the assistance or information you need.\r\n</p>\r\n\r\n<p>\r\n  We do not sell or rent your personal information to third parties.\r\n</p>\r\n\r\n<h3>7. Data Retention</h3>\r\n\r\n<p>\r\n  We may retain your personal information for as long as necessary to provide our services, fulfill the purposes for which the information was collected, complete transactions, comply with legal obligations, or address legitimate administrative and operational needs.\r\n</p>\r\n\r\n<p>\r\n  When your information is no longer required, we may delete or anonymize it in accordance with our internal policies and applicable laws and regulations.\r\n</p>\r\n\r\n<h3>8. Your Rights</h3>\r\n\r\n<p>\r\n  You may contact YogaRoots if you wish to:\r\n</p>\r\n\r\n<ul>\r\n  <li>Update your personal information</li>\r\n  <li>Correct inaccurate or incomplete information</li>\r\n  <li>Ask about the personal information we hold about you</li>\r\n  <li>Request the deletion of certain information, where permitted and where such deletion does not conflict with applicable legal or service requirements</li>\r\n  <li>Ask how your personal information is collected, used, or processed</li>\r\n</ul>\r\n\r\n<p>\r\n  We will review and respond to requests in accordance with applicable laws, our policies, and the circumstances of each request.\r\n</p>\r\n\r\n<h3>9. Children\'s Privacy</h3>\r\n\r\n<p>\r\n  YogaRoots respects the privacy of children and does not knowingly intend to collect personal information from children without appropriate involvement or consent from a parent or legal guardian.\r\n</p>\r\n\r\n<p>\r\n  If you believe that a child has provided personal information to us without appropriate consent, please contact us so that we can review the matter and take appropriate action.\r\n</p>\r\n\r\n<h3>10. Changes to This Privacy Policy</h3>\r\n\r\n<p>\r\n  YogaRoots may update this Privacy Policy from time to time to reflect changes in our services, technology, business practices, or applicable laws and regulations.\r\n</p>\r\n\r\n<p>\r\n  Any changes will be published on this page, and the \"Last Updated\" date will be revised accordingly.\r\n</p>\r\n\r\n<p>\r\n  We encourage you to review this page periodically to stay informed about how we collect, use, and protect your personal information.\r\n</p>\r\n\r\n<h3>11. Contact Us</h3>\r\n\r\n<p>\r\n  If you have any questions about this Privacy Policy or how YogaRoots handles your personal information, please contact us through the following channels:\r\n</p>\r\n\r\n<p>\r\n  <strong>YogaRoots</strong>\r\n</p>\r\n\r\n<p>\r\n  <strong>Email:</strong>&nbsp;\r\n</p>\r\n\r\n<p>\r\n  <strong>Phone / WhatsApp:</strong> +62 813 2122 1270\r\n</p>\r\n\r\n<p>\r\n  <strong>Address:</strong> Roots Prasasta Building, Jl. Kawi Raya No.37, RT.6/RW.2, Guntur, Setiabudi, South Jakarta City, Jakarta 12980\r\n</p>\r\n\r\n<p>\r\n  We will do our best to assist you and provide the information you need regarding your privacy and the handling of your personal information.\r\n</p>', 'pages/KGpKHJFc1aFrX0OocaW7I9uDWxmWiRAc9XA3gCzQ.png', 1, '2026-08-30 17:00:00', NULL, 0, '2025-10-16 04:07:16', '2026-09-06 21:25:55'),
('9e55815c-a4dd-4df2-8cb5-27f7de7249fd', 'Terms & Conditions', 'terms-conditions', 'By accessing or using the YogaRoots website and services, you acknowledge that you have read, understood, and agreed to these Terms & Conditions.', '`<strong style=\"letter-spacing: 0.1px;\">Last Updated:</strong><span style=\"letter-spacing: 0.1px;\"> August 30, 2026</span><p>\r\n  Welcome to <strong>YogaRoots</strong>.\r\n</p>\r\n\r\n<p>\r\n  These Terms &amp; Conditions explain the rules and guidelines for using the YogaRoots website, purchasing memberships, booking classes, making payments, and using our services.\r\n</p>\r\n\r\n<p>\r\n  By accessing or using the YogaRoots website and services, you acknowledge that you have read, understood, and agreed to these Terms &amp; Conditions.\r\n</p>\r\n\r\n<h3>1. Website Use</h3>\r\n\r\n<p>\r\n  You agree to use the YogaRoots website responsibly and only for lawful purposes.\r\n</p>\r\n\r\n<p>\r\n  You must not use the website to:\r\n</p>\r\n\r\n<ul>\r\n  <li>Provide false, misleading, or inaccurate information</li>\r\n  <li>Attempt to gain unauthorized access to accounts or systems</li>\r\n  <li>Interfere with or disrupt the operation of the website</li>\r\n  <li>Use the website for fraudulent, abusive, or unlawful activities</li>\r\n  <li>Copy, reproduce, or misuse YogaRoots content without permission</li>\r\n</ul>\r\n\r\n<p>\r\n  YogaRoots reserves the right to restrict or suspend access to the website or services if we reasonably believe that these Terms &amp; Conditions have been violated.\r\n</p>\r\n\r\n<h3>2. Account Registration</h3>\r\n\r\n<p>\r\n  Certain YogaRoots services may require you to create an account.\r\n</p>\r\n\r\n<p>\r\n  When creating an account, you agree to provide accurate and up-to-date information and to keep your account information secure.\r\n</p>\r\n\r\n<ul>\r\n  <li>You are responsible for maintaining the confidentiality of your login credentials.</li>\r\n  <li>You are responsible for activities performed through your account.</li>\r\n  <li>You must notify YogaRoots if you believe your account has been accessed without authorization.</li>\r\n  <li>You must not create an account using another person\'s identity or information without permission.</li>\r\n</ul>\r\n\r\n<h3>3. Membership</h3>\r\n\r\n<p>\r\n  YogaRoots offers different membership packages and options designed to suit different practice needs.\r\n</p>\r\n\r\n<p>\r\n  Each membership option may have different pricing, class quota, duration, benefits, and conditions.\r\n</p>\r\n\r\n<ul>\r\n  <li>Memberships are personal and may only be used by the registered member.</li>\r\n  <li>Memberships cannot be transferred, resold, or shared with another person.</li>\r\n  <li>A membership becomes active after the payment has been successfully completed and confirmed.</li>\r\n  <li>Membership validity follows the duration stated in the selected membership option.</li>\r\n  <li>Unused class quota may expire when the membership period ends.</li>\r\n  <li>Unlimited memberships may provide unlimited class access during the applicable membership period, subject to class availability and booking requirements.</li>\r\n</ul>\r\n\r\n<p>\r\n  YogaRoots reserves the right to update membership packages, pricing, benefits, availability, or terms from time to time.\r\n</p>\r\n\r\n<h3>4. Membership Options</h3>\r\n\r\n<p>\r\n  A membership package may contain one or more membership options. Each option may have its own price, duration, and class quota.\r\n</p>\r\n\r\n<p>\r\n  When purchasing a membership, you are responsible for reviewing the selected option before completing your payment.\r\n</p>\r\n\r\n<p>\r\n  The membership option selected at checkout determines the applicable price, duration, quota, and benefits associated with your membership.\r\n</p>\r\n\r\n<h3>5. Class Booking</h3>\r\n\r\n<p>\r\n  Class availability is limited and subject to the capacity of each scheduled class.\r\n</p>\r\n\r\n<p>\r\n  Members must complete the booking process through the available YogaRoots booking system before attending a class.\r\n</p>\r\n\r\n<ul>\r\n  <li>A booking is considered confirmed once the booking process has been successfully completed.</li>\r\n  <li>Class availability may change at any time based on capacity.</li>\r\n  <li>Members are encouraged to arrive at least 10 minutes before the scheduled class.</li>\r\n  <li>Late arrival may result in the member being unable to join the class if entering the studio may disturb the ongoing practice.</li>\r\n  <li>Members must follow the instructions provided by the instructor and YogaRoots staff.</li>\r\n</ul>\r\n\r\n<h3>6. Class Cancellation &amp; No-Show</h3>\r\n\r\n<p>\r\n  We understand that plans can change. However, we ask members to cancel their bookings as early as possible so that another member may have the opportunity to attend.\r\n</p>\r\n\r\n<ul>\r\n  <li>Class cancellations must be made through the available YogaRoots booking system.</li>\r\n  <li>Late cancellations may result in the applicable class quota being deducted.</li>\r\n  <li>No-shows may result in the applicable class quota being deducted.</li>\r\n  <li>Repeated cancellations or no-shows may affect future booking privileges.</li>\r\n</ul>\r\n\r\n<p>\r\n  Specific cancellation periods or policies may apply to certain classes, workshops, events, or special programs.\r\n</p>\r\n\r\n<h3>7. Payments</h3>\r\n\r\n<p>\r\n  All prices displayed on the YogaRoots website are stated in Indonesian Rupiah (IDR), unless otherwise specified.\r\n</p>\r\n\r\n<ul>\r\n  <li>A membership or service is considered purchased only after payment has been successfully completed.</li>\r\n  <li>Prices, discounts, and promotional offers may change from time to time.</li>\r\n  <li>Promotional prices may only be available for a specific period or under specific conditions.</li>\r\n  <li>The final amount payable will be displayed during the checkout process before payment is completed.</li>\r\n  <li>Payment transactions may be processed through third-party payment providers.</li>\r\n</ul>\r\n\r\n<p>\r\n  By proceeding with a payment, you agree to the applicable payment terms and conditions provided by YogaRoots and the relevant payment provider.\r\n</p>\r\n\r\n<h3>8. Refunds &amp; Cancellations</h3>\r\n\r\n<p>\r\n  Refund eligibility may depend on the type of purchase, payment status, membership status, booking status, and applicable YogaRoots policies.\r\n</p>\r\n\r\n<p>\r\n  Membership purchases and completed payments may not be refundable unless otherwise stated or required under applicable laws and regulations.\r\n</p>\r\n\r\n<p>\r\n  If you believe that a payment was made incorrectly or you experience a payment-related issue, please contact YogaRoots as soon as possible so that we can review the transaction.\r\n</p>\r\n\r\n<h3>9. Studio Rules</h3>\r\n\r\n<p>\r\n  YogaRoots is a shared space where everyone should feel comfortable, safe, and respected.\r\n</p>\r\n\r\n<p>\r\n  Members are expected to:\r\n</p>\r\n\r\n<ul>\r\n  <li>Respect instructors, staff, and fellow members.</li>\r\n  <li>Keep phones on silent during classes.</li>\r\n  <li>Maintain cleanliness and cleanliness of shared studio areas.</li>\r\n  <li>Return studio equipment after use.</li>\r\n  <li>Follow instructor and staff instructions.</li>\r\n  <li>Avoid behavior that may disturb or make other members uncomfortable.</li>\r\n  <li>Take reasonable care of YogaRoots facilities and equipment.</li>\r\n</ul>\r\n\r\n<p>\r\n  YogaRoots may take reasonable action if a member\'s behavior negatively affects the safety, comfort, or experience of other members.\r\n</p>\r\n\r\n<h3>10. Health &amp; Safety</h3>\r\n\r\n<p>\r\n  Yoga is a physical activity and may involve physical risks. Every member is responsible for practicing according to their own physical ability and condition.\r\n</p>\r\n\r\n<ul>\r\n  <li>Members should inform the instructor about relevant physical limitations, injuries, or conditions before participating.</li>\r\n  <li>Members should not force movements beyond their comfortable limits.</li>\r\n  <li>If you experience pain, dizziness, discomfort, or other concerning symptoms, stop practicing and inform the instructor immediately.</li>\r\n  <li>Members are responsible for determining whether they are physically able to participate in a class.</li>\r\n</ul>\r\n\r\n<p>\r\n  YogaRoots and its instructors are not a substitute for professional medical advice, diagnosis, or treatment.\r\n</p>\r\n\r\n<p>\r\n  If you have concerns about whether yoga or a particular class is suitable for you, we recommend consulting a qualified healthcare professional before participating.\r\n</p>\r\n\r\n<h3>11. Personal Belongings</h3>\r\n\r\n<p>\r\n  Members are responsible for their personal belongings while visiting YogaRoots.\r\n</p>\r\n\r\n<p>\r\n  We recommend keeping valuable items secure and bringing only essential belongings into the studio.\r\n</p>\r\n\r\n<p>\r\n  YogaRoots is not responsible for loss, theft, or damage to personal belongings except where responsibility cannot legally be excluded.\r\n</p>\r\n\r\n<h3>12. Class Schedules &amp; Instructors</h3>\r\n\r\n<p>\r\n  YogaRoots makes reasonable efforts to maintain the published class schedule. However, schedules and instructors may occasionally change due to operational requirements, instructor availability, maintenance, special events, or other circumstances.\r\n</p>\r\n\r\n<p>\r\n  YogaRoots reserves the right to modify, reschedule, replace, or cancel a class when necessary.\r\n</p>\r\n\r\n<p>\r\n  Where reasonably possible, YogaRoots will provide notice of significant schedule changes to affected members.\r\n</p>\r\n\r\n<h3>13. Promotions &amp; Special Offers</h3>\r\n\r\n<p>\r\n  YogaRoots may offer promotional packages, discounts, introductory offers, events, workshops, or other special programs from time to time.\r\n</p>\r\n\r\n<p>\r\n  Each promotion may have its own eligibility requirements, validity period, pricing, limitations, and terms.\r\n</p>\r\n\r\n<ul>\r\n  <li>Promotions may only be available for a limited period.</li>\r\n  <li>Promotions may not be combined with other offers unless explicitly stated.</li>\r\n  <li>Promotional benefits cannot be exchanged for cash unless otherwise stated.</li>\r\n  <li>YogaRoots may modify or discontinue a promotion in accordance with its applicable terms.</li>\r\n</ul>\r\n\r\n<h3>14. Intellectual Property</h3>\r\n\r\n<p>\r\n  All content available on the YogaRoots website, including logos, photographs, graphics, illustrations, text, videos, designs, and other materials, is owned by or licensed to YogaRoots unless otherwise stated.\r\n</p>\r\n\r\n<p>\r\n  You may access and use the content for personal, non-commercial purposes only.\r\n</p>\r\n\r\n<p>\r\n  You may not reproduce, distribute, modify, publish, sell, or commercially use YogaRoots content without prior written permission.\r\n</p>\r\n\r\n<h3>15. Third-Party Services</h3>\r\n\r\n<p>\r\n  YogaRoots may use or provide access to third-party services, including payment providers, communication platforms, analytics services, authentication services, and other technology providers.\r\n</p>\r\n\r\n<p>\r\n  Your use of third-party services may be subject to the terms and policies of the relevant third-party provider.\r\n</p>\r\n\r\n<p>\r\n  YogaRoots is not responsible for the policies, availability, or practices of third-party services that are outside our control.\r\n</p>\r\n\r\n<h3>16. Website Availability</h3>\r\n\r\n<p>\r\n  YogaRoots aims to keep the website and services available and functioning properly. However, we cannot guarantee that the website will always be available, uninterrupted, or free from errors.\r\n</p>\r\n\r\n<p>\r\n  Website availability may occasionally be affected by maintenance, technical issues, network problems, security incidents, or circumstances beyond our reasonable control.\r\n</p>\r\n\r\n<h3>17. Limitation of Responsibility</h3>\r\n\r\n<p>\r\n  YogaRoots strives to provide a safe, comfortable, and high-quality experience for all members.\r\n</p>\r\n\r\n<p>\r\n  However, participation in yoga and physical activities involves inherent risks. Members are responsible for practicing within their own capabilities and following reasonable instructions provided by instructors and staff.\r\n</p>\r\n\r\n<p>\r\n  Nothing in these Terms &amp; Conditions is intended to exclude or limit any rights, responsibilities, or liabilities that cannot legally be excluded or limited under applicable laws and regulations.\r\n</p>\r\n\r\n<h3>18. Changes to These Terms</h3>\r\n\r\n<p>\r\n  YogaRoots may update these Terms &amp; Conditions from time to time to reflect changes in our services, business practices, technology, or applicable laws and regulations.\r\n</p>\r\n\r\n<p>\r\n  Any changes will be published on this page, and the \"Last Updated\" date will be revised accordingly.\r\n</p>\r\n\r\n<p>\r\n  We encourage you to review this page periodically to stay informed about the terms that apply to your use of YogaRoots services.\r\n</p>\r\n\r\n<h3>19. Contact Us</h3>\r\n\r\n<p>\r\n  If you have any questions about these Terms &amp; Conditions, membership, class bookings, payments, or other YogaRoots services, please contact us through the following channels:\r\n</p>\r\n\r\n<p>\r\n  <strong>YogaRoots</strong>\r\n</p>\r\n\r\n<p>\r\n  <strong>Email:</strong>&nbsp;\r\n</p>\r\n\r\n<p>\r\n  <strong>Phone / WhatsApp:</strong> +62 813 2122 1270\r\n</p>\r\n\r\n<p>\r\n  <strong>Address:</strong> Roots Prasasta Building, Jl. Kawi Raya No.37, RT.6/RW.2, Guntur, Setiabudi, South Jakarta City, Jakarta 12980\r\n</p>\r\n\r\n<p>\r\n  We will do our best to assist you and provide the information you need regarding our services, memberships, bookings, and these Terms &amp; Conditions.\r\n</p>', 'pages/UYCMzdX1OfuyrVRPYwicwNu1JZnHYBZhRSUjL4ki.jpg', 1, '2026-09-12 17:00:00', '787b72ea-59d0-4d54-848b-c200bddafdd2', 0, '2026-09-13 03:01:40', '2026-09-13 03:01:40');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'menu.main-menu', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(2, 'menu.role-permission', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(3, 'menu.access-management', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(4, 'dashboard.index', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(5, 'user.index', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(6, 'user.store', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(7, 'user.update', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(8, 'user.destroy', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(9, 'menu-group.index', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(10, 'menu-group.store', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(11, 'menu-group.update', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(12, 'menu-group.destroy', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(13, 'menu-item.index', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(14, 'menu-item.store', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(15, 'menu-item.update', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(16, 'menu-item.destroy', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(17, 'route.index', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(18, 'route.store', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(19, 'route.update', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(20, 'route.destroy', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(21, 'role.index', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(22, 'role.store', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(23, 'role.update', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(24, 'role.destroy', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(25, 'permission.index', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(26, 'permission.store', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(27, 'permission.update', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(28, 'permission.destroy', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(29, 'faq.destroy', 'web', '2024-09-27 00:07:55', '2025-09-16 01:45:11'),
(30, 'faq.index', 'web', '2024-09-27 00:08:52', '2025-09-16 01:45:00'),
(31, 'faq.store', 'web', '2024-09-27 00:09:11', '2025-09-16 01:45:36'),
(32, 'faq.update', 'web', '2024-09-27 00:09:36', '2025-09-16 01:45:20'),
(33, 'menu.main-portofolio', 'web', '2024-09-27 00:11:21', '2024-09-27 00:11:21'),
(38, 'categories.destroy', 'web', '2024-09-29 12:28:15', '2024-10-15 13:50:56'),
(39, 'categories.index', 'web', '2024-09-29 12:28:26', '2024-10-15 13:51:03'),
(40, 'categories.store', 'web', '2024-09-29 12:28:42', '2024-10-15 13:51:13'),
(41, 'categories.update', 'web', '2024-09-29 12:28:54', '2024-10-15 13:51:20'),
(46, 'banner.destroy', 'web', '2024-09-30 12:05:12', '2024-10-13 22:29:29'),
(47, 'banner.index', 'web', '2024-09-30 12:05:28', '2024-10-13 22:29:37'),
(48, 'banner.store', 'web', '2024-09-30 12:05:41', '2024-10-13 22:29:45'),
(49, 'banner.update', 'web', '2024-09-30 12:05:59', '2024-10-13 22:29:53'),
(50, 'agendas.destroy', 'web', '2024-10-15 14:19:19', '2024-10-15 14:19:19'),
(51, 'agendas.create', 'web', '2024-10-15 14:19:37', '2024-10-15 14:20:03'),
(52, 'agendas.index', 'web', '2024-10-15 14:20:16', '2024-10-15 14:20:16'),
(53, 'agendas.store', 'web', '2024-10-15 14:20:34', '2024-10-15 14:20:34'),
(54, 'agendas.update', 'web', '2024-10-15 14:20:52', '2024-10-15 14:20:52'),
(55, 'dashboard.form', 'web', '2025-07-21 15:03:35', '2025-07-21 16:36:22'),
(60, 'poll.destroy', 'web', '2025-07-21 17:50:21', '2025-09-17 22:51:57'),
(65, 'poll.index', 'web', '2025-07-21 17:50:33', '2025-09-17 22:52:13'),
(70, 'poll.store', 'web', '2025-07-21 17:50:49', '2025-09-17 22:52:25'),
(75, 'poll.update', 'web', '2025-07-21 17:51:14', '2025-09-17 22:52:37'),
(85, 'account.index', 'web', '2025-07-22 23:35:48', '2025-07-22 23:35:48'),
(90, 'account.update', 'web', '2025-07-22 23:36:13', '2025-07-22 23:36:13'),
(125, 'document-categories.destroy', 'web', '2025-07-25 16:48:18', '2026-09-15 22:15:08'),
(130, 'document-categories.index', 'web', '2025-07-25 16:48:48', '2026-09-15 22:15:20'),
(135, 'document-categories.store', 'web', '2025-07-25 16:49:09', '2026-09-15 22:15:30'),
(140, 'document-categories.update', 'web', '2025-07-25 16:49:23', '2026-09-15 22:15:42'),
(145, 'layanan.kontak', 'web', '2025-07-27 23:46:01', '2025-07-27 23:46:01'),
(147, 'pages.create', 'web', '2025-09-17 23:27:58', '2025-09-17 23:27:58'),
(148, 'pages.destroy', 'web', '2025-09-17 23:28:08', '2025-09-17 23:28:08'),
(149, 'pages.index', 'web', '2025-09-17 23:28:19', '2025-09-17 23:28:19'),
(150, 'pages.store', 'web', '2025-09-17 23:28:28', '2025-09-17 23:28:28'),
(151, 'pages.update', 'web', '2025-09-17 23:28:36', '2025-09-17 23:28:36'),
(163, 'services.index', 'web', '2025-11-11 03:38:59', '2026-10-07 13:21:25'),
(164, 'services.destroy', 'web', '2025-11-11 03:39:23', '2026-10-07 13:21:11'),
(165, 'services.update', 'web', '2025-11-11 03:39:36', '2026-10-07 13:21:56'),
(166, 'services.store', 'web', '2025-11-11 03:39:47', '2026-10-07 13:21:38'),
(172, 'classes.destroy', 'web', '2026-09-02 14:45:03', '2026-09-02 14:45:03'),
(173, 'classes.index', 'web', '2026-09-02 14:45:18', '2026-09-02 14:45:18'),
(174, 'classes.store', 'web', '2026-09-02 14:45:44', '2026-09-02 14:45:44'),
(175, 'classes.update', 'web', '2026-09-02 14:45:59', '2026-09-02 14:45:59'),
(176, 'dashboard.submitSumber', 'web', '2026-09-04 07:15:06', '2026-09-04 07:15:06'),
(177, 'classes.create', 'web', '2026-09-05 23:52:57', '2026-09-05 23:52:57'),
(178, 'classes.edit', 'web', '2026-09-05 23:53:12', '2026-09-05 23:53:12'),
(185, 'pengguna.index', 'web', '2026-09-06 20:38:51', '2026-09-06 20:38:51'),
(186, 'pengguna.export', 'web', '2026-09-06 20:39:08', '2026-09-06 20:39:08'),
(187, 'documents.index', 'web', '2026-09-08 06:29:57', '2026-09-16 00:37:55'),
(188, 'documents.destroy', 'web', '2026-09-08 06:30:24', '2026-09-16 00:37:43'),
(189, 'documents.create', 'web', '2026-09-08 06:30:57', '2026-09-16 00:37:29'),
(190, 'documents.store', 'web', '2026-09-08 06:31:17', '2026-09-16 00:38:04'),
(191, 'documents.update', 'web', '2026-09-08 06:31:34', '2026-09-16 00:38:15'),
(197, 'menu.keamanan', 'web', '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(198, 'login-activity.index', 'web', '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(199, 'login-activity.destroy', 'web', '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(200, 'audit-log.index', 'web', '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(201, 'audit-log.destroy', 'web', '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(202, 'failed-login.index', 'web', '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(203, 'failed-login.destroy', 'web', '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(204, 'login-lockout.index', 'web', '2026-09-17 03:25:22', '2026-09-17 03:25:22'),
(205, 'login-lockout.destroy', 'web', '2026-09-17 03:25:22', '2026-09-17 03:25:22'),
(206, 'website-identity.edit', 'web', '2026-09-18 02:42:55', '2026-09-18 02:42:55'),
(207, 'website-identity.update', 'web', '2026-09-18 02:42:55', '2026-09-18 02:42:55'),
(208, 'menu.website-config', 'web', '2026-09-18 02:42:55', '2026-09-18 02:42:55'),
(209, 'aduans.index', 'web', '2026-09-19 00:53:26', '2026-09-19 00:53:26'),
(210, 'aduans.store', 'web', '2026-09-19 00:53:26', '2026-09-19 00:53:26'),
(211, 'aduans.show', 'web', '2026-09-19 01:09:38', '2026-09-19 01:09:38'),
(212, 'aduans.update', 'web', '2026-09-19 01:09:38', '2026-09-19 01:09:38'),
(213, 'aduans.destroy', 'web', '2026-09-19 01:09:38', '2026-09-19 01:09:38'),
(214, 'aduans.create', 'web', '2026-09-19 02:10:07', '2026-09-19 02:10:07'),
(215, 'aduans.edit', 'web', '2026-09-19 02:10:28', '2026-09-19 02:10:28'),
(216, 'aduans.restore', 'web', '2026-09-19 02:10:30', '2026-09-19 02:10:30'),
(217, 'aduans.forceDelete', 'web', '2026-09-19 02:10:30', '2026-09-19 02:10:30'),
(218, 'aduans.tindaklanjut.store', 'web', '2026-09-19 04:15:47', '2026-09-19 04:15:47'),
(219, 'aduans.tindaklanjut.destroy', 'web', '2026-09-19 04:15:47', '2026-09-19 04:15:47'),
(220, 'aduans.export', 'web', '2026-09-19 04:22:17', '2026-09-19 04:22:17'),
(221, 'aduans.arsip', 'web', '2026-09-19 04:53:19', '2026-09-19 04:53:19'),
(222, 'aduans.batalArsip', 'web', '2026-09-19 04:53:19', '2026-09-19 04:53:19'),
(223, 'health.page', 'web', '2026-09-20 00:15:45', '2026-09-20 00:15:45'),
(224, 'agendas.approve', 'web', '2026-10-07 14:04:12', '2026-10-07 14:04:12');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `polls`
--

CREATE TABLE `polls` (
  `uuid` char(36) NOT NULL,
  `question` varchar(255) NOT NULL,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`options`)),
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `polls`
--

INSERT INTO `polls` (`uuid`, `question`, `options`, `status`, `created_at`, `updated_at`) VALUES
('022cc9a2-dd4a-4dd2-8063-391ae8831214', 'Bagaimana menurut Anda terkait informasi yang tersedia pada website kami?', '[\"Baik\",\"Cukup Baik\",\"Kurang\"]', 'active', '2025-11-11 06:16:57', '2025-11-11 06:16:57');

-- --------------------------------------------------------

--
-- Table structure for table `poll_votes`
--

CREATE TABLE `poll_votes` (
  `uuid` char(36) NOT NULL,
  `poll_uuid` char(36) NOT NULL,
  `option` varchar(255) NOT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'super-admin', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(2, 'user', 'web', '2024-09-26 23:27:05', '2024-09-26 23:27:05'),
(3, 'admin', 'web', '2024-09-27 01:40:58', '2024-09-27 01:40:58'),
(5, 'opd', 'web', '2025-07-21 13:29:16', '2026-10-07 13:12:14');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 3),
(2, 1),
(3, 1),
(3, 3),
(4, 1),
(4, 2),
(4, 3),
(4, 5),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(13, 3),
(14, 1),
(14, 3),
(15, 1),
(15, 3),
(16, 1),
(16, 3),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(29, 3),
(30, 1),
(30, 3),
(31, 1),
(31, 3),
(32, 1),
(32, 3),
(33, 1),
(33, 3),
(38, 1),
(38, 3),
(39, 1),
(39, 3),
(40, 1),
(40, 3),
(41, 1),
(41, 3),
(46, 1),
(46, 3),
(47, 1),
(47, 3),
(48, 1),
(48, 3),
(49, 1),
(49, 3),
(50, 1),
(50, 3),
(51, 1),
(51, 3),
(51, 5),
(52, 1),
(52, 3),
(52, 5),
(53, 1),
(53, 3),
(53, 5),
(54, 1),
(54, 3),
(54, 5),
(55, 1),
(55, 2),
(55, 3),
(55, 5),
(60, 1),
(60, 3),
(65, 1),
(65, 3),
(70, 1),
(70, 3),
(75, 1),
(75, 3),
(85, 1),
(85, 2),
(85, 3),
(85, 5),
(90, 1),
(90, 2),
(90, 3),
(90, 5),
(125, 1),
(125, 3),
(130, 1),
(130, 3),
(135, 1),
(135, 3),
(140, 1),
(140, 3),
(145, 1),
(145, 3),
(147, 1),
(147, 3),
(148, 1),
(148, 3),
(149, 1),
(149, 3),
(150, 1),
(150, 3),
(151, 1),
(151, 3),
(163, 1),
(163, 3),
(164, 1),
(164, 3),
(165, 1),
(165, 3),
(166, 1),
(166, 3),
(172, 1),
(172, 3),
(172, 5),
(173, 1),
(173, 3),
(173, 5),
(174, 1),
(174, 3),
(174, 5),
(175, 1),
(175, 3),
(175, 5),
(176, 2),
(177, 1),
(177, 3),
(177, 5),
(178, 1),
(178, 3),
(178, 5),
(185, 1),
(185, 3),
(186, 1),
(186, 3),
(187, 1),
(187, 3),
(188, 1),
(188, 3),
(189, 1),
(189, 3),
(190, 1),
(190, 3),
(191, 1),
(191, 3),
(197, 1),
(197, 3),
(198, 1),
(198, 3),
(199, 1),
(199, 3),
(200, 1),
(200, 3),
(201, 1),
(201, 3),
(202, 1),
(202, 3),
(203, 1),
(203, 3),
(204, 1),
(204, 3),
(205, 1),
(205, 3),
(206, 1),
(206, 3),
(207, 1),
(207, 3),
(208, 1),
(208, 3),
(209, 1),
(209, 2),
(209, 3),
(209, 5),
(210, 1),
(210, 2),
(210, 3),
(210, 5),
(211, 1),
(211, 2),
(211, 3),
(211, 5),
(212, 1),
(212, 2),
(212, 3),
(213, 1),
(213, 2),
(213, 3),
(214, 1),
(214, 2),
(214, 3),
(214, 5),
(215, 1),
(215, 3),
(216, 1),
(216, 2),
(216, 3),
(217, 1),
(217, 3),
(218, 1),
(218, 3),
(218, 5),
(219, 1),
(219, 3),
(219, 5),
(220, 1),
(220, 3),
(221, 1),
(221, 3),
(222, 1),
(222, 3),
(223, 1),
(223, 3),
(223, 5),
(224, 1),
(224, 3);

-- --------------------------------------------------------

--
-- Table structure for table `routes`
--

CREATE TABLE `routes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `route` varchar(255) NOT NULL,
  `permission_name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `description` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `routes`
--

INSERT INTO `routes` (`id`, `route`, `permission_name`, `status`, `description`, `created_at`, `updated_at`) VALUES
(1, 'dashboard.index', 'dashboard.index', 1, NULL, NULL, NULL),
(2, 'user.index', 'user.index', 1, NULL, NULL, NULL),
(3, 'user.store', 'user.store', 1, NULL, NULL, NULL),
(4, 'user.update', 'user.update', 1, NULL, NULL, NULL),
(5, 'user.destroy', 'user.destroy', 1, NULL, NULL, NULL),
(6, 'menu.index', 'menu-group.index', 1, NULL, NULL, NULL),
(7, 'menu.store', 'menu-group.store', 1, NULL, NULL, NULL),
(8, 'menu.update', 'menu-group.update', 1, NULL, NULL, NULL),
(9, 'menu.destroy', 'menu-group.destroy', 1, NULL, NULL, NULL),
(10, 'menu.item.index', 'menu-item.index', 1, NULL, NULL, NULL),
(11, 'menu.item.store', 'menu-item.store', 1, NULL, NULL, NULL),
(12, 'menu.item.update', 'menu-item.update', 1, NULL, NULL, NULL),
(13, 'menu.item.destroy', 'menu-item.destroy', 1, NULL, NULL, NULL),
(14, 'route.index', 'route.index', 1, NULL, NULL, NULL),
(15, 'route.store', 'route.store', 1, NULL, NULL, NULL),
(16, 'route.update', 'route.update', 1, NULL, NULL, NULL),
(17, 'route.destroy', 'route.destroy', 1, NULL, NULL, NULL),
(18, 'role.index', 'role.index', 1, NULL, NULL, NULL),
(19, 'role.store', 'role.store', 1, NULL, NULL, NULL),
(20, 'role.update', 'role.update', 1, NULL, NULL, NULL),
(21, 'role.destroy', 'role.destroy', 1, NULL, NULL, NULL),
(22, 'permission.index', 'permission.index', 1, NULL, NULL, NULL),
(23, 'permission.store', 'permission.store', 1, NULL, NULL, NULL),
(24, 'permission.update', 'permission.update', 1, NULL, NULL, NULL),
(25, 'permission.destroy', 'permission.destroy', 1, NULL, NULL, NULL),
(26, 'faq.index', 'faq.index', 1, NULL, '2024-09-27 00:20:45', '2024-09-27 00:20:45'),
(27, 'faq.store', 'faq.store', 1, NULL, '2024-09-27 01:45:13', '2024-09-27 01:45:13'),
(28, 'faq.update', 'faq.update', 1, NULL, '2024-09-27 01:45:36', '2024-09-27 01:45:52'),
(29, 'faq.destroy', 'faq.destroy', 1, NULL, '2024-09-27 01:46:45', '2024-09-27 01:46:45'),
(34, 'categories.destroy', 'categories.destroy', 1, NULL, '2024-09-29 12:31:56', '2024-10-15 13:51:53'),
(35, 'categories.index', 'categories.index', 1, NULL, '2024-09-29 12:32:17', '2024-10-15 13:52:11'),
(36, 'categories.store', 'categories.store', 1, NULL, '2024-09-29 12:32:37', '2024-10-15 13:52:26'),
(37, 'categories.update', 'categories.update', 1, NULL, '2024-09-29 12:32:56', '2024-10-15 13:52:45'),
(42, 'banner.destroy', 'banner.destroy', 1, NULL, '2024-09-30 12:06:31', '2024-10-13 22:36:22'),
(43, 'banner.index', 'banner.index', 1, NULL, '2024-09-30 12:06:55', '2024-10-13 22:36:39'),
(44, 'banner.store', 'banner.store', 1, NULL, '2024-09-30 12:07:34', '2024-10-13 22:37:03'),
(45, 'banner.update', 'banner.update', 1, NULL, '2024-09-30 12:07:57', '2024-10-13 22:37:24'),
(46, 'agendas.create', 'agendas.create', 1, NULL, '2024-10-15 14:22:17', '2024-10-15 14:22:17'),
(47, 'agendas.destroy', 'agendas.destroy', 1, NULL, '2024-10-15 14:22:51', '2024-10-15 14:22:51'),
(48, 'agendas.index', 'agendas.index', 1, NULL, '2024-10-15 14:23:15', '2024-10-15 14:23:15'),
(49, 'agendas.store', 'agendas.store', 1, NULL, '2024-10-15 14:23:49', '2024-10-15 14:23:49'),
(50, 'agendas.update', 'agendas.update', 1, NULL, '2024-10-15 14:24:09', '2024-10-15 14:24:09'),
(55, 'dashboard.submitSumber', 'dashboard.form', 1, NULL, '2025-07-21 16:35:06', '2025-07-21 16:35:06'),
(60, 'poll.destroy', 'poll.destroy', 1, NULL, '2025-07-21 17:53:17', '2025-09-17 22:55:14'),
(65, 'polls.index', 'poll.index', 1, NULL, '2025-07-21 17:53:47', '2025-09-17 22:54:20'),
(70, 'poll.store', 'poll.store', 1, NULL, '2025-07-21 17:54:16', '2025-09-17 22:55:28'),
(75, 'poll.update', 'poll.update', 1, NULL, '2025-07-21 17:54:35', '2025-09-17 22:55:42'),
(85, 'account.index', 'account.index', 1, NULL, '2025-07-22 23:36:37', '2025-07-22 23:36:37'),
(90, 'account.update', 'account.update', 1, NULL, '2025-07-22 23:37:03', '2025-07-22 23:37:03'),
(120, 'document-categories.index', 'document-categories.index', 1, NULL, '2025-07-25 16:50:03', '2026-09-15 22:36:36'),
(125, 'document-categories.destroy', 'document-categories.destroy', 1, NULL, '2025-07-25 16:50:24', '2026-09-15 22:36:11'),
(130, 'document-categories.store', 'document-categories.store', 1, NULL, '2025-07-25 16:50:51', '2026-09-15 22:36:58'),
(135, 'document-categories.update', 'document-categories.update', 1, NULL, '2025-07-25 16:51:29', '2026-09-15 22:37:27'),
(140, 'layanan.kontak', 'layanan.kontak', 1, NULL, '2025-07-27 23:47:08', '2025-07-27 23:47:08'),
(145, 'banner.update', 'banner.update', 1, NULL, '2025-08-07 12:52:06', '2025-08-07 12:52:06'),
(147, 'pages.create', 'pages.create', 1, NULL, '2025-09-17 23:29:27', '2025-09-17 23:29:27'),
(148, 'pages.index', 'pages.index', 1, NULL, '2025-09-17 23:29:41', '2025-09-17 23:29:41'),
(149, 'pages.store', 'pages.store', 1, NULL, '2025-09-17 23:29:59', '2025-09-17 23:29:59'),
(150, 'pages.destroy', 'pages.destroy', 1, NULL, '2025-09-17 23:30:31', '2025-09-17 23:30:31'),
(151, 'pages.update', 'pages.update', 1, NULL, '2025-09-17 23:30:45', '2025-09-17 23:30:45'),
(163, 'services.destroy', 'services.destroy', 1, NULL, '2025-11-11 03:40:24', '2026-10-07 13:28:51'),
(164, 'services.index', 'services.index', 1, NULL, '2025-11-11 03:40:41', '2026-10-07 13:29:11'),
(165, 'services.store', 'services.store', 1, NULL, '2025-11-11 03:40:58', '2026-10-07 13:29:30'),
(166, 'services.update', 'services.update', 1, NULL, '2025-11-11 03:42:13', '2026-10-07 13:29:55'),
(176, 'dashboard.submitSumber', 'dashboard.submitSumber', 1, NULL, '2026-09-04 07:15:41', '2026-09-04 07:15:41'),
(185, 'pengguna.index', 'pengguna.index', 1, NULL, '2026-09-06 20:39:23', '2026-09-06 20:39:23'),
(186, 'pengguna.export', 'pengguna.export', 1, NULL, '2026-09-06 20:39:35', '2026-09-06 20:39:35'),
(187, 'documents.create', 'documents.create', 1, NULL, '2026-09-08 06:32:44', '2026-09-16 00:54:07'),
(188, 'documents.index', 'documents.index', 1, NULL, '2026-09-08 06:32:59', '2026-09-16 00:54:20'),
(189, 'documents.destroy', 'documents.destroy', 1, NULL, '2026-09-08 06:33:15', '2026-09-16 00:53:57'),
(190, 'documents.update', 'documents.update', 1, NULL, '2026-09-08 06:33:33', '2026-09-16 00:55:02'),
(191, 'documents.store', 'documents.store', 1, NULL, '2026-09-08 06:33:55', '2026-09-16 00:54:38'),
(194, 'aduans.index', 'aduans.index', 1, NULL, '2026-09-13 13:24:29', '2026-09-19 01:07:28'),
(196, 'orders.show', 'orders.show', 1, NULL, '2026-09-13 13:24:58', '2026-09-13 13:24:58'),
(197, 'security.login-activity.index', 'login-activity.index', 1, NULL, '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(198, 'security.login-activity.destroy', 'login-activity.destroy', 1, NULL, '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(199, 'security.audit-log.index', 'audit-log.index', 1, NULL, '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(200, 'security.audit-log.destroy', 'audit-log.destroy', 1, NULL, '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(201, 'security.audit-log.clear', 'audit-log.destroy', 1, NULL, '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(202, 'security.failed-login.index', 'failed-login.index', 1, NULL, '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(203, 'security.failed-login.destroy', 'failed-login.destroy', 1, NULL, '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(204, 'security.failed-login.clear', 'failed-login.destroy', 1, NULL, '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(205, 'security.login-lockout.index', 'login-lockout.index', 1, NULL, '2026-09-17 03:25:22', '2026-09-17 03:25:22'),
(206, 'security.login-lockout.destroy', 'login-lockout.destroy', 1, NULL, '2026-09-17 03:25:22', '2026-09-17 03:25:22'),
(207, 'website-identity.edit', 'website-identity.edit', 1, NULL, '2026-09-18 02:42:55', '2026-09-18 02:42:55'),
(208, 'website-identity.update', 'website-identity.update', 1, NULL, '2026-09-18 02:42:55', '2026-09-18 02:42:55'),
(209, 'aduans.store', 'aduans.store', 1, NULL, '2026-09-19 01:09:39', '2026-09-19 01:09:39'),
(210, 'aduans.show', 'aduans.show', 1, NULL, '2026-09-19 01:09:39', '2026-09-19 01:09:39'),
(211, 'aduans.update', 'aduans.update', 1, NULL, '2026-09-19 01:09:39', '2026-09-19 01:09:39'),
(212, 'aduans.destroy', 'aduans.destroy', 1, NULL, '2026-09-19 01:09:39', '2026-09-19 01:09:39'),
(213, 'aduans.create', 'aduans.store', 1, NULL, '2026-09-19 01:27:52', '2026-09-19 01:27:52'),
(214, 'aduans.edit', 'aduans.update', 1, NULL, '2026-09-19 01:27:52', '2026-09-19 01:27:52'),
(215, 'aduans.restore', 'aduans.restore', 1, NULL, '2026-09-19 02:10:31', '2026-09-19 02:10:31'),
(216, 'aduans.forceDestroy', 'aduans.forceDelete', 1, NULL, '2026-09-19 02:10:31', '2026-09-19 02:10:31'),
(217, 'aduans.tindak-lanjut.store', 'aduans.tindaklanjut.store', 1, NULL, '2026-09-19 04:15:47', '2026-09-19 04:15:47'),
(218, 'aduans.tindak-lanjut.destroy', 'aduans.tindaklanjut.destroy', 1, NULL, '2026-09-19 04:15:47', '2026-09-19 04:15:47'),
(219, 'aduans.exportPdf', 'aduans.export', 1, NULL, '2026-09-19 04:22:18', '2026-09-19 04:22:18'),
(220, 'aduans.cekDuplikat', 'aduans.index', 1, NULL, '2026-09-19 04:53:20', '2026-09-19 04:53:20'),
(221, 'aduans.arsip', 'aduans.arsip', 1, NULL, '2026-09-19 04:53:20', '2026-09-19 04:53:20'),
(222, 'aduans.batalArsip', 'aduans.batalArsip', 1, NULL, '2026-09-19 04:53:20', '2026-09-19 04:53:20'),
(223, 'aduans.rate', 'aduans.update', 1, NULL, '2026-09-19 05:26:07', '2026-09-19 05:26:07'),
(225, 'agendas.bulkDestroy', 'agendas.destroy', 1, 'Proteksi hapus massal (dibuat otomatis).', '2026-10-07 11:43:40', '2026-10-07 11:43:40'),
(226, 'documents.bulkDestroy', 'documents.destroy', 1, 'Proteksi hapus massal (dibuat otomatis).', '2026-10-07 11:43:40', '2026-10-07 11:43:40'),
(227, 'faq.bulkDestroy', 'faq.destroy', 1, 'Proteksi hapus massal (dibuat otomatis).', '2026-10-07 11:43:40', '2026-10-07 11:43:40'),
(228, 'document-categories.bulkDestroy', 'document-categories.destroy', 1, 'Proteksi hapus massal (dibuat otomatis).', '2026-10-07 11:43:40', '2026-10-07 11:43:40'),
(230, 'aduans.bulkDestroy', 'aduans.destroy', 1, 'Proteksi hapus massal (dibuat otomatis).', '2026-10-07 11:43:40', '2026-10-07 11:43:40'),
(231, 'aduans.bulkRestore', 'aduans.restore', 1, 'Proteksi hapus massal (dibuat otomatis).', '2026-10-07 11:43:40', '2026-10-07 11:43:40'),
(232, 'security.audit-log.bulkDestroy', 'audit-log.destroy', 1, 'Proteksi hapus massal (dibuat otomatis).', '2026-10-07 11:43:40', '2026-10-07 11:43:40'),
(233, 'security.failed-login.bulkDestroy', 'failed-login.destroy', 1, 'Proteksi hapus massal (dibuat otomatis).', '2026-10-07 11:43:40', '2026-10-07 11:43:40'),
(234, 'security.login-activity.bulkDestroy', 'login-activity.destroy', 1, 'Proteksi hapus massal (dibuat otomatis).', '2026-10-07 11:43:40', '2026-10-07 11:43:40'),
(235, 'security.login-lockout.bulkDestroy', 'login-lockout.destroy', 1, 'Proteksi hapus massal (dibuat otomatis).', '2026-10-07 11:43:40', '2026-10-07 11:43:40'),
(236, 'agendas.approve', 'agendas.approve', 1, 'Approval agenda OPD', '2026-10-07 09:04:12', '2026-10-07 09:04:12'),
(237, 'agendas.reject', 'agendas.approve', 1, 'Approval agenda OPD', '2026-10-07 09:04:12', '2026-10-07 09:04:12');

-- --------------------------------------------------------

--
-- Table structure for table `seo`
--

CREATE TABLE `seo` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `description` longtext DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `robots` varchar(255) DEFAULT NULL,
  `canonical_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `seo`
--

INSERT INTO `seo` (`id`, `description`, `title`, `image`, `author`, `robots`, `canonical_url`, `created_at`, `updated_at`, `model_type`, `model_id`) VALUES
(1, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-16 00:51:45', '2025-09-16 00:51:45', 'App\\Models\\Category', '0f6f80de-b410-4b7a-88b2-08411c5a063c'),
(2, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-16 01:03:16', '2025-09-16 01:03:16', 'App\\Models\\Category', '34103609-8116-4baf-bd17-557fc6989e8e'),
(3, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-16 01:03:22', '2025-09-16 01:03:22', 'App\\Models\\Category', '2162d145-9ef3-4e2f-8c55-81971a015bc5'),
(4, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-16 01:03:27', '2025-09-16 01:03:27', 'App\\Models\\Category', 'bb006a6e-36bc-48cb-a84f-2a562489bb54'),
(5, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-16 01:03:50', '2025-09-16 01:03:50', 'App\\Models\\Category', 'f16ac019-a6b8-4ca6-984a-6c87624d06e9'),
(6, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-16 01:03:56', '2025-09-16 01:03:56', 'App\\Models\\Category', 'd9c59085-6120-487f-bd89-8924f043b70f'),
(7, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-16 01:04:08', '2025-09-16 01:04:08', 'App\\Models\\Category', 'cbe3bfd5-2852-4616-ad1e-e64510623354'),
(8, 'dasdsa', 'dsadas', 'images/BkDwT5z1GU7ge3jsY7cbjqxitH9GVI5bGWrVJXVf.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/dsadas', '2025-09-21 21:24:40', '2025-09-21 21:24:40', 'App\\Models\\Article', 'a7a1ddfd-e34d-4a9b-b1f1-8c3b3f980101'),
(9, 'das', 'dsad', 'images/vOOiSvvssJ0m7N5ZuDV1kqiOAlmAFT1LFkrWIVZM.png', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/dsad', '2025-09-21 23:45:55', '2025-09-21 23:45:55', 'App\\Models\\Article', '9fea3519-9e45-42b6-b0a7-4eda3d36336c'),
(10, 'Kunjungan kerja Pj Wali Kota Bekasi Gani Muhamad didampingi Istri Yolla Kusuma', 'Dedikasi Guru SLB, Pj Wali Kota Bekasi Panjatkan Syukur dan Bangga', 'images/dqG6N4LdZt2BpFYbkRYEipCXhu49cY8Hn4feSGYT.jpg', 'Admin Sekolah', 'index', 'http://103.76.148.154:8000/backend/articles/dedikasi-guru-slb-pj-wali-kota-bekasi-panjatkan-syukur-dan-bangga', '2025-09-29 08:50:56', '2025-09-29 08:50:56', 'App\\Models\\Article', '225a5ce5-27a3-4ebe-a15a-1151ea17f0b2'),
(11, 'Dorong UMKM Naik Kelas, Pemkot Bekasi Gelar Sosialisasi Program KUR Bank BJB', 'Dorong UMKM Naik Kelas, Pemkot Bekasi Gelar Sosialisasi Program KUR Bank BJB', 'images/4Y8xWeFxXgrHTaGGrRR49cTzRgBbnylh8RT8pUcw.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/dorong-umkm-naik-kelas-pemkot-bekasi-gelar-sosialisasi-program-kur-bank-bjb', '2025-09-30 04:31:02', '2025-09-30 04:31:02', 'App\\Models\\Article', 'e26fc79e-6747-4852-8e1b-711cae82c811'),
(12, 'Dorong UMKM Naik Kelas, Pemkot Bekasi Gelar Sosialisasi Program KUR Bank BJB', 'Dorong UMKM Naik Kelas, Pemkot Bekasi Gelar Sosialisasi Program KUR Bank BJB', 'images/4Y8xWeFxXgrHTaGGrRR49cTzRgBbnylh8RT8pUcw.jpg', 'Admin Sekolah', 'index', 'http://103.76.148.154:8000/backend/articles/dorong-umkm-naik-kelas-pemkot-bekasi-gelar-sosialisasi-program-kur-bank-bjb', '2025-09-30 04:36:50', '2025-09-30 04:36:50', 'App\\Models\\Article', 'e26fc79e-6747-4852-8e1b-711cae82c811'),
(13, 'Dorong UMKM Naik Kelas, Pemkot Bekasi Gelar Sosialisasi Program KUR Bank BJB', 'Dorong UMKM Naik Kelas, Pemkot Bekasi Gelar Sosialisasi Program KUR Bank BJB', 'images/4Y8xWeFxXgrHTaGGrRR49cTzRgBbnylh8RT8pUcw.jpg', 'Admin Sekolah', 'index', 'http://103.76.148.154:8000/backend/articles/dorong-umkm-naik-kelas-pemkot-bekasi-gelar-sosialisasi-program-kur-bank-bjb', '2025-09-30 04:37:18', '2025-09-30 04:37:18', 'App\\Models\\Article', 'e26fc79e-6747-4852-8e1b-711cae82c811'),
(14, 'Dorong UMKM Naik Kelas, Pemkot Bekasi Gelar Sosialisasi Program KUR Bank BJB', 'Dorong UMKM Naik Kelas, Pemkot Bekasi Gelar Sosialisasi Program KUR Bank BJB', 'images/4Y8xWeFxXgrHTaGGrRR49cTzRgBbnylh8RT8pUcw.jpg', 'Admin Sekolah', 'index', 'http://103.76.148.154:8000/backend/articles/dorong-umkm-naik-kelas-pemkot-bekasi-gelar-sosialisasi-program-kur-bank-bjb', '2025-09-30 04:37:35', '2025-09-30 04:37:35', 'App\\Models\\Article', 'e26fc79e-6747-4852-8e1b-711cae82c811'),
(15, 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'images/89rXVtDwjTG9EmdgFPogoeFPwAJIirofhidjdrEu.jpg', 'Admin Sekolah', 'index', 'http://103.76.148.154:8000/backend/articles/tri-adhianto-dan-wiwiek-hargono-terima-anugerah-keluarga-termaslahat-dari-lkknu', '2025-09-30 04:39:50', '2025-09-30 04:39:50', 'App\\Models\\Article', 'b74e1fd1-0417-4980-b207-eb8a9901a878'),
(16, 'fsdf', 'fsdf', 'images/58jRWycX0LL0Mmk20xVxBZuLhb13b7gCtnbVFpLf.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/fsdf', '2025-09-30 04:51:15', '2025-09-30 04:51:15', 'App\\Models\\Article', 'ef525ad4-9e6b-40ea-81fd-71de34a4e3a9'),
(17, 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'images/89rXVtDwjTG9EmdgFPogoeFPwAJIirofhidjdrEu.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/tri-adhianto-dan-wiwiek-hargono-terima-anugerah-keluarga-termaslahat-dari-lkknu', '2025-09-30 05:26:51', '2025-09-30 05:26:51', 'App\\Models\\Article', 'b74e1fd1-0417-4980-b207-eb8a9901a878'),
(18, 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'images/89rXVtDwjTG9EmdgFPogoeFPwAJIirofhidjdrEu.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/tri-adhianto-dan-wiwiek-hargono-terima-anugerah-keluarga-termaslahat-dari-lkknu', '2025-09-30 05:29:34', '2025-09-30 05:29:34', 'App\\Models\\Article', 'b74e1fd1-0417-4980-b207-eb8a9901a878'),
(19, 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'images/89rXVtDwjTG9EmdgFPogoeFPwAJIirofhidjdrEu.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/tri-adhianto-dan-wiwiek-hargono-terima-anugerah-keluarga-termaslahat-dari-lkknu', '2025-09-30 05:29:45', '2025-09-30 05:29:45', 'App\\Models\\Article', 'b74e1fd1-0417-4980-b207-eb8a9901a878'),
(20, 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'images/FzjAPJph4NTicYYWBBVghzb9RwjxwfLrr8Jl6wD4.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/tri-adhianto-dan-wiwiek-hargono-terima-anugerah-keluarga-termaslahat-dari-lkknu', '2025-09-30 05:33:35', '2025-09-30 05:33:35', 'App\\Models\\Article', 'b74e1fd1-0417-4980-b207-eb8a9901a878'),
(21, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-01 06:23:46', '2025-10-01 06:23:46', 'App\\Models\\Category', 'e7472961-7151-4c89-bfa8-04eee74d9111'),
(22, 'Juara 3 Lomba Menyanyi', 'Dinda Nurohman', 'images/ZGZUKCAV10bEiRXlkcvW0lKT9J2n50XglYts9jWI.jpg', 'Admin Sekolah', 'index', 'http://103.76.148.154:8000/backend/articles/dinda-nurohman', '2025-10-02 02:24:30', '2025-10-02 02:24:30', 'App\\Models\\Article', 'ef525ad4-9e6b-40ea-81fd-71de34a4e3a9'),
(23, 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'images/bLT73ZQ6e8aVFwZ7hycMkyi8GmfJeuYGvVFuvoK8.jpg', 'Admin Sekolah', 'index', 'http://103.76.148.154:8000/backend/articles/tri-adhianto-dan-wiwiek-hargono-terima-anugerah-keluarga-termaslahat-dari-lkknu', '2025-10-02 02:25:05', '2025-10-02 02:25:05', 'App\\Models\\Article', 'b74e1fd1-0417-4980-b207-eb8a9901a878'),
(24, 'Dorong UMKM Naik Kelas, Pemkot Bekasi Gelar Sosialisasi Program KUR Bank BJB', 'Dorong UMKM Naik Kelas, Pemkot Bekasi Gelar Sosialisasi Program KUR Bank BJB', 'images/qF6sCsDs9ffRTwq44Ofa41hrriVirZ5H47Uee1Bd.jpg', 'Admin Sekolah', 'index', 'http://103.76.148.154:8000/backend/articles/dorong-umkm-naik-kelas-pemkot-bekasi-gelar-sosialisasi-program-kur-bank-bjb', '2025-10-02 02:25:16', '2025-10-02 02:25:16', 'App\\Models\\Article', 'e26fc79e-6747-4852-8e1b-711cae82c811'),
(25, 'Juara lomba menyanyi solo berhasil diraih Adinda eko Subagio', 'Adinda Eko Subagio Juara 1 Lomba menyanyi solo', 'images/FQ4F5RMM3u0ljXS9yWYHDnXsFsPDofYnO3sqgBgV.jpg', 'Admin Sekolah', 'index', 'http://103.76.148.154:8000/backend/articles/adinda-eko-subagio-juara-1-lomba-menyanyi-solo', '2025-10-02 02:30:38', '2025-10-02 02:30:38', 'App\\Models\\Article', '3f026350-7718-43bf-bfd0-088a021e8089'),
(26, 'Juara lomba menyanyi solo berhasil diraih Adinda eko Subagio', 'Adinda Eko Subagio Juara 1 Lomba menyanyi solo', 'images/7vGyW3v4tjrT4MS8i8Alf3KVGE7mzSV3dXd7E4XC.png', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/adinda-eko-subagio-juara-1-lomba-menyanyi-solo', '2025-10-02 05:50:10', '2025-10-02 05:50:10', 'App\\Models\\Article', '3f026350-7718-43bf-bfd0-088a021e8089'),
(27, 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'Tri Adhianto dan Wiwiek Hargono Terima Anugerah Keluarga Termaslahat dari LKKNU', 'images/bLT73ZQ6e8aVFwZ7hycMkyi8GmfJeuYGvVFuvoK8.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/tri-adhianto-dan-wiwiek-hargono-terima-anugerah-keluarga-termaslahat-dari-lkknu', '2025-10-02 06:17:51', '2025-10-02 06:17:51', 'App\\Models\\Article', 'b74e1fd1-0417-4980-b207-eb8a9901a878'),
(28, 'Kunjungan kerja Pj Wali Kota Bekasi Gani Muhamad didampingi Istri Yolla Kusuma', 'Dedikasi Guru SLB, Pj Wali Kota Bekasi Panjatkan Syukur dan Bangga', 'images/dqG6N4LdZt2BpFYbkRYEipCXhu49cY8Hn4feSGYT.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/dedikasi-guru-slb-pj-wali-kota-bekasi-panjatkan-syukur-dan-bangga', '2025-10-02 06:19:06', '2025-10-02 06:19:06', 'App\\Models\\Article', '225a5ce5-27a3-4ebe-a15a-1151ea17f0b2'),
(29, 'Juara lomba menyanyi solo berhasil diraih Adinda eko Subagio', 'Adinda Eko Subagio Juara 1 Lomba menyanyi solo', 'images/pLAsYqB3RjhFGxjr9r3ym0aGIboEuOo9mQqBxmvg.jpg', 'Admin Sekolah', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/adinda-eko-subagio-juara-1-lomba-menyanyi-solo', '2025-10-16 03:16:27', '2025-10-16 03:16:27', 'App\\Models\\Article', '3f026350-7718-43bf-bfd0-088a021e8089'),
(30, 'Kebersaman pemimpin daerah dengan Anak-anak Down Syndrome', 'Wali dan Wakil Wali Kota Bekasi Nyanyi Bersama Anak Down Syndrome di CFD Kota Bekasi', 'images/ESvkOUk4fUn3QIxfGzTdnBDtqcSiQDop8TtFDYvP.jpg', 'Admin Sekolah', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/wali-dan-wakil-wali-kota-bekasi-nyanyi-bersama-anak-down-syndrome-di-cfd-kota-bekasi', '2025-10-16 03:19:35', '2025-10-16 03:19:35', 'App\\Models\\Article', '4922f25e-24ab-45d8-a7bb-ff650c55a578'),
(31, 'Wali Kota Bekasi Tri Adhianto Terima Kunjungan Edukasi Siswa SLB Patriot', 'Wali Kota Bekasi Tri Adhianto Terima Kunjungan Edukasi Siswa SLB Patriot', 'images/jjIvZ0LsGljnaJnPO0VwRRaKIIeoJlGC549B69OZ.jpg', 'super-admin', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/wali-kota-bekasi-tri-adhianto-terima-kunjungan-edukasi-siswa-slb-patriot', '2025-10-17 07:47:37', '2025-10-17 07:47:37', 'App\\Models\\Article', '66ed2a58-530d-4460-b1da-a6d41933540e'),
(32, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-31 03:07:08', '2025-10-31 03:07:08', 'App\\Models\\Category', '72561291-cdcb-484b-a556-0400fbd53c3d'),
(33, 'fsdfsdfsd', 'ffdsdsfsd', 'images/QmD0ntU3jgYsDD1rEXPWdRvz9S1wFj1Ncl1j6lNb.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/ffdsdsfsd', '2025-10-31 03:31:16', '2025-10-31 03:31:16', 'App\\Models\\Article', '1ca939a6-229f-46f2-9ef9-90f6ecf368ef'),
(34, 'fsdfsdfsd', 'ffdsdsfsd', 'images/QmD0ntU3jgYsDD1rEXPWdRvz9S1wFj1Ncl1j6lNb.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/ffdsdsfsd', '2025-10-31 03:41:18', '2025-10-31 03:41:18', 'App\\Models\\Article', '1ca939a6-229f-46f2-9ef9-90f6ecf368ef'),
(35, 'Menyanyi Solo SMPLB FLS3N Disabilitas 2025', 'SMPLB FLS3N Disabilitas 2025', 'images/GXWIGs16PIQbg7gi3yhpcQb1gg58JVu4i6QuOLIt.png', 'Admin Sekolah', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/smplb-fls3n-disabilitas-2025', '2025-10-31 06:48:45', '2025-10-31 06:48:45', 'App\\Models\\Article', '1ca939a6-229f-46f2-9ef9-90f6ecf368ef'),
(36, 'Menyanyi Solo SMPLB FLS3N Disabilitas 2025', 'SMPLB FLS3N Disabilitas 2025', 'images/GXWIGs16PIQbg7gi3yhpcQb1gg58JVu4i6QuOLIt.png', 'Admin Sekolah', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/smplb-fls3n-disabilitas-2025', '2025-11-11 08:00:48', '2025-11-11 08:00:48', 'App\\Models\\Article', '1ca939a6-229f-46f2-9ef9-90f6ecf368ef'),
(37, NULL, 'SLB Patriot Bekasi di Bawah Yayasan Dharma Wanita: Hadir untuk ABK dengan Biaya Sekolah Berkeadilan', NULL, 'Ainun Mutia Zalfina', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/slb-patriot-bekasi-di-bawah-yayasan-dharma-wanita-hadir-untuk-abk-dengan-biaya-sekolah-berkeadilan', '2026-04-17 07:08:11', '2026-04-17 07:08:11', 'App\\Models\\Article', '60dd784c-461e-4ce9-93ae-60d545e5c545'),
(38, NULL, 'SLB Patriot Bekasi di Bawah Yayasan Dharma Wanita: Hadir untuk ABK dengan Biaya Sekolah Berkeadilan', NULL, 'Ainun Mutia Zalfina', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/slb-patriot-bekasi-di-bawah-yayasan-dharma-wanita-hadir-untuk-abk-dengan-biaya-sekolah-berkeadilan', '2026-04-17 07:10:27', '2026-04-17 07:10:27', 'App\\Models\\Article', '60dd784c-461e-4ce9-93ae-60d545e5c545'),
(39, NULL, 'SLB Patriot Bekasi di Bawah Yayasan Dharma Wanita: Hadir untuk ABK dengan Biaya Sekolah Berkeadilan', 'images/8osmllekNYHfwNj1DOfoqmnaW87Cei8CcwavT0pQ.jpg', 'Admin Sekolah', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/slb-patriot-bekasi-di-bawah-yayasan-dharma-wanita-hadir-untuk-abk-dengan-biaya-sekolah-berkeadilan', '2026-05-13 09:15:26', '2026-05-13 09:15:26', 'App\\Models\\Article', '60dd784c-461e-4ce9-93ae-60d545e5c545'),
(40, NULL, 'SLB Patriot Bekasi di Bawah Yayasan Dharma Wanita: Hadir untuk ABK dengan Biaya Sekolah Berkeadilan', 'images/8osmllekNYHfwNj1DOfoqmnaW87Cei8CcwavT0pQ.jpg', 'Admin Sekolah', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/slb-patriot-bekasi-di-bawah-yayasan-dharma-wanita-hadir-untuk-abk-dengan-biaya-sekolah-berkeadilan', '2026-05-13 09:16:41', '2026-05-13 09:16:41', 'App\\Models\\Article', '60dd784c-461e-4ce9-93ae-60d545e5c545'),
(41, 'PENGUMUMAN PENERIMAAN MURID BARU (SPMB) SLB PATRIOT KOTA BEKASI - TA 2026/2027 SLB Patriot Kota Bekasi membuka kesempatan bagi anak berkebutuhan khusus (ABK)', 'SPMB (Sistem Penerimaan Murid Baru) SLB PATRIOT KOTA BEKASI', NULL, 'Ainun Mutia Zalfina', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/spmb-sistem-penerimaan-murid-baru-slb-patriot-kota-bekasi', '2026-05-13 20:51:19', '2026-05-13 20:51:19', 'App\\Models\\Article', '04df33b0-155e-41fc-a904-731c126c75d4'),
(42, 'PENGUMUMAN PENERIMAAN MURID BARU (SPMB) SLB PATRIOT KOTA BEKASI - TA 2026/2027 SLB Patriot Kota Bekasi membuka kesempatan bagi anak berkebutuhan khusus (ABK)', 'SPMB (Sistem Penerimaan Murid Baru) SLB PATRIOT KOTA BEKASI', NULL, 'Ainun Mutia Zalfina', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/spmb-sistem-penerimaan-murid-baru-slb-patriot-kota-bekasi', '2026-05-13 20:57:18', '2026-05-13 20:57:18', 'App\\Models\\Article', '04df33b0-155e-41fc-a904-731c126c75d4'),
(43, 'PENGUMUMAN PENERIMAAN MURID BARU (SPMB) SLB PATRIOT KOTA BEKASI - TA 2026/2027 SLB Patriot Kota Bekasi membuka kesempatan bagi anak berkebutuhan khusus (ABK)', 'SPMB (Sistem Penerimaan Murid Baru) SLB PATRIOT KOTA BEKASI', 'images/DhUdFwOukcm2aJMYNLkSQlOflprS55zlIS2KFK93.jpg', 'Ainun Mutia Zalfina', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/spmb-sistem-penerimaan-murid-baru-slb-patriot-kota-bekasi', '2026-05-14 01:33:57', '2026-05-14 01:33:57', 'App\\Models\\Article', '04df33b0-155e-41fc-a904-731c126c75d4'),
(44, NULL, 'Hadrah', 'images/pKXpNusHLfmir8RYgpkZMheYh03IhYrR39s6l96g.jpg', 'Gesik', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/hadrah', '2026-06-07 23:22:19', '2026-06-07 23:22:19', 'App\\Models\\Article', 'd5f1b860-3d91-4484-b8d3-fe463a0d72f6'),
(45, NULL, 'Kegiatan ASAS (Assessment Sumatif Akhir) Genap tahun ajaran 2025/2026', 'images/VwcmPvohyFLOgGOlLLNSZwohnu5edSVzNDQIufJp.jpg', 'Gesik', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/kegiatan-asas-assessment-sumatif-akhir-genap-tahun-ajaran-20252026', '2026-06-17 20:02:59', '2026-06-17 20:02:59', 'App\\Models\\Article', '44cefb8d-2f87-4670-9bbc-631746daba9c'),
(46, 'Ekstrakurikuler Hadroh di SLB Patriot Kota Bekasi merupakan salah satu wadah pembinaan seni musik Islami dan spiritual bagi para peserta didik. Kegiatan ini dirancang khusus untuk memfasilitasi minat dan bakat siswa-siswi berkebutuhan khusus dalam seni tabuh rebana dan seni tarik suara (selawat).  Melalui pendekatan yang sabar, adaptif, dan penuh kasih sayang, ekstra kurikuler ini membuktikan bahwa keterbatasan fisik maupun kognitif bukanlah penghalang untuk menghasilkan harmoni nada yang indah dan menyentuh hati.', 'Hadrah', 'images/pKXpNusHLfmir8RYgpkZMheYh03IhYrR39s6l96g.jpg', 'Gesik', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/hadrah', '2026-06-19 03:05:59', '2026-06-19 03:05:59', 'App\\Models\\Article', 'd5f1b860-3d91-4484-b8d3-fe463a0d72f6'),
(47, 'Ekstrakurikuler Hadroh di SLB Patriot Kota Bekasi merupakan salah satu wadah pembinaan seni musik Islami dan spiritual bagi para peserta didik. Kegiatan ini dirancang khusus untuk memfasilitasi minat dan bakat siswa-siswi berkebutuhan khusus dalam seni tabuh rebana dan seni tarik suara (selawat).  Melalui pendekatan yang sabar, adaptif, dan penuh kasih sayang, ekstra kurikuler ini membuktikan bahwa keterbatasan fisik maupun kognitif bukanlah penghalang untuk menghasilkan harmoni nada yang indah dan menyentuh hati.', 'Hadrah', 'images/pKXpNusHLfmir8RYgpkZMheYh03IhYrR39s6l96g.jpg', 'Gesik', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/hadrah', '2026-06-19 03:19:58', '2026-06-19 03:19:58', 'App\\Models\\Article', 'd5f1b860-3d91-4484-b8d3-fe463a0d72f6'),
(48, 'Ekstrakurikuler Hadroh di SLB Patriot Kota Bekasi merupakan salah satu wadah pembinaan seni musik Islami dan spiritual bagi para peserta didik. Kegiatan ini dirancang khusus untuk memfasilitasi minat dan bakat siswa-siswi berkebutuhan khusus dalam seni tabuh rebana dan seni tarik suara (selawat).  Melalui pendekatan yang sabar, adaptif, dan penuh kasih sayang, ekstra kurikuler ini membuktikan bahwa keterbatasan fisik maupun kognitif bukanlah penghalang untuk menghasilkan harmoni nada yang indah dan menyentuh hati.', 'Hadrah', 'images/pKXpNusHLfmir8RYgpkZMheYh03IhYrR39s6l96g.jpg', 'Gesik', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/hadrah', '2026-06-19 03:21:12', '2026-06-19 03:21:12', 'App\\Models\\Article', 'd5f1b860-3d91-4484-b8d3-fe463a0d72f6'),
(49, 'Ekstrakurikuler Hadroh di SLB Patriot Kota Bekasi merupakan salah satu wadah pembinaan seni musik Islami dan spiritual bagi para peserta didik. Kegiatan ini dirancang khusus untuk memfasilitasi minat dan bakat siswa-siswi berkebutuhan khusus dalam seni tabuh rebana dan seni tarik suara (selawat).  Melalui pendekatan yang sabar, adaptif, dan penuh kasih sayang, ekstra kurikuler ini membuktikan bahwa keterbatasan fisik maupun kognitif bukanlah penghalang untuk menghasilkan harmoni nada yang indah dan menyentuh hati.', 'Hadrah', 'images/pKXpNusHLfmir8RYgpkZMheYh03IhYrR39s6l96g.jpg', 'Gesik', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/hadrah', '2026-06-19 03:22:51', '2026-06-19 03:22:51', 'App\\Models\\Article', 'd5f1b860-3d91-4484-b8d3-fe463a0d72f6'),
(50, NULL, 'Hadrah', 'images/pKXpNusHLfmir8RYgpkZMheYh03IhYrR39s6l96g.jpg', 'Gesik', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/hadrah', '2026-06-19 03:23:52', '2026-06-19 03:23:52', 'App\\Models\\Article', 'd5f1b860-3d91-4484-b8d3-fe463a0d72f6'),
(51, NULL, 'Hadrah', 'images/pKXpNusHLfmir8RYgpkZMheYh03IhYrR39s6l96g.jpg', 'Gesik', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/hadrah', '2026-06-19 03:34:22', '2026-06-19 03:34:22', 'App\\Models\\Article', 'd5f1b860-3d91-4484-b8d3-fe463a0d72f6'),
(52, NULL, 'Hadrah', 'images/pKXpNusHLfmir8RYgpkZMheYh03IhYrR39s6l96g.jpg', 'Gesik', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/hadrah', '2026-06-19 03:36:25', '2026-06-19 03:36:25', 'App\\Models\\Article', 'd5f1b860-3d91-4484-b8d3-fe463a0d72f6'),
(53, NULL, 'Hadrah', 'images/pKXpNusHLfmir8RYgpkZMheYh03IhYrR39s6l96g.jpg', 'Gesik', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/hadrah', '2026-06-19 03:39:38', '2026-06-19 03:39:38', 'App\\Models\\Article', 'd5f1b860-3d91-4484-b8d3-fe463a0d72f6'),
(54, NULL, 'Hadrah', 'images/pKXpNusHLfmir8RYgpkZMheYh03IhYrR39s6l96g.jpg', 'Gesik', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/hadrah', '2026-06-19 03:41:59', '2026-06-19 03:41:59', 'App\\Models\\Article', 'd5f1b860-3d91-4484-b8d3-fe463a0d72f6'),
(55, 'tes', 'tes kurikuler', 'images/6g8ACLsBH6dVRSH5HrBWY61iwAaRwYQlnCq9b6Jy.png', 'Admin Sekolah', 'index', 'https://be.slbpatriotkotabekasi.sch.id/backend/articles/tes-kurikuler', '2026-06-20 09:12:25', '2026-06-20 09:12:25', 'App\\Models\\Article', '0ce7a99d-145f-4dce-9c69-fe8be79de363'),
(56, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-20 12:47:44', '2026-06-20 12:47:44', 'App\\Models\\Category', 'a58f5ebc-c8ec-48da-b6f9-a80b05ca40a0'),
(57, 'Pilates vs Yoga: Apa Bedanya dan Mana yang Cocok untuk Anda?', 'Pilates vs Yoga: Apa Bedanya dan Mana yang Cocok untuk Anda?', 'images/QfojvfEegY7UFF07HkRp7xw9nsI4LZNVx92HxNfJ.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/pilates-vs-yoga-apa-bedanya-dan-mana-yang-cocok-untuk-anda', '2026-08-27 04:59:46', '2026-08-27 04:59:46', 'App\\Models\\Article', '63829ea9-8a32-4f82-94e1-7299120f822c'),
(58, 'Pilates vs Yoga: Apa Bedanya dan Mana yang Cocok untuk Anda?', 'Pilates vs Yoga: Apa Bedanya dan Mana yang Cocok untuk Anda?', 'images/QfojvfEegY7UFF07HkRp7xw9nsI4LZNVx92HxNfJ.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/pilates-vs-yoga-apa-bedanya-dan-mana-yang-cocok-untuk-anda', '2026-08-27 05:02:14', '2026-08-27 05:02:14', 'App\\Models\\Article', '63829ea9-8a32-4f82-94e1-7299120f822c'),
(59, 'Pilates dan yoga sama-sama populer sebagai olahraga yang membantu meningkatkan kebugaran tubuh sekaligus memberikan manfaat bagi pikiran. Keduanya juga dapat dilakukan oleh pemula dan tidak selalu membutuhkan peralatan yang rumit.', 'Pilates vs Yoga: Apa Bedanya dan Mana yang Cocok untuk Anda?', 'images/QfojvfEegY7UFF07HkRp7xw9nsI4LZNVx92HxNfJ.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/pilates-vs-yoga-apa-bedanya-dan-mana-yang-cocok-untuk-anda', '2026-08-27 05:50:43', '2026-08-27 05:50:43', 'App\\Models\\Article', '63829ea9-8a32-4f82-94e1-7299120f822c'),
(60, 'Pilates dan yoga sama-sama populer sebagai olahraga yang membantu meningkatkan kebugaran tubuh sekaligus memberikan manfaat bagi pikiran. Keduanya juga dapat dilakukan oleh pemula dan tidak selalu membutuhkan peralatan yang rumit.', 'Pilates vs Yoga: Apa Bedanya dan Mana yang Cocok untuk Anda?', 'images/3MeMVIEBB3e5NU9Tm1Ijda7s7iDDcrmdWakjl1C7.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/pilates-vs-yoga-apa-bedanya-dan-mana-yang-cocok-untuk-anda', '2026-08-30 18:12:39', '2026-08-30 18:12:39', 'App\\Models\\Article', '63829ea9-8a32-4f82-94e1-7299120f822c'),
(61, 'Pilates dan yoga sama-sama populer sebagai olahraga yang membantu meningkatkan kebugaran tubuh sekaligus memberikan manfaat bagi pikiran. Keduanya juga dapat dilakukan oleh pemula dan tidak selalu membutuhkan peralatan yang rumit.', 'Pilates vs Yoga: Apa Bedanya dan Mana yang Cocok untuk Anda?', 'images/Q21BSTPfei8FVhkubCnpiCxQYWcL7P6XigMY6gBq.jpg', 'super-admin', 'index', 'http://127.0.0.1:8000/backend/articles/pilates-vs-yoga-apa-bedanya-dan-mana-yang-cocok-untuk-anda', '2026-09-01 03:03:46', '2026-09-01 03:03:46', 'App\\Models\\Article', '63829ea9-8a32-4f82-94e1-7299120f822c'),
(62, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-15 23:09:17', '2026-09-15 23:09:17', 'App\\Models\\DocumentCategory', '26dcc275-4817-4a5a-bdba-9f14cac83c5e'),
(63, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-15 23:12:44', '2026-09-15 23:12:44', 'App\\Models\\DocumentCategory', '8a16898c-5241-43e3-9ae1-e9f266c3218d'),
(64, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-15 23:12:56', '2026-09-15 23:12:56', 'App\\Models\\DocumentCategory', 'b72c0399-3cb1-468c-97f7-0080aff97343'),
(65, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-15 23:13:09', '2026-09-15 23:13:09', 'App\\Models\\DocumentCategory', 'b698befd-73c3-490c-be44-bf7a0f4b9a35'),
(66, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-15 23:13:22', '2026-09-15 23:13:22', 'App\\Models\\DocumentCategory', 'b271e039-1a0e-4bc7-b0b0-810d3e61b402'),
(67, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-15 23:13:32', '2026-09-15 23:13:32', 'App\\Models\\DocumentCategory', '8ca91919-83d6-44d1-bf95-a10fb30ba0ff'),
(68, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-15 23:13:44', '2026-09-15 23:13:44', 'App\\Models\\DocumentCategory', 'a84fba50-51ca-4130-83d9-46cee3f242d6'),
(69, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-15 23:13:55', '2026-09-15 23:13:55', 'App\\Models\\DocumentCategory', 'b8d57474-3500-4caa-8d20-a3f1141c47e6'),
(70, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-15 23:14:05', '2026-09-15 23:14:05', 'App\\Models\\DocumentCategory', '9c0c6f74-224c-4af9-b1cf-dd9d46a8c685'),
(71, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-15 23:14:28', '2026-09-15 23:14:28', 'App\\Models\\DocumentCategory', 'd5394429-10b1-4222-86b4-68c6da8dfe0d'),
(72, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-15 23:14:43', '2026-09-15 23:14:43', 'App\\Models\\DocumentCategory', '01a9274f-003b-4ebc-b62a-b22f1091afd5'),
(73, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-16 01:33:21', '2026-09-16 01:33:21', 'App\\Models\\Document', '01a0a959-5cdd-7352-a0df-2684dbae76bc'),
(74, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-16 01:43:21', '2026-09-16 01:43:21', 'App\\Models\\Document', '01a0a962-86c4-712f-8408-6653ea52051f'),
(76, 'ringkasan', 'judul berita', 'images/4vWMjOtHfGlFugvZ84preK7RAnVcqHFGWUIjJaeD.png', 'super-admin', 'index', 'http://localhost:8000/backend/articles/judul-berita', '2026-09-20 11:19:34', '2026-09-20 11:19:35', 'App\\Models\\Article', 'a4ce109d-88de-423a-bb26-d11087f68a29'),
(77, 'ringkasan', 'judul berita 2', 'images/j6y3qSWN6dYvXjXiE41yWMTz0Z53cyxzaJD6YQWm.png', 'Admin Bekasikota', 'index', 'http://localhost:8000/backend/articles/judul-berita-2', '2026-09-20 12:09:25', '2026-09-20 12:10:17', 'App\\Models\\Article', '2fa27e87-b4b5-4224-900d-26e44764d1e4'),
(78, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-20 13:02:23', '2026-09-20 13:02:23', 'App\\Models\\DocumentCategory', 'a6d14f40-5032-40dc-9ef2-349d4300636f'),
(79, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-20 13:03:40', '2026-09-20 13:03:40', 'App\\Models\\Document', '01a0beea-4a72-723e-a71b-5f20668c45b1'),
(80, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-07 14:03:26', '2026-10-07 14:03:26', 'App\\Models\\Category', '773cd47c-dc89-4546-b6f0-bfb26f74a0a2'),
(81, 'dasda', 'dasd', 'images/bG1cr04Br6NCTiuxlyPaoCdH5LTcCkOzsqev3RYP.png', 'Diskominfostandi', 'index', 'http://127.0.0.1:8000/backend/agendas/dasd', '2026-10-07 14:17:16', '2026-10-07 14:19:58', 'App\\Models\\Agenda', '89355860-0de5-4a90-9567-f8c68d5fe4de');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `uuid` char(36) NOT NULL,
  `name` varchar(150) NOT NULL,
  `category` enum('external','internal','other') NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` char(36) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('2FUxFgg4ktCPogvYzVRB1TUxm84mwt8tIBf4VDip', NULL, '127.0.0.1', 'Symfony', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMm1Cb0VvZ3VNUGdERVlaV3BrMUpDY29vdFk0cWtwcDU0bkdLcVlKUyI7czo3OiJjYXB0Y2hhIjthOjM6e3M6OToic2Vuc2l0aXZlIjtiOjA7czozOiJrZXkiO3M6NjA6IiQyeSQxMiQvNkdRWlduV0RpTHZ4OVBmVlpOLmVPNUtIb0RlNVkvZS81VGJZM1REYUZLYnFJZEZzSU42NiI7czo3OiJlbmNyeXB0IjtiOjA7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjMyOiJodHRwOi8vbG9jYWxob3N0L2NhcHRjaGEvZGVmYXVsdCI7czo1OiJyb3V0ZSI7czoxMzoiY2FwdGNoYS5pbWFnZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1789690649),
('4l6RtBrImbwFoM209Wx1Ehlw15bjENlyRKzoSzrA', NULL, '127.0.0.1', '', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidXZXeGduaktaUnZPMklQNzlvZ0RBT2pvVzRUUUxGZmpZSktuY2djVyI7czo3OiJjYXB0Y2hhIjthOjM6e3M6OToic2Vuc2l0aXZlIjtiOjA7czozOiJrZXkiO3M6MzEyOiJleUpwZGlJNkltMVBSRU5FUVd0dFdXOW1NVWxZYzI5NlpESkhNVUU5UFNJc0luWmhiSFZsSWpvaWRXRkpOR3RIY1ZFM09FOTRRVUpwVmtaNk9FMUlaM1prVGs5V1N6VjRPRXdyZDJFM05WVkNLMjFUVXpscE5sYzBWVUU0VnpKQ1JXZ3lNbkpNUVV4bFdYTm5Sek5qUlM5d2VHUmFibWxqTjB3emNYSlFOemRvUTB0Vk1HcHlTRWxzWmxnMVpHcFpiMFphTkRROUlpd2liV0ZqSWpvaVpXWTNOelZoWm1KallXTTRPV0k0TWpCbFpUQTVZbVF3TlRFd01ESmhPVGxoT0RVMlkyTmlOVGRrWldFNE9UUXhaamN6WXpabVpERm1ZV1UxTnpZeU55SXNJblJoWnlJNklpSjkiO3M6NzoiZW5jcnlwdCI7YjoxO31zOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czozNDoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2NhcHRjaGEvZmxhdCI7czo1OiJyb3V0ZSI7czoxMzoiY2FwdGNoYS5pbWFnZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1789691339),
('5NB0vaMQeKD3GzBykBaJ0xlfnAcColwPYHprEtDT', NULL, '127.0.0.1', '', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicjZFaklzRUhhM0N1Y3FxdExyU0VsNWFEa1E5Q29CZVp5UDlZV05BZSI7czo3OiJjYXB0Y2hhIjthOjM6e3M6OToic2Vuc2l0aXZlIjtiOjA7czozOiJrZXkiO3M6NjA6IiQyeSQxMiRQWFRqMGRZMkg0N01qLmozN0tEZU4ualBQQnVxMFdWUWo5b3J1OHBDWTdFRVQuWU0uSFFaZSI7czo3OiJlbmNyeXB0IjtiOjA7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjM3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvY2FwdGNoYS9kZWZhdWx0IjtzOjU6InJvdXRlIjtzOjEzOiJjYXB0Y2hhLmltYWdlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1789691258),
('7sYPFeeMLcSNUUnwOX0KUVsBqSRPXxOxvIsAJfk0', NULL, '127.0.0.1', 'Symfony', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoib0FzbzBFVENwRGI2dWhheVZMdzN1YTFFS0pFdkxaSDZoTUlTNjhrSiI7czo3OiJjYXB0Y2hhIjthOjM6e3M6OToic2Vuc2l0aXZlIjtiOjA7czozOiJrZXkiO3M6NjA6IiQyeSQxMiQwUjB3aDcxT3lzWnNFUkZsQ2V0bjNlWHFqLjhXTDhzZmdaekFhMVBJQXpnR2tJVUEzVEZXTyI7czo3OiJlbmNyeXB0IjtiOjA7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjMyOiJodHRwOi8vbG9jYWxob3N0L2NhcHRjaGEvZGVmYXVsdCI7czo1OiJyb3V0ZSI7czoxMzoiY2FwdGNoYS5pbWFnZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1789690898),
('9g4iRlPub1820qjK46V0RS4qMV7Kew90AKTowHDS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoid0gzTVRQUWxBNEZaSXd0ekZSWDlQM0hVUGxEZ2lONzA3bFk0RGRLTyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hdXRoL2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo3OiJjYXB0Y2hhIjthOjM6e3M6OToic2Vuc2l0aXZlIjtiOjA7czozOiJrZXkiO3M6MzEyOiJleUpwZGlJNklreDZPVFpQTVZoSVV6VnhWVVU1YkV0eWRuaGtVVkU5UFNJc0luWmhiSFZsSWpvaUt5dGlWMk5KTWxKUVVWTnVjMDFPWm5SbFJWTklRWGd3TTFnMFkxYzRhamczWW5oRldrOXVUV2xCYlhSTU1URXhhblI1ZGxOV1JEVjFTbEJ1Vlc1V1dtcGtObFZGU20xYU5EaG5RV05sTmsxUlZVZGxjV3Q1YUhCclVtMUVVSEJLUmxGNlp6QnFSSEJNTVRnOUlpd2liV0ZqSWpvaU16Y3dZelJoTkRKaE4yUTNZelZtTXpKbE56QmpNR1l3T0RCa056QXlZelEyWVRsa05EQmxNVGxrWkRZeU1XWTVPVEV4WVdSaE16WTFOV0ptWlRObU55SXNJblJoWnlJNklpSjkiO3M6NzoiZW5jcnlwdCI7YjoxO319', 1789692407),
('BjUY4V34pigSliznOQnjM9F5wguaGBYbNZjFyzVl', NULL, '127.0.0.1', 'Symfony', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNnk2RGFvM3h6d1RRSjZkcUlIVURraW5UODM0dzJ2REZBWWdrTE90aSI7czo3OiJjYXB0Y2hhIjthOjM6e3M6OToic2Vuc2l0aXZlIjtiOjA7czozOiJrZXkiO3M6NjA6IiQyeSQxMiQwVC5MR2M2R3IwTTRCRjY4UjdYY1IuTy45QS9uMzFmWmd0RkxrNXRUUy9ZdjRCcU5ya09LaSI7czo3OiJlbmNyeXB0IjtiOjA7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjMyOiJodHRwOi8vbG9jYWxob3N0L2NhcHRjaGEvZGVmYXVsdCI7czo1OiJyb3V0ZSI7czoxMzoiY2FwdGNoYS5pbWFnZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1789690580),
('feF71BLCXi3eZDSXsqGBqS42rpYNpeRbdYixBLNv', NULL, '127.0.0.1', 'Symfony', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTmZtQVNwUTNoTHY0eXRIYTdka0RzZjV3VEFKY2hEZzdnS2toemlrVyI7czo3OiJjYXB0Y2hhIjthOjM6e3M6OToic2Vuc2l0aXZlIjtiOjA7czozOiJrZXkiO3M6NjA6IiQyeSQxMiQ3aWxhQ1NrUnB4SmtsajRXTFpnYUVPUjF2Tng3aWxaVk9QY3NHbmtlTlhrNkZ2ODFRZ2EyYSI7czo3OiJlbmNyeXB0IjtiOjA7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjMyOiJodHRwOi8vbG9jYWxob3N0L2NhcHRjaGEvZGVmYXVsdCI7czo1OiJyb3V0ZSI7czoxMzoiY2FwdGNoYS5pbWFnZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1789690752),
('GEtoWuerTDYtPjtTwDYwViRA8J3uQXreQqNIsycS', NULL, '127.0.0.1', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibmZkYTBuVkwyV3NWS3ZsVFJZY2VDUVhhaUR4RmVFRnZ3T1RVcFlaciI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hdXRoL2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1789692408),
('mVCTAvnbzBMhze32euMgIHZ8o10cuMvXYinCa7qN', NULL, '127.0.0.1', 'Symfony', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRFN0dTdwM0N6QmRFMEE4TjU0WDVQM05zQ1RwZDZOclh2cDdibVlEeiI7czo3OiJjYXB0Y2hhIjthOjM6e3M6OToic2Vuc2l0aXZlIjtiOjA7czozOiJrZXkiO3M6NjA6IiQyeSQxMiRUdlBSaElraWFLWnhIZG9ueGVRaVBlWGtDWnJOMzNjTGtPTVEwaTVPdHU2THdZblBzQ21WUyI7czo3OiJlbmNyeXB0IjtiOjA7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjMyOiJodHRwOi8vbG9jYWxob3N0L2NhcHRjaGEvZGVmYXVsdCI7czo1OiJyb3V0ZSI7czoxMzoiY2FwdGNoYS5pbWFnZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1789690677),
('OEMEJlzSP3M1ozwtdGyDA0FDI2ynLr8IDWyrtVx8', NULL, '127.0.0.1', '', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRDUyM2w4eWp4NVlJOGs2M0RzRG1RV052MnNsYmhGYlA0SkZ6YTc3UiI7czo3OiJjYXB0Y2hhIjthOjM6e3M6OToic2Vuc2l0aXZlIjtiOjA7czozOiJrZXkiO3M6MzEyOiJleUpwZGlJNklraHpiM1o1WWxSeFZEZFdWbUp2VTNOaFZTdEZSRkU5UFNJc0luWmhiSFZsSWpvaWRrVnBkazFVYjJOSFEyVnFaRTgxV0hCQ2MyRjFNV2hMWWl0TVEybDRNbEpTYmxGcmN6aFdXR1JYZFhWeFZuYzFOREJ6U0RFd1F6SkRXSEZPWjA1VGRGVXJaRXBKVG5sRFJrcHpNRkozWjFGeGQyZHJRbWQyY0RoUk5pOVZTMlpWU1doeFoyRkVTV3hqTjFVOUlpd2liV0ZqSWpvaVpHVmhOR1EyWVRRM016QmxORGMzTVdFM09UaGlZamc0WXpjeU1USXpNREl5TXpoa05Ua3pORGxsWVRGaE5UTmlNbVF4WkRWaU56VTFNbVEzTURBellTSXNJblJoWnlJNklpSjkiO3M6NzoiZW5jcnlwdCI7YjoxO31zOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czozNDoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2NhcHRjaGEvZmxhdCI7czo1OiJyb3V0ZSI7czoxMzoiY2FwdGNoYS5pbWFnZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1789691300),
('Yth9RMqJJ5iKCmSrs1pnA8o3vVANkIo9ZYaeBaCW', NULL, '127.0.0.1', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUGhsTklNTmR5RkRWYUFjd3dnMEtXVE5OSnRudVBZajRlMDlPbTZCSCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hdXRoL2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1789691271);

-- --------------------------------------------------------

--
-- Table structure for table `tindak_lanjut_templates`
--

CREATE TABLE `tindak_lanjut_templates` (
  `uuid` char(36) NOT NULL,
  `judul` varchar(150) NOT NULL,
  `isi` text NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `uuid` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `kecamatan_id` bigint(20) UNSIGNED DEFAULT NULL,
  `kelurahan_id` bigint(20) UNSIGNED DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `tempat_lahir` varchar(255) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  `agama` enum('Islam','Kristen','Katolik','Hindu','Buddha','Konghucu','Lainnya') DEFAULT NULL,
  `is_active` date DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `sumber_informasi` enum('google','sosmed','teman','komunitas','event','website','lainnya') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uuid`, `name`, `no_hp`, `alamat`, `kecamatan_id`, `kelurahan_id`, `avatar`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `google_id`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `agama`, `is_active`, `deleted_at`, `sumber_informasi`) VALUES
('0a091f5a-c510-4110-b2b2-2f992091fb1d', 'Diskominfostandi', NULL, NULL, NULL, NULL, NULL, 'diskominfostandi@bekasikota.go.id', '2026-10-07 14:15:33', '$2y$12$jnDoi7L52haFQI1I5CtLzO0upmwFAg9uWsEt4wwJQVQEHHAl2BmiO', NULL, '2026-10-07 14:15:33', '2026-10-07 14:15:33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('58cbfa68-69aa-4cd1-95cc-9520046d9ceb', 'Wiku Pramesthi Bagaswara', '085691333321', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIy22SZ7rHRNSArCv4eG6XuX5UvbOoXvsVvIs9Xq7V7QurWiopP=s96-c', 'wikupb@gmail.com', '2026-10-07 14:14:58', '$2y$12$jAEzSFmcf9dR//UIHXEEfel1L44V3FZ31XSYmnSwaRBiz/OzNdX0q', NULL, '2026-09-19 00:40:14', '2026-10-07 14:14:58', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'event'),
('787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', NULL, 'Jl. Gandaria', 4, 17, 'avatars/u5KMRU9jG95SYcdq0vhxnksQ0EFatee9WxrPxrtH.jpg', 'super@admin.com', '2025-09-16 00:23:37', '$2y$12$PRZJcd.nlREU6NRq3jvIVemYmlwxVPTb7En4URyNgyQSfKjWUzwDi', 'xjB9veugG2XdafB6eNhKGKvphG76Sf0yrWJ5XhbmmZubAd6dh0l70s09WAL0', '2025-09-16 00:23:37', '2026-09-06 23:43:32', NULL, 'dasda', '2025-09-24', 'P', 'Lainnya', NULL, NULL, NULL),
('9c513953-32d1-4415-a921-8a6baf246d44', 'Admin Bekasikota', '43243277777', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLitzhONjAN_zPOcC2rM16BHekNE3M2zU7C-e0d53-6M47R-PE=s96-c', 'bekasikotakotabekasi2018@gmail.com', '2026-09-20 11:21:48', '$2y$12$PRZJcd.nlREU6NRq3jvIVemYmlwxVPTb7En4URyNgyQSfKjWUzwDi', NULL, '2026-09-19 02:27:18', '2026-09-20 11:21:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'google');

-- --------------------------------------------------------

--
-- Table structure for table `visitor_daily_stats`
--

CREATE TABLE `visitor_daily_stats` (
  `date` date NOT NULL,
  `total_visits` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `unique_visitors` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `desktop_visits` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `mobile_visits` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `tablet_visits` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `top_pages` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`top_pages`)),
  `top_referrers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`top_referrers`)),
  `top_countries` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`top_countries`)),
  `browsers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`browsers`)),
  `os` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`os`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `visitor_daily_stats`
--

INSERT INTO `visitor_daily_stats` (`date`, `total_visits`, `unique_visitors`, `desktop_visits`, `mobile_visits`, `tablet_visits`, `top_pages`, `top_referrers`, `top_countries`, `browsers`, `os`, `created_at`, `updated_at`) VALUES
('2026-08-20', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-08-21', 1, 1, 1, 0, 0, '[{\"url\":\"http:\\/\\/test.com\\/page7\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Edge\",\"count\":1}]', '[{\"os\":\"Linux\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-08-22', 1, 1, 1, 0, 0, '[{\"url\":\"http:\\/\\/test.com\\/page1\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Firefox\",\"count\":1}]', '[{\"os\":\"Android\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-08-23', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-08-24', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-08-25', 2, 1, 0, 0, 2, '[{\"url\":\"http:\\/\\/test.com\\/page8\",\"count\":1},{\"url\":\"http:\\/\\/test.com\\/page2\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Edge\",\"count\":1},{\"browser\":\"Firefox\",\"count\":1}]', '[{\"os\":\"Android\",\"count\":1},{\"os\":\"macOS\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-08-26', 1, 0, 1, 0, 0, '[{\"url\":\"http:\\/\\/test.com\\/page18\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Firefox\",\"count\":1}]', '[{\"os\":\"macOS\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-08-27', 2, 1, 1, 0, 1, '[{\"url\":\"http:\\/\\/test.com\\/page16\",\"count\":1},{\"url\":\"http:\\/\\/test.com\\/page9\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Firefox\",\"count\":1},{\"browser\":\"Edge\",\"count\":1}]', '[{\"os\":\"Windows\",\"count\":1},{\"os\":\"macOS\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-08-28', 1, 1, 1, 0, 0, '[{\"url\":\"http:\\/\\/test.com\\/page5\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Firefox\",\"count\":1}]', '[{\"os\":\"iOS\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-08-29', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-08-30', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-08-31', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-01', 1, 1, 0, 0, 1, '[{\"url\":\"http:\\/\\/test.com\\/page12\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Edge\",\"count\":1}]', '[{\"os\":\"iOS\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-02', 1, 1, 0, 1, 0, '[{\"url\":\"http:\\/\\/test.com\\/page4\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Firefox\",\"count\":1}]', '[{\"os\":\"Windows\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-03', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-04', 1, 1, 1, 0, 0, '[{\"url\":\"http:\\/\\/test.com\\/page0\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Chrome\",\"count\":1}]', '[{\"os\":\"Windows\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-05', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-06', 1, 1, 0, 0, 1, '[{\"url\":\"http:\\/\\/test.com\\/page14\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Chrome\",\"count\":1}]', '[{\"os\":\"iOS\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-07', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-08', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-09', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-10', 1, 1, 0, 1, 0, '[{\"url\":\"http:\\/\\/test.com\\/page3\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Firefox\",\"count\":1}]', '[{\"os\":\"macOS\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-11', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-12', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-13', 2, 1, 0, 1, 1, '[{\"url\":\"http:\\/\\/test.com\\/page17\",\"count\":1},{\"url\":\"http:\\/\\/test.com\\/page11\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Safari\",\"count\":1},{\"browser\":\"Edge\",\"count\":1}]', '[{\"os\":\"iOS\",\"count\":1},{\"os\":\"macOS\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-14', 2, 2, 0, 0, 2, '[{\"url\":\"http:\\/\\/test.com\\/page6\",\"count\":1},{\"url\":\"http:\\/\\/test.com\\/page13\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Firefox\",\"count\":1},{\"browser\":\"Edge\",\"count\":1}]', '[{\"os\":\"iOS\",\"count\":1},{\"os\":\"Android\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-15', 2, 1, 0, 2, 0, '[{\"url\":\"http:\\/\\/test.com\\/page19\",\"count\":1},{\"url\":\"http:\\/\\/test.com\\/page15\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Edge\",\"count\":1},{\"browser\":\"Firefox\",\"count\":1}]', '[{\"os\":\"Windows\",\"count\":1},{\"os\":\"iOS\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-16', 0, 0, 0, 0, 0, '[]', '[]', '[]', '[]', '[]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-17', 1, 0, 1, 0, 0, '[{\"url\":\"http:\\/\\/test.com\\/page10\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Safari\",\"count\":1}]', '[{\"os\":\"macOS\",\"count\":1}]', '2026-09-17 22:33:20', '2026-09-17 22:33:20'),
('2026-09-18', 1, 1, 1, 0, 0, '[{\"url\":\"http:\\/\\/test.com\",\"count\":1}]', '[]', '[]', '[{\"browser\":\"Chrome\",\"count\":1}]', '[{\"os\":\"Windows\",\"count\":1}]', '2026-09-17 22:30:24', '2026-09-17 22:30:24');

-- --------------------------------------------------------

--
-- Table structure for table `visitor_logs`
--

CREATE TABLE `visitor_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `referrer` varchar(255) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `device_type` varchar(255) DEFAULT NULL,
  `browser` varchar(255) DEFAULT NULL,
  `os` varchar(255) DEFAULT NULL,
  `is_unique` tinyint(1) NOT NULL DEFAULT 1,
  `visited_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `visitor_logs`
--

INSERT INTO `visitor_logs` (`id`, `ip_address`, `user_agent`, `url`, `referrer`, `country`, `city`, `device_type`, `browser`, `os`, `is_unique`, `visited_at`) VALUES
(1, '127.0.0.1', 'test', 'http://test.com', NULL, NULL, NULL, 'desktop', 'Chrome', 'Windows', 1, '2026-09-17 21:59:11'),
(2, '192.168.1.42', 'test', 'http://test.com/page0', NULL, NULL, NULL, 'desktop', 'Chrome', 'Windows', 1, '2026-09-04 08:34:00'),
(3, '192.168.1.39', 'test', 'http://test.com/page1', NULL, NULL, NULL, 'desktop', 'Firefox', 'Android', 1, '2026-08-21 23:51:00'),
(4, '192.168.1.19', 'test', 'http://test.com/page2', NULL, NULL, NULL, 'tablet', 'Firefox', 'macOS', 0, '2026-08-25 09:33:00'),
(5, '192.168.1.1', 'test', 'http://test.com/page3', NULL, NULL, NULL, 'mobile', 'Firefox', 'macOS', 1, '2026-09-10 08:36:00'),
(6, '192.168.1.29', 'test', 'http://test.com/page4', NULL, NULL, NULL, 'mobile', 'Firefox', 'Windows', 1, '2026-09-01 19:32:00'),
(7, '192.168.1.36', 'test', 'http://test.com/page5', NULL, NULL, NULL, 'desktop', 'Firefox', 'iOS', 1, '2026-08-28 04:30:00'),
(8, '192.168.1.42', 'test', 'http://test.com/page6', NULL, NULL, NULL, 'tablet', 'Firefox', 'iOS', 1, '2026-09-14 03:34:00'),
(9, '192.168.1.21', 'test', 'http://test.com/page7', NULL, NULL, NULL, 'desktop', 'Edge', 'Linux', 1, '2026-08-21 08:55:00'),
(10, '192.168.1.23', 'test', 'http://test.com/page8', NULL, NULL, NULL, 'tablet', 'Edge', 'Android', 1, '2026-08-25 01:09:00'),
(11, '192.168.1.36', 'test', 'http://test.com/page9', NULL, NULL, NULL, 'tablet', 'Edge', 'macOS', 0, '2026-08-27 07:16:00'),
(12, '192.168.1.47', 'test', 'http://test.com/page10', NULL, NULL, NULL, 'desktop', 'Safari', 'macOS', 0, '2026-09-16 17:14:00'),
(13, '192.168.1.42', 'test', 'http://test.com/page11', NULL, NULL, NULL, 'mobile', 'Edge', 'macOS', 0, '2026-09-13 08:10:00'),
(14, '192.168.1.24', 'test', 'http://test.com/page12', NULL, NULL, NULL, 'tablet', 'Edge', 'iOS', 1, '2026-08-31 20:59:00'),
(15, '192.168.1.28', 'test', 'http://test.com/page13', NULL, NULL, NULL, 'tablet', 'Edge', 'Android', 1, '2026-09-14 14:33:00'),
(16, '192.168.1.25', 'test', 'http://test.com/page14', NULL, NULL, NULL, 'tablet', 'Chrome', 'iOS', 1, '2026-09-06 11:42:00'),
(17, '192.168.1.9', 'test', 'http://test.com/page15', NULL, NULL, NULL, 'mobile', 'Firefox', 'iOS', 0, '2026-09-15 08:36:00'),
(18, '192.168.1.34', 'test', 'http://test.com/page16', NULL, NULL, NULL, 'desktop', 'Firefox', 'Windows', 1, '2026-08-26 20:47:00'),
(19, '192.168.1.49', 'test', 'http://test.com/page17', NULL, NULL, NULL, 'tablet', 'Safari', 'iOS', 1, '2026-09-12 20:28:00'),
(20, '192.168.1.11', 'test', 'http://test.com/page18', NULL, NULL, NULL, 'desktop', 'Firefox', 'macOS', 0, '2026-08-26 10:43:00'),
(21, '192.168.1.43', 'test', 'http://test.com/page19', NULL, NULL, NULL, 'mobile', 'Edge', 'Windows', 1, '2026-09-14 23:17:00');

-- --------------------------------------------------------

--
-- Table structure for table `website_identities`
--

CREATE TABLE `website_identities` (
  `uuid` char(36) NOT NULL,
  `site_name` varchar(255) DEFAULT NULL,
  `site_title` varchar(255) DEFAULT NULL,
  `tagline` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `favicon` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `facebook_url` varchar(255) DEFAULT NULL,
  `instagram_url` varchar(255) DEFAULT NULL,
  `youtube_url` varchar(255) DEFAULT NULL,
  `tiktok_url` varchar(255) DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `og_image` varchar(255) DEFAULT NULL,
  `google_analytics_id` varchar(255) DEFAULT NULL,
  `google_site_verification` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `website_identities`
--

INSERT INTO `website_identities` (`uuid`, `site_name`, `site_title`, `tagline`, `description`, `logo`, `favicon`, `email`, `phone`, `address`, `facebook_url`, `instagram_url`, `youtube_url`, `tiktok_url`, `meta_title`, `meta_description`, `meta_keywords`, `og_image`, `google_analytics_id`, `google_site_verification`, `created_at`, `updated_at`) VALUES
('4b30c85e-4c00-4b53-897f-841bce4e9bde', 'Bekasikota Kota Bekasi', 'Portal Bekasikota Kota Bekasi', 'Infrastruktur Berkualitas, Sumber Daya Air Berkelanjutan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-18 02:41:39', '2026-09-18 09:16:27');

-- --------------------------------------------------------

--
-- Table structure for table `website_menus`
--

CREATE TABLE `website_menus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `position` int(11) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `website_menus`
--

INSERT INTO `website_menus` (`id`, `name`, `slug`, `location`, `status`, `position`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Header Utama', 'header-main', 'header', 1, 1, 'Menu navigasi utama di header', '2026-09-17 13:48:02', '2026-09-17 13:48:02'),
(2, 'Footer Utama', 'footer-main', 'footer', 1, 1, 'Menu navigasi di footer', '2026-09-17 13:48:02', '2026-09-17 13:48:02'),
(3, 'Mobile Menu', 'mobile-main', 'mobile', 1, 1, 'Menu untuk tampilan mobile', '2026-09-17 13:48:02', '2026-09-17 13:48:02');

-- --------------------------------------------------------

--
-- Table structure for table `website_menu_items`
--

CREATE TABLE `website_menu_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `website_menu_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `route_params` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`route_params`)),
  `icon` varchar(255) DEFAULT NULL,
  `target_blank` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `position` int(11) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `website_menu_items`
--

INSERT INTO `website_menu_items` (`id`, `website_menu_id`, `parent_id`, `name`, `url`, `route`, `route_params`, `icon`, `target_blank`, `status`, `position`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'Beranda', NULL, 'home', NULL, 'bx bx-home', 0, 1, 1, NULL, '2026-09-17 13:48:02', '2026-09-17 13:48:02'),
(2, 1, NULL, 'Tentang Kami', NULL, 'about', NULL, 'bx bx-info-circle', 0, 1, 2, NULL, '2026-09-17 13:48:02', '2026-09-17 13:48:02'),
(3, 1, NULL, 'Layanan', '#', NULL, NULL, 'bx bx-cog', 0, 1, 3, NULL, '2026-09-17 13:48:02', '2026-09-17 13:48:02'),
(4, 1, 3, 'Layanan 1', NULL, 'services.detail', '{\"slug\":\"layanan-1\"}', NULL, 0, 1, 1, NULL, '2026-09-17 13:48:02', '2026-09-17 13:48:02'),
(5, 1, 3, 'Layanan 2', NULL, 'services.detail', '{\"slug\":\"layanan-2\"}', NULL, 0, 1, 2, NULL, '2026-09-17 13:48:02', '2026-09-17 13:48:02'),
(6, 1, NULL, 'Kontak', NULL, 'contact', NULL, 'bx bx-envelope', 0, 1, 4, NULL, '2026-09-17 13:48:02', '2026-09-17 13:48:02'),
(7, 2, NULL, 'Kebijakan Privasi', NULL, 'privacy', NULL, NULL, 0, 1, 1, NULL, '2026-09-17 13:48:02', '2026-09-17 13:48:02'),
(8, 2, NULL, 'Syarat & Ketentuan', NULL, 'terms', NULL, NULL, 0, 1, 2, NULL, '2026-09-17 13:48:02', '2026-09-17 13:48:02'),
(9, 2, NULL, 'FAQ', NULL, 'faq', NULL, NULL, 0, 1, 3, NULL, '2026-09-17 13:48:02', '2026-09-17 13:48:02'),
(10, 3, NULL, 'Beranda', NULL, 'home', NULL, 'bx bx-home', 0, 1, 1, NULL, '2026-09-17 13:48:02', '2026-09-17 13:48:02'),
(11, 3, NULL, 'Profil', NULL, 'profile.edit', NULL, 'bx bx-user', 0, 1, 2, NULL, '2026-09-17 13:48:02', '2026-09-17 13:48:02'),
(12, 3, NULL, 'Logout', NULL, 'logout', NULL, 'bx bx-log-out', 0, 1, 3, NULL, '2026-09-17 13:48:02', '2026-09-17 13:48:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aduans`
--
ALTER TABLE `aduans`
  ADD PRIMARY KEY (`uuid`),
  ADD UNIQUE KEY `aduans_nomor_aduan_unique` (`nomor_aduan`),
  ADD KEY `aduans_kecamatan_id_foreign` (`kecamatan_id`),
  ADD KEY `aduans_kelurahan_id_foreign` (`kelurahan_id`),
  ADD KEY `aduans_status_prioritas_index` (`status`,`prioritas`),
  ADD KEY `aduans_tanggal_pengaduan_index` (`tanggal_pengaduan`),
  ADD KEY `aduans_kategori_index` (`kategori`),
  ADD KEY `aduans_user_uuid_index` (`user_uuid`),
  ADD KEY `aduans_kategori_status_index` (`kategori`,`status`);

--
-- Indexes for table `aduan_tindak_lanjuts`
--
ALTER TABLE `aduan_tindak_lanjuts`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `aduan_tindak_lanjuts_user_uuid_foreign` (`user_uuid`),
  ADD KEY `aduan_tindak_lanjuts_aduan_uuid_index` (`aduan_uuid`);

--
-- Indexes for table `agendas`
--
ALTER TABLE `agendas`
  ADD PRIMARY KEY (`uuid`),
  ADD UNIQUE KEY `articles_slug_unique` (`slug`),
  ADD KEY `articles_user_uuid_foreign` (`user_uuid`),
  ADD KEY `articles_category_uuid_foreign` (`category_uuid`);

--
-- Indexes for table `agenda_images`
--
ALTER TABLE `agenda_images`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `article_images_article_uuid_index` (`agenda_uuid`);

--
-- Indexes for table `albums`
--
ALTER TABLE `albums`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `albums_cover_index` (`cover`);

--
-- Indexes for table `album_foto`
--
ALTER TABLE `album_foto`
  ADD PRIMARY KEY (`album_uuid`,`banner_uuid`),
  ADD KEY `album_foto_banner_uuid_index` (`banner_uuid`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audit_logs_auditable_type_auditable_id_index` (`auditable_type`,`auditable_id`),
  ADD KEY `audit_logs_created_at_index` (`created_at`),
  ADD KEY `audit_logs_user_uuid_index` (`user_uuid`),
  ADD KEY `audit_logs_event_index` (`event`);

--
-- Indexes for table `banner`
--
ALTER TABLE `banner`
  ADD PRIMARY KEY (`uuid`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`uuid`),
  ADD UNIQUE KEY `categories_name_unique` (`name`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`uuid`),
  ADD UNIQUE KEY `documents_slug_unique` (`slug`),
  ADD KEY `documents_category_uuid_foreign` (`category_uuid`);

--
-- Indexes for table `document_categories`
--
ALTER TABLE `document_categories`
  ADD PRIMARY KEY (`uuid`),
  ADD UNIQUE KEY `document_categories_slug_unique` (`slug`);

--
-- Indexes for table `document_versions`
--
ALTER TABLE `document_versions`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `document_versions_user_uuid_foreign` (`user_uuid`),
  ADD KEY `document_versions_document_uuid_versi_index` (`document_uuid`,`versi`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `failed_logins`
--
ALTER TABLE `failed_logins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `failed_logins_email_index` (`email`),
  ADD KEY `failed_logins_user_uuid_index` (`user_uuid`),
  ADD KEY `failed_logins_ip_address_index` (`ip_address`),
  ADD KEY `failed_logins_attempted_at_index` (`attempted_at`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `faqs_kategori_index` (`kategori`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kecamatans`
--
ALTER TABLE `kecamatans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kelurahans`
--
ALTER TABLE `kelurahans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kelurahans_kecamatan_id_foreign` (`kecamatan_id`);

--
-- Indexes for table `kontak`
--
ALTER TABLE `kontak`
  ADD PRIMARY KEY (`uuid`);

--
-- Indexes for table `login_activities`
--
ALTER TABLE `login_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `login_activities_user_uuid_index` (`user_uuid`),
  ADD KEY `login_activities_email_index` (`email`),
  ADD KEY `login_activities_logged_in_at_index` (`logged_in_at`);

--
-- Indexes for table `login_lockouts`
--
ALTER TABLE `login_lockouts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login_lockouts_type_value_unique` (`type`,`value`),
  ADD KEY `login_lockouts_value_index` (`value`),
  ADD KEY `login_lockouts_blocked_until_index` (`blocked_until`);

--
-- Indexes for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `maintenance_schedules_petugas_uuid_foreign` (`petugas_uuid`),
  ADD KEY `maintenance_schedules_status_tanggal_rencana_index` (`status`,`tanggal_rencana`),
  ADD KEY `maintenance_schedules_aduan_uuid_index` (`aduan_uuid`);

--
-- Indexes for table `menu_groups`
--
ALTER TABLE `menu_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`uuid`),
  ADD UNIQUE KEY `pages_slug_unique` (`slug`),
  ADD KEY `pages_user_uuid_foreign` (`user_uuid`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `polls`
--
ALTER TABLE `polls`
  ADD PRIMARY KEY (`uuid`);

--
-- Indexes for table `poll_votes`
--
ALTER TABLE `poll_votes`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `poll_votes_poll_uuid_foreign` (`poll_uuid`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seo`
--
ALTER TABLE `seo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seo_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`uuid`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `tindak_lanjut_templates`
--
ALTER TABLE `tindak_lanjut_templates`
  ADD PRIMARY KEY (`uuid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`uuid`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_no_hp_unique` (`no_hp`),
  ADD KEY `users_kecamatan_id_foreign` (`kecamatan_id`),
  ADD KEY `users_kelurahan_id_foreign` (`kelurahan_id`),
  ADD KEY `users_membership_status_index` (`sumber_informasi`);

--
-- Indexes for table `visitor_daily_stats`
--
ALTER TABLE `visitor_daily_stats`
  ADD PRIMARY KEY (`date`),
  ADD KEY `visitor_daily_stats_date_index` (`date`);

--
-- Indexes for table `visitor_logs`
--
ALTER TABLE `visitor_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `visitor_logs_ip_address_visited_at_index` (`ip_address`,`visited_at`),
  ADD KEY `visitor_logs_visited_at_index` (`visited_at`),
  ADD KEY `visitor_logs_device_type_index` (`device_type`);

--
-- Indexes for table `website_identities`
--
ALTER TABLE `website_identities`
  ADD PRIMARY KEY (`uuid`);

--
-- Indexes for table `website_menus`
--
ALTER TABLE `website_menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `website_menus_slug_unique` (`slug`);

--
-- Indexes for table `website_menu_items`
--
ALTER TABLE `website_menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `website_menu_items_website_menu_id_foreign` (`website_menu_id`),
  ADD KEY `website_menu_items_parent_id_foreign` (`parent_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=453;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_logins`
--
ALTER TABLE `failed_logins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `kecamatans`
--
ALTER TABLE `kecamatans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `kelurahans`
--
ALTER TABLE `kelurahans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `login_activities`
--
ALTER TABLE `login_activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `login_lockouts`
--
ALTER TABLE `login_lockouts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `menu_groups`
--
ALTER TABLE `menu_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=225;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `routes`
--
ALTER TABLE `routes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=238;

--
-- AUTO_INCREMENT for table `seo`
--
ALTER TABLE `seo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `visitor_logs`
--
ALTER TABLE `visitor_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `website_menus`
--
ALTER TABLE `website_menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `website_menu_items`
--
ALTER TABLE `website_menu_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `aduans`
--
ALTER TABLE `aduans`
  ADD CONSTRAINT `aduans_kecamatan_id_foreign` FOREIGN KEY (`kecamatan_id`) REFERENCES `kecamatans` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `aduans_kelurahan_id_foreign` FOREIGN KEY (`kelurahan_id`) REFERENCES `kelurahans` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `aduans_user_uuid_foreign` FOREIGN KEY (`user_uuid`) REFERENCES `users` (`uuid`) ON DELETE SET NULL;

--
-- Constraints for table `aduan_tindak_lanjuts`
--
ALTER TABLE `aduan_tindak_lanjuts`
  ADD CONSTRAINT `aduan_tindak_lanjuts_aduan_uuid_foreign` FOREIGN KEY (`aduan_uuid`) REFERENCES `aduans` (`uuid`) ON DELETE CASCADE,
  ADD CONSTRAINT `aduan_tindak_lanjuts_user_uuid_foreign` FOREIGN KEY (`user_uuid`) REFERENCES `users` (`uuid`) ON DELETE SET NULL;

--
-- Constraints for table `agendas`
--
ALTER TABLE `agendas`
  ADD CONSTRAINT `articles_category_uuid_foreign` FOREIGN KEY (`category_uuid`) REFERENCES `categories` (`uuid`) ON DELETE SET NULL,
  ADD CONSTRAINT `articles_user_uuid_foreign` FOREIGN KEY (`user_uuid`) REFERENCES `users` (`uuid`) ON DELETE CASCADE;

--
-- Constraints for table `agenda_images`
--
ALTER TABLE `agenda_images`
  ADD CONSTRAINT `agenda_images_agenda_uuid_foreign` FOREIGN KEY (`agenda_uuid`) REFERENCES `agendas` (`uuid`) ON DELETE CASCADE;

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_category_uuid_foreign` FOREIGN KEY (`category_uuid`) REFERENCES `document_categories` (`uuid`) ON DELETE CASCADE;

--
-- Constraints for table `document_versions`
--
ALTER TABLE `document_versions`
  ADD CONSTRAINT `document_versions_document_uuid_foreign` FOREIGN KEY (`document_uuid`) REFERENCES `documents` (`uuid`) ON DELETE CASCADE,
  ADD CONSTRAINT `document_versions_user_uuid_foreign` FOREIGN KEY (`user_uuid`) REFERENCES `users` (`uuid`) ON DELETE SET NULL;

--
-- Constraints for table `kelurahans`
--
ALTER TABLE `kelurahans`
  ADD CONSTRAINT `kelurahans_kecamatan_id_foreign` FOREIGN KEY (`kecamatan_id`) REFERENCES `kecamatans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  ADD CONSTRAINT `maintenance_schedules_aduan_uuid_foreign` FOREIGN KEY (`aduan_uuid`) REFERENCES `aduans` (`uuid`) ON DELETE SET NULL,
  ADD CONSTRAINT `maintenance_schedules_petugas_uuid_foreign` FOREIGN KEY (`petugas_uuid`) REFERENCES `users` (`uuid`) ON DELETE SET NULL;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pages`
--
ALTER TABLE `pages`
  ADD CONSTRAINT `pages_user_uuid_foreign` FOREIGN KEY (`user_uuid`) REFERENCES `users` (`uuid`) ON DELETE SET NULL;

--
-- Constraints for table `poll_votes`
--
ALTER TABLE `poll_votes`
  ADD CONSTRAINT `poll_votes_poll_uuid_foreign` FOREIGN KEY (`poll_uuid`) REFERENCES `polls` (`uuid`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`uuid`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_kecamatan_id_foreign` FOREIGN KEY (`kecamatan_id`) REFERENCES `kecamatans` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `users_kelurahan_id_foreign` FOREIGN KEY (`kelurahan_id`) REFERENCES `kelurahans` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `website_menu_items`
--
ALTER TABLE `website_menu_items`
  ADD CONSTRAINT `website_menu_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `website_menu_items` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `website_menu_items_website_menu_id_foreign` FOREIGN KEY (`website_menu_id`) REFERENCES `website_menus` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
