-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 20, 2026 at 03:41 PM
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
-- Database: `dbmsda`
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
  `judul` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `deskripsi` longtext DEFAULT NULL,
  `gambar` varchar(255) DEFAULT NULL,
  `tanggal` date NOT NULL,
  `waktu_mulai` time DEFAULT NULL,
  `waktu_selesai` time DEFAULT NULL,
  `lokasi` varchar(255) DEFAULT NULL,
  `kapasitas` int(11) DEFAULT NULL,
  `status` enum('draft','published','cancelled','completed') NOT NULL DEFAULT 'draft',
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
-- Table structure for table `articles`
--

CREATE TABLE `articles` (
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
  `status` enum('draft','published','scheduled') NOT NULL DEFAULT 'draft',
  `search_engine` enum('index','noindex') NOT NULL DEFAULT 'index',
  `link` varchar(255) DEFAULT NULL,
  `video` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`uuid`, `user_uuid`, `category_uuid`, `title`, `slug`, `excerpt`, `content`, `featured_image`, `scheduled_at`, `views`, `is_featured`, `is_popular`, `tagging`, `status`, `search_engine`, `link`, `video`, `created_at`, `updated_at`, `deleted_at`) VALUES
('00e80f11-ecf9-4d7f-9864-8a54ab644278', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Penyiraman taman rawapanjang kecamatan Rawalumbu', 'penyiraman-taman-rawapanjang-kecamatan-rawalumbu', 'Penyiraman taman rawapanjang kecamatan Rawalumbu', '', 'images/458595ae86b33586d42969d94c365c21.jpeg', '2022-01-27 07:49:00', 201, 1, 0, 'rawalumbu, penyiraman, taman', 'published', 'index', NULL, NULL, '2022-01-27 07:49:00', '2022-01-27 07:49:00', NULL),
('01882425-533d-4819-85a8-17f8286bf546', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Tim pematusan saluran Tresier Perumahan Taman Alinda Kencana Mulasakti Rw 021 Rt 001  Kel. Kali', 'giat-tim-pematusan-saluran-tresier-perumahan-taman-alinda-kencana-mulasakti-rw-021-rt-001--kel.-kaliabang-tengah-kec.-bekasi-utara', 'Giat Tim pematusan saluran Tresier Perumahan Taman Alinda Kencana Mulasakti Rw 021 Rt 001 Kel. Kali', '', 'images/ec017c058d2dcc20e45d90042ea6767c.jpeg', '2022-08-18 11:05:00', 3153, 0, 0, 'taman, mulasakti, pematusan', 'published', 'index', NULL, NULL, '2022-08-18 11:05:00', '2022-08-18 11:05:00', NULL),
('022cd13b-b535-4990-8a2b-e4ce91eecf5c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'PERBAIKAN LAMPU PJU JALAN MANGGA RAYAPERUM 1 KEL.KERANJI', 'perbaikan-lampu-pju-jalan-mangga-rayaperum-1-kel.keranji', 'PERBAIKAN LAMPU PJU JALAN MANGGA RAYAPERUM 1 KEL.KERANJI', '', 'images/873b72d95e91bfffe632e73505e0567e.jpeg', '2021-10-12 09:29:00', 576, 0, 0, 'perbaikan, lampu, rayaperum', 'published', 'index', NULL, NULL, '2021-10-12 09:29:00', '2021-10-12 09:29:00', NULL),
('0402020f-f66e-46c9-8ba5-c658b4cfb810', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Kunjungan ke Batching Plant di Wilayah Kota Bekasi', 'kunjungan-ke-batching-plant-di-wilayah-kota-bekasi', 'Kunjungan ke Batching Plant di Wilayah Kota Bekasi', '', 'images/d74e93c66df0039c17314847161913c5.jpeg', '2025-07-25 07:50:00', 2288, 0, 0, 'kota bekasi, kunjungan, batching', 'published', 'index', NULL, NULL, '2025-07-25 07:50:00', '2025-07-25 07:50:00', NULL),
('045c63cb-e0a7-4338-9e3c-ef2b4eb0ca96', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'perbaikan lampu PJU dilingkungan RW 02 Kelurahan Jati Cempaka - Kecamatan Pondok Gede', 'perbaikan-lampu-pju-dilingkungan-rw-02-kelurahan-jati-cempaka---kecamatan-pondok-gede', 'perbaikan lampu PJU dilingkungan RW 02 Kelurahan Jati Cempaka - Kecamatan Pondok Gede', '', 'images/a69a7fd74f0374b568ffeb09697f433f.jpg', '2024-01-12 09:39:00', 3309, 0, 1, 'pondok gede, perbaikan, lampu', 'published', 'index', NULL, NULL, '2024-01-12 09:39:00', '2024-01-12 09:39:00', NULL),
('066ecffd-a986-422f-ba3d-0615ad5fa645', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat tim URC Bidang Bina Marga pemeliharaan jalan Ahmad Yani Kecamatan Bekasi Selatan', 'giat-tim-urc-bidang-bina-marga-pemeliharaan-jalan-ahmad-yani-kecamatan-bekasi-selatan', 'Giat tim URC Bidang Bina Marga pemeliharaan jalan Ahmad Yani Kecamatan Bekasi Selatan', '<p>Giat tim URC Bidang Bina Marga pemeliharaan jalan Ahmad Yani Kecamatan Bekasi Selatan<br />\r\n&nbsp;</p>\r\n', 'images/0e4fd079bd2cb1a965b7043c7fd1d56e.jpg', '2025-06-13 07:03:00', 4664, 0, 0, 'bekasi selatan, pemeliharaan, kecamatan', 'published', 'index', NULL, NULL, '2025-06-13 07:03:00', '2025-06-13 07:03:00', NULL),
('06f19938-7877-47d9-b123-bd590d1f04bc', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Rapat perbaikan jalan ambles di Jalan M Hasibuan Simpang M Hasibuan - Kartini', 'rapat-perbaikan-jalan-ambles-di-jalan-m-hasibuan-simpang-m-hasibuan---kartini', 'Kota Bekasi- Dinas Bina Marga dan Sumber Daya Air (DBMSDA) mengadakan rapat perbaikan jalan ambles di Jalan M Hasibuan Simpang M Hasibuan - Kartini. Rapat dihadiri perwakilan...', '<p>Kota Bekasi- Dinas Bina Marga dan Sumber Daya Air (DBMSDA) mengadakan rapat perbaikan jalan ambles di Jalan M Hasibuan Simpang M Hasibuan - Kartini.</p>\r\n\r\n<p>Rapat dihadiri perwakilan dari Polres Metro Bekasi Kota, Dinas Perhubungan Kota Bekasi, PT.PAM Jaya, PT.Bustindo Putra Mandiri, PT.KMU, PT.CRCC, PT. Jagat Kontruksi Abdipersada.</p>\r\n\r\n<p>Sebagai tindak lanjut atas kejadian tersebut,&nbsp;<br />\r\nPihak pelaksana SPAM Buaran Hulu CRCC akan melakukan perbaikan jalan, dan menentukan metode perbaikan jalan.</p>\r\n\r\n<p>Mengantisipasi kepadatan arus lalulintas akibat pekerjaan tersebut, Dishub Kota Bekasi akan melakukan rekayasa lalu lintas dengan menerapkan contra flow bekerja sama dengan pihak satlantas Polres Metro Bekasi Kota.</p>\r\n\r\n<p>Sementara itu, menurut informasi dari pelaksana SPAM akan menargetkan perbaikan jalan 2 sampai3 hari serta waktu pelaksanaan selama 5 hari. (dms)</p>\r\n', 'images/3b098c83e379f06f7ada5efeb356946b.jpeg', '2025-07-31 08:54:00', 3995, 1, 1, 'kota bekasi, perbaikan, pekerjaan', 'published', 'index', NULL, NULL, '2025-07-31 08:54:00', '2025-07-31 08:54:00', NULL),
('071e073d-2ad8-4300-9772-a0343c18ba36', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Tim siram Bidang Prasarana Jalan giat penyiraman taman Jalan median wibawa mukti Kecamatan Jatiasih', 'tim-siram-bidang-prasarana-jalan-giat-penyiraman-taman-jalan-median-wibawa-mukti-kecamatan-jatiasih', 'Tim siram Bidang Prasarana Jalan giat penyiraman taman Jalan median wibawa mukti Kecamatan Jatiasih', '', 'images/157e29972019196b92dcc6544c50d98b.jpeg', '2024-05-07 01:46:00', 1206, 0, 0, 'penyiraman, taman, kecamatan', 'published', 'index', NULL, NULL, '2024-05-07 01:46:00', '2024-05-07 01:46:00', NULL),
('07cb05f9-9ddd-44c2-97c1-3d991720714a', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Stop Gratifikasi', 'stop-gratifikasi', 'Yukkk kita budayakan bersama tidak memberikan imbalan, hadiah dalam bentuk apapun atas pelayanan yang kami berikan kepada masyarakat.', '<p>Yukkk kita budayakan bersama tidak memberikan imbalan, hadiah dalam bentuk apapun atas pelayanan yang kami berikan kepada masyarakat.</p>\r\n', 'images/aa17fe41dc57a92f8e20b44e415a49c5.jpeg', '2022-10-04 03:50:00', 1571, 0, 0, 'masyarakat, memberikan, budayakan', 'published', 'index', NULL, NULL, '2022-10-04 03:50:00', '2022-10-04 03:50:00', NULL),
('0853da32-045e-4e36-97da-35bbd482c755', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Kunjungan kerja DPRD Kota Pasuruan', 'kunjungan-kerja-dprd-kota-pasuruan', 'Kunjungan kerja DPRD Kota Pasuruan ke Dinas Bina Marga dan Sumber Daya Air Kota Bekasi berlangsung dalam rangka memperkuat pemahaman dan sinergi antar daerah terkait...', '<p>Kunjungan kerja DPRD Kota Pasuruan ke Dinas Bina Marga dan Sumber Daya Air Kota Bekasi berlangsung dalam rangka memperkuat pemahaman dan sinergi antar daerah terkait pengembangan infrastruktur yang berorientasi pada peningkatan produktivitas, penguatan kedaulatan nasional, serta pemerataan ekonomi.<br />\r\n<br />\r\nRombongan diterima secara langsung oleh Kepala UPTD Taman, Firman, yang menyampaikan gambaran umum strategi pembangunan infrastruktur di Kota Bekasi. Dalam pemaparannya, dijelaskan bahwa pembangunan infrastruktur tidak hanya difokuskan pada aspek fisik semata, namun juga diarahkan untuk mendorong pertumbuhan ekonomi wilayah, meningkatkan konektivitas antar kawasan, serta mendukung aktivitas masyarakat secara berkelanjutan.<br />\r\n<br />\r\nDiskusi yang berlangsung hangat tersebut membahas berbagai pendekatan pembangunan infrastruktur daerah, mulai dari peningkatan kualitas jalan dan drainase, hingga penataan kawasan perkotaan yang berorientasi pada produktivitas masyarakat. Selain itu, aspek pemerataan pembangunan juga menjadi perhatian utama, guna memastikan seluruh lapisan masyarakat dapat merasakan manfaat dari pembangunan yang dilaksanakan.<br />\r\n<br />\r\nMelalui kunjungan kerja ini, diharapkan terjalin pertukaran informasi, pengalaman, serta praktik terbaik antar pemerintah daerah dalam mewujudkan infrastruktur yang tidak hanya berfungsi sebagai penunjang mobilitas, tetapi juga sebagai penggerak utama pertumbuhan ekonomi dan penguatan kemandirian daerah.<br />\r\n<br />\r\nKegiatan ini ditutup dengan sesi diskusi interaktif dan peninjauan singkat, sebagai bentuk komitmen bersama dalam mendorong pembangunan infrastruktur yang berkelanjutan dan berkeadilan di masing-masing daerah.</p>\r\n', 'images/c4b81e9c54ab55e973f565685ee60be4.jpeg', '2026-04-15 09:34:00', 3660, 0, 0, 'kota bekasi, taman, kegiatan', 'published', 'index', NULL, NULL, '2026-04-15 09:34:00', '2026-04-15 09:34:00', NULL),
('08aa3905-ecc0-4383-b26a-eb6d0ce7cd85', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemeliharaan lampu PJU jalan sawo rw.10 kelurahan jatirasa kecamatan jatiasih', 'pemeliharaan-lampu-pju-jalan-sawo-rw.10-kelurahan-jatirasa-kecamatan-jatiasih', 'Pemeliharaan lampu PJU jalan sawo rw.10 kelurahan jatirasa kecamatan jatiasih', '', 'images/a768f45f4e4b6f0bd0ae0dc659c5e02e.jpeg', '2021-11-30 07:38:00', 3463, 0, 1, 'pemeliharaan, lampu, kecamatan', 'published', 'index', NULL, NULL, '2021-11-30 07:38:00', '2021-11-30 07:38:00', NULL),
('08f088e6-1054-4856-a7dc-d3a62ad9fec1', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'PENANGANAN GENANGAN U-TURN JALAN AHMAD YANI', 'penanganan-genangan-u-turn-jalan-ahmad-yani', 'PENANGANAN GENANGAN U-TURN JALAN AHMAD YANI', '', 'images/54223387aa52c833eb886cc921f38326.jpeg', '2021-10-18 09:21:00', 1059, 0, 1, 'penanganan, genangan, ahmad', 'published', 'index', NULL, NULL, '2021-10-18 09:21:00', '2021-10-18 09:21:00', NULL),
('0ad278d5-1113-40c2-88f8-27009754727d', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pemangkasan pohon jalan raya pekayon kecamatan bekasi selatan', 'pemangkasan-pohon-jalan-raya-pekayon-kecamatan-bekasi-selatan', 'pemangkasan pohon jalan raya pekayon kecamatan bekasi selatan', '', 'images/829e9f4db7ea1eef16f710d904e4645a.jpeg', '2025-06-17 06:02:00', 4535, 0, 1, 'bekasi selatan, pemangkasan, kecamatan', 'published', 'index', NULL, NULL, '2025-06-17 06:02:00', '2025-06-17 06:02:00', NULL),
('0ae1cd3e-a5d8-4239-be54-84889340d09c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'penyiraman taman jalan wibawamukti', 'penyiraman-taman-jalan-wibawamukti', 'penyiraman taman jalan wibawamukti', '', 'images/52863a2896efea38277fd8c6c6f0154c.jpeg', '2021-12-03 02:16:00', 3786, 0, 0, 'penyiraman, taman, wibawamukti', 'published', 'index', NULL, NULL, '2021-12-03 02:16:00', '2021-12-03 02:16:00', NULL),
('0b2324fe-6400-4afb-8781-6269e1ac51b3', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pengaspalan menggunakan aspal dingin atau cold mix jalan KH.Noer Ali  ', 'pengaspalan-menggunakan-aspal-dingin-atau-cold-mix-jalan-kh.noer-ali', 'Pengaspalan menggunakan aspal dingin atau cold mix jalan KH.Noer Ali', '', 'images/fe143f570a64bb1853de1bfb73a610eb.jpg', '2021-09-30 17:03:00', 2151, 0, 0, 'menggunakan, pengaspalan, dingin', 'published', 'index', NULL, NULL, '2021-09-30 17:03:00', '2021-09-30 17:03:00', NULL),
('0b711595-00fe-4477-a49e-23fa4d13a7b8', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Kegiatan Pemeliharaan Taman Jl. Cut Mutiah Bekasi Timur', 'kegiatan-pemeliharaan-taman-jl.-cut-mutiah-bekasi-timur', 'Kegiatan Pemeliharaan Taman Jl. Cut Mutiah Bekasi Timur', '<h2>Kegiatan Pemeliharaan Taman Jl. Cut Mutiah Bekasi Timur</h2>\r\n', 'images/48f698c77402b4c84737129bbb9eb4e7.jpg', '2020-11-10 23:20:00', 3912, 0, 0, 'bekasi timur, cut mutiah, pemeliharaan', 'published', 'index', NULL, NULL, '2020-11-10 23:20:00', '2020-11-10 23:20:00', NULL),
('0d57b4d0-7e17-4066-a629-116585d4349f', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Pembersihan saluran sekunder kali Sasak jarang samping folder arenjaya RW 005  Kelurahan Arenja', 'giat-pembersihan-saluran-sekunder-kali-sasak-jarang-samping-folder-arenjaya-rw-005--kelurahan-arenjaya-kecamatan-bekasi-timur', 'Giat Pembersihan saluran sekunder kali Sasak jarang samping folder arenjaya RW 005 Kelurahan Arenja', '', 'images/4615a1c7faf87b322141d5e760bb8294.jpeg', '2023-11-09 07:32:00', 900, 1, 0, 'pembersihan, kelurahan, arenjaya', 'published', 'index', NULL, NULL, '2023-11-09 07:32:00', '2023-11-09 07:32:00', NULL),
('0d744e26-bf85-405a-b350-d17c4b9935c0', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pengaspalan jalan cipendawa', 'pengaspalan-jalan-cipendawa', 'Pengaspalan jalan cipendawa', '', 'images/d7c217ba6bfd9660a5be32761b4cc059.jpeg', '2021-09-24 09:08:00', 3633, 1, 1, 'pengaspalan, cipendawa', 'published', 'index', NULL, NULL, '2021-09-24 09:08:00', '2021-09-24 09:08:00', NULL),
('0e2bda27-d4ba-45f8-99cc-653a030ba49f', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Pemangkasan pohon di wilayah Jalan Cendana Raya RW 06 Perum Jaka Permai Bekasi Selatan', 'giat-pemangkasan-pohon-di-wilayah-jalan-cendana-raya-rw-06-perum-jaka-permai-bekasi-selatan', 'Giat Pemangkasan pohon di wilayah Jalan Cendana Raya RW 06 Perum Jaka Permai Bekasi Selatan', '', 'images/1ebb02b98e6ae5b046da2c336b7f452d.jpeg', '2024-06-13 03:12:00', 4637, 0, 1, 'bekasi selatan, pemangkasan, cendana', 'published', 'index', NULL, NULL, '2024-06-13 03:12:00', '2024-06-13 03:12:00', NULL),
('0e4bc8c1-493c-4913-af24-28f78980c906', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Tim URC Pangkas Bidang Prasarana Jalan Giat penebangan pohon jl Lumbu Utara Raya RT 002 RW 002', 'tim-urc-pangkas-bidang-prasarana-jalan-giat-penebangan-pohon-jl-lumbu-utara-raya-rt-002-rw-002', 'Tim URC Pangkas Bidang Prasarana Jalan Giat penebangan pohon jl Lumbu Utara Raya RT 002 RW 002', '', 'images/1c9a8503d67b8bf0cab69695190c92d2.jpeg', '2024-05-07 01:42:00', 4651, 0, 0, 'pangkas, penebangan, prasarana', 'published', 'index', NULL, NULL, '2024-05-07 01:42:00', '2024-05-07 01:42:00', NULL),
('0f7c431c-5137-4971-ab90-a94427d3bfba', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemeliharaan Lampu PJU Di jalan raya Al-Ikhsan Kelurahan jatibening baru kecamatan pondok gede ', 'pemeliharaan-lampu-pju-di-jalan-raya-al-ikhsan-kelurahan-jatibening-baru-kecamatan-pondok-gede', 'Pemeliharaan Lampu PJU Di jalan raya Al-Ikhsan Kelurahan jatibening baru kecamatan pondok gede', '', 'images/c044c2352cf71008f4593aa71e1d19ca.jpeg', '2022-01-28 08:06:00', 657, 0, 0, 'pondok gede, pemeliharaan, lampu', 'published', 'index', NULL, NULL, '2022-01-28 08:06:00', '2022-01-28 08:06:00', NULL),
('102f94b3-7715-45b7-955f-d9f0723d277a', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Kepala dinas bmsdakotabekasi memberikan paparan di hadapan penguji dalam ivent Bekasi Innovation Wee', 'kepala-dinas-bmsdakotabekasi-memberikan-paparan-di-hadapan-penguji-dalam-ivent-bekasi-innovation-week-2021', 'Kepala dinas bmsdakotabekasi memberikan paparan di hadapan penguji dalam ivent Bekasi Innovation Wee', '', 'images/9de34ed6a5feb59c3b6e853754fcd78b.jpeg', '2021-10-11 08:56:00', 1755, 0, 0, 'bmsdakotabekasi, innovation, memberikan', 'published', 'index', NULL, NULL, '2021-10-11 08:56:00', '2021-10-11 08:56:00', NULL),
('11ea14f1-6d61-4add-8b83-28f90192b09f', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat tim URC Bidang Bina Marga Pengaspalan Jalan Semeru, Jatibening Kecamatan Bekasi Selatan', 'giat-tim-urc-bidang-bina-marga-pengaspalan-jalan-semeru,-jatibening-kecamatan-bekasi-selatan', 'Giat tim URC Bidang Bina Marga Pengaspalan Jalan Semeru, Jatibening Kecamatan Bekasi Selatan', '', 'images/8dcac546cf9d64caa7873b9ccb54f0ea.jpg', '2025-06-16 09:25:00', 1320, 0, 0, 'bekasi selatan, pengaspalan, jatibening', 'published', 'index', NULL, NULL, '2025-06-16 09:25:00', '2025-06-16 09:25:00', NULL),
('135d1176-80be-42d7-8076-8d9aee58241e', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Pematusan saluran sekunder perumahan jatibening 2 rw.008 Kelurahan jatibening baru', 'giat-pematusan-saluran-sekunder-perumahan-jatibening-2-rw.008-kelurahan-jatibening-baru', 'Giat Pematusan saluran sekunder perumahan jatibening 2 rw.008 Kelurahan jatibening baru', '', 'images/2e84ee12abcb56e1bee2a644824ff366.jpeg', '2024-01-15 10:18:00', 2017, 0, 0, 'jatibening, kelurahan, pematusan', 'published', 'index', NULL, NULL, '2024-01-15 10:18:00', '2024-01-15 10:18:00', NULL),
('13b9467f-a61a-433e-a050-03c32e5cd259', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pengaspalan jalan raya pekayon ', 'pengaspalan-jalan-raya-pekayon', 'Pengaspalan jalan raya pekayon', '', 'images/bcb09546bcce72b026889193c18d5f9d.jpeg', '2021-11-18 09:03:00', 3951, 0, 0, 'pengaspalan, pekayon, raya', 'published', 'index', NULL, NULL, '2021-11-18 09:03:00', '2021-11-18 09:03:00', NULL),
('16766839-538e-4e05-8d1c-75f22fe7180c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pengaspalan jalan cut mutia  ', 'pengaspalan-jalan-cut-mutia', 'Pengaspalan jalan cut mutia', '', 'images/864d8ffaf7af22c1dbb244e9e2b66f05.jpeg', '2021-12-03 02:14:00', 1163, 0, 0, 'pengaspalan, mutia', 'published', 'index', NULL, NULL, '2021-12-03 02:14:00', '2021-12-03 02:14:00', NULL),
('1932865d-bece-4161-b3cf-74f10082f5f6', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat pemangkasan pohon jalan ratna kecamatan jatiasih.', 'giat-pemangkasan-pohon-jalan-ratna-kecamatan-jatiasih.', 'Giat pemangkasan pohon jalan ratna kecamatan jatiasih.', '', 'images/976288b85d42a916182f3d83133a05d6.jpeg', '2022-08-10 08:52:00', 1789, 0, 0, 'pemangkasan, kecamatan, jatiasih', 'published', 'index', NULL, NULL, '2022-08-10 08:52:00', '2022-08-10 08:52:00', NULL),
('19cbca19-1824-4df9-9c10-92b945417c01', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'monitoring bersama walikota bekasi di perumahan bukit kencana pondok gede', 'monitoring-bersama-walikota-bekasi-di-perumahan-bukit-kencana-pondok-gede', 'monitoring bersama walikota bekasi di perumahan bukit kencana pondok gede', '', 'images/6e311cb4860ff78c7a58c0f95f240a4c.jpeg', '2021-11-17 08:35:00', 384, 0, 0, 'kota bekasi, pondok gede, walikota bekasi', 'published', 'index', NULL, NULL, '2021-11-17 08:35:00', '2021-11-17 08:35:00', NULL),
('1f2436aa-61c8-4d27-93cd-c9bbc3e8b6a5', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Apel pagi memperingati HUT KORPRI KE 50 TAHUN 2021 di lingkungan kantor dinas bmsdakotabekasi ', 'apel-pagi-memperingati-hut-korpri-ke-50-tahun-2021-di-lingkungan-kantor-dinas-bmsdakotabekasi', 'Apel pagi memperingati HUT KORPRI KE 50 TAHUN 2021 di lingkungan kantor dinas bmsdakotabekasi', '', 'images/8dd90563ecc59afcfec7ab1d42e290ac.jpeg', '2021-11-29 02:44:00', 3011, 0, 0, 'bmsdakotabekasi, memperingati, kantor', 'published', 'index', NULL, NULL, '2021-11-29 02:44:00', '2021-11-29 02:44:00', NULL),
('1f9796d2-6d72-4e9a-9712-34aab44ada19', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan pohon di pertigaan jalan sawo kel.bantargebang', 'pemangkasan-pohon-di-pertigaan-jalan-sawo-kel.bantargebang', 'Pemangkasan pohon di pertigaan jalan sawo kel.bantargebang', '', 'images/2c9414cb7efa93b491c27a6db5ca96f9.jpeg', '2021-11-15 09:15:00', 870, 1, 1, 'bantargebang, pemangkasan, pertigaan', 'published', 'index', NULL, NULL, '2021-11-15 09:15:00', '2021-11-15 09:15:00', NULL),
('21dcbff3-67f0-437f-bd53-b6a706bcfe98', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Survey Kepuasan Masyarakat ( IKM )', 'survey-kepuasan-masyarakat-(-ikm-)', 'Berikut hasil survey Kepuasan Masyarakat Dinas Bina Marga dan Sumber Daya Air Kota Bekasi Semester 1 Tahun 2023. dengan nilai rata -rata 92.53% A (Sangat Baik)', '<p>Berikut hasil survey Kepuasan Masyarakat<br />\r\nDinas Bina Marga dan Sumber Daya Air<br />\r\nKota Bekasi Semester 1 Tahun 2023.</p>\r\n\r\n<p>dengan nilai rata -rata 92.53% A (Sangat Baik)</p>\r\n', 'images/18e447f49f388b9be2680966cfeb2cfb.jpg', '2023-08-02 04:38:00', 1436, 0, 0, 'kota bekasi, rata, masyarakat', 'published', 'index', NULL, NULL, '2023-08-02 04:38:00', '2023-08-02 04:38:00', NULL),
('21e200ea-a4a1-4c87-a598-497c9b1ebe59', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Rapat Perencanaan APBD Tahun Anggaran 2026.', 'rapat-perencanaan-apbd-tahun-anggaran-2026.', 'Rapat Perencanaan APBD Tahun Anggaran 2026.', '', 'images/6a9159fb5ec58ea1f303a39807bfc4e7.jpeg', '2025-06-16 05:13:00', 2317, 1, 0, 'perencanaan, anggaran, rapat', 'published', 'index', NULL, NULL, '2025-06-16 05:13:00', '2025-06-16 05:13:00', NULL),
('22536135-482b-4f63-b3c5-621c6cd9e516', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemasangan lampu PJU Jl.Bali Rotan Kel.Cikiwul Kec.Bantargebang', 'pemasangan-lampu-pju-jl.bali-rotan-kel.cikiwul-kec.bantargebang', 'Pemasangan lampu PJU Jl.Bali Rotan Kel.Cikiwul Kec.Bantargebang', '', 'images/1247aa634975fa01b64f2a50f8ec8540.jpeg', '2021-10-19 08:55:00', 1125, 1, 0, 'bantargebang, lampu, pemasangan', 'published', 'index', NULL, NULL, '2021-10-19 08:55:00', '2021-10-19 08:55:00', NULL),
('240f5863-af52-46b3-adeb-8bc168947b30', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Tim Pematusan pemeliharaan saluran tersier Rw.10 Perumahan dukuh zamrud Kecamatan Mustikajaya.', 'giat-tim-pematusan-pemeliharaan-saluran-tersier-rw.10-perumahan-dukuh-zamrud-kecamatan-mustikajaya.', 'Giat Tim Pematusan pemeliharaan saluran tersier Rw.10 Perumahan dukuh zamrud Kecamatan Mustikajaya.', '', 'images/8eaa3bf4a501bfa62cd3fc87bea93d1c.jpeg', '2022-08-04 08:26:00', 4574, 0, 0, 'pemeliharaan, mustikajaya, kecamatan', 'published', 'index', NULL, NULL, '2022-08-04 08:26:00', '2022-08-04 08:26:00', NULL),
('245c79ce-086a-461f-834c-8843815b5812', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'rapat koordinasi tim PPID', 'rapat-koordinasi-tim-ppid', 'rapat koordinasi tim PPID', '', 'images/19c81ed15767fa8f7a18dd413ccf0b3e.jpeg', '2025-10-08 02:49:00', 1489, 0, 0, 'koordinasi, rapat, ppid', 'published', 'index', NULL, NULL, '2025-10-08 02:49:00', '2025-10-08 02:49:00', NULL),
('246a5432-38a4-4027-9509-74b42de34559', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Penyiraman Taman Kolong FO Keranji', 'penyiraman-taman-kolong-fo-keranji', 'Penyiraman Taman Kolong FO Keranji', '', 'images/7d464553ad2ec8f732872493b597beaf.jpeg', '2021-09-08 07:24:00', 476, 0, 0, 'penyiraman, taman, keranji', 'published', 'index', NULL, NULL, '2021-09-08 07:24:00', '2021-09-08 07:24:00', NULL),
('2495f4df-5627-4e85-80bd-6dd7f5d6c820', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan di Jln Flamboyan Kp.Sawah No.86.Rt.007/.RW.001. Kel.Jatimelati. Kec.Pondok melati.', 'pemangkasan-di-jln-flamboyan-kp.sawah-no.86.rt.007/.rw.001.-kel.jatimelati.-kec.pondok-melati.', 'Pemangkasan di Jln Flamboyan Kp.Sawah No.86.Rt.007/.RW.001. Kel.Jatimelati. Kec.Pondok melati.', '', 'images/6cc3e77447491e5eba69394820dff65e.jpeg', '2025-07-31 08:52:00', 4140, 0, 0, 'pondok melati, pemangkasan, jatimelati', 'published', 'index', NULL, NULL, '2025-07-31 08:52:00', '2025-07-31 08:52:00', NULL),
('25219779-3165-4ed4-90a6-729aa0dcb528', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pemangkasan pohon Jln. Kenanga Blok.BS35,No.6 RT.001/Rw012. Kel. Jatisampurna. Kec. Jatisampurna.', 'pemangkasan-pohon-jln.-kenanga-blok.bs35,no.6-rt.001/rw012.-kel.-jatisampurna.-kec.-jatisampurna.', 'pemangkasan pohon Jln. Kenanga Blok.BS35,No.6 RT.001/Rw012. Kel. Jatisampurna. Kec. Jatisampurna.', '', 'images/26594b528d515db98b73925a9571c66a.jpeg', '2025-07-15 05:37:00', 3654, 0, 0, 'jatisampurna, pemangkasan, kenanga', 'published', 'index', NULL, NULL, '2025-07-15 05:37:00', '2025-07-15 05:37:00', NULL),
('2542a658-e54d-415c-b301-378fc80bc103', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Brifing bersama tim Admin Pengaduan dan Medsos dalam rangka meningkatkan pelaporan dan pelayanan kepada masyarakat ', 'brifing-bersama-tim-admin-pengaduan-dan-medsos-dalam-rangka-meningkatkan-pelaporan-dan-pelayanan-kepada-masyarakat', 'Brifing bersama tim Admin Pengaduan dan Medsos dalam rangka meningkatkan pelaporan dan pelayanan kepada masyarakat', '', 'images/2b093baa90aeda22e4d36fd2d387b220.jpeg', '2025-06-30 10:24:00', 4684, 0, 0, 'meningkatkan, masyarakat, pelaporan', 'published', 'index', NULL, NULL, '2025-06-30 10:24:00', '2025-06-30 10:24:00', NULL),
('256cfc21-4259-470d-ae4d-33137d24fbd5', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Tim UPTD Pematusan telah  melaksanakan giat pengangkatan sampah di Kali Kapuk Pasar Family Kelurahan', 'tim-uptd-pematusan-telah--melaksanakan-giat-pengangkatan-sampah-di-kali-kapuk-pasar-family-kelurahan-pejuang-kecamatan-medan-satria', 'Tim UPTD Pematusan telah melaksanakan giat pengangkatan sampah di Kali Kapuk Pasar Family Kelurahan', '', 'images/3c8c5cf78e75445bf870125d13a031af.jpg', '2024-05-07 01:44:00', 3811, 1, 0, 'melaksanakan, pengangkatan, kelurahan', 'published', 'index', NULL, NULL, '2024-05-07 01:44:00', '2024-05-07 01:44:00', NULL),
('26d018f5-10ae-4700-b004-8c59c024835c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pembersihan tali air di jalan Chairil Anwar Kecamatan Bekasi Timur', 'pembersihan-tali-air-di-jalan-chairil-anwar-kecamatan-bekasi-timur', 'pembersihan tali air di jalan Chairil Anwar Kecamatan Bekasi Timur', '', 'images/881f71f8dc0ab252a6fb3356ceb99624.jpeg', '2024-02-28 09:30:00', 3232, 0, 1, 'bekasi timur, pembersihan, kecamatan', 'published', 'index', NULL, NULL, '2024-02-28 09:30:00', '2024-02-28 09:30:00', NULL),
('26dbf21f-739a-4aa6-a202-d8e1273c10bd', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Upacara Peringatan HUT KEMERDEKAAN RI Ke-77 dilingkungan Dinas Bina Marga dan Sumber Daya Air ', 'upacara-peringatan-hut-kemerdekaan-ri-ke-77-dilingkungan-dinas-bina-marga-dan-sumber-daya-air', 'Upacara Peringatan HUT KEMERDEKAAN RI Ke-77 dilingkungan Dinas Bina Marga dan Sumber Daya Air Kota Bekasi dan Dinas Pendidikan Kota Bekasi dilaksanakan di halaman kantor Dinas....', '<p>Upacara Peringatan HUT KEMERDEKAAN RI Ke-77 dilingkungan Dinas Bina Marga dan Sumber Daya Air Kota Bekasi dan Dinas Pendidikan Kota Bekasi dilaksanakan di halaman kantor Dinas.<br />\r\n<br />\r\nKepala Dinas Bina Marga dan Sumber Daya Air Kota Bekasi Dr.Arief Maulana, ST.MM memimpin upacara tersebut dengan diikuti oleh Sekretaris Dinas, para Pejabat Struktural, Fungsional dan seluruh pegawai serta Non PNS Dinas Bina Marga dan Sumber Daya Air Kota Bekasi.<br />\r\n<br />\r\nDalam sambutannya, Kepala Dinas Bina Marga dan Sumber Daya Air Kota Bekasi Dr.Arief Maulana, ST.MM menyampaikan pidato singkat dari Plt.walikota Bekasi. Makna filosofi yang terkandung pada HUT Ke 77 Adalah : : SEMANGAT BANGKIT, BERSINERGI, HARAPAN BAIK, PULIH BERSAMA, KUAT, PERSATUAN BANGSA, DAN PERCEPATAN.<br />\r\n<br />\r\nSejarah perjuangan kemerdekaan Indonesia di Kota Bekasi dan perjuangan rakyat bekasi yang di pimpin oleh seorang tokoh ulama kharismatik KH.Noer Ali perlu tetapmemnjadi inspirasi patriotic bagi warga kota bekasi dan bagi generasi penerus estafet kejuangan dalam membangun kota ini.<br />\r\n<br />\r\nkegiatan Upacara kali ini berjalan secara khusu, khimad dan lancar, setelah upacara bendera selesai dianjutkan dengan acara penampilan paduan suara dari Dinas Bina Marga dan Sumber Daya Air Kota Bekasi dan Dinas Pendidikan Kota Bekasi serta foto bersama.</p>\r\n', 'images/d0b526c1852d70fee724050dda4a937c.jpeg', '2022-08-18 11:03:00', 2125, 1, 0, 'kota bekasi, walikota bekasi, kegiatan', 'published', 'index', NULL, NULL, '2022-08-18 11:03:00', '2022-08-18 11:03:00', NULL),
('279caf66-227d-42d9-ba1d-af38e7731e00', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan pohon di perumahan Rawalumbu jembatan 5 Kecamatan Rawalumbu.', 'pemangkasan-pohon-di-perumahan-rawalumbu-jembatan-5-kecamatan-rawalumbu.', 'Pemangkasan pohon di perumahan Rawalumbu jembatan 5 Kecamatan Rawalumbu.', '', 'images/3fd9d38bf23a135aa8274b969b551681.jpeg', '2022-08-18 11:04:00', 858, 0, 1, 'rawalumbu, pemangkasan, kecamatan', 'published', 'index', NULL, NULL, '2022-08-18 11:04:00', '2022-08-18 11:04:00', NULL),
('288eafd6-82a5-45ae-83f6-e4e508b60a82', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Joint Survei dengan Pihak KKDM dan Waskita', 'joint-survei-dengan-pihak-kkdm-dan-waskita', 'Joint Survei dengan Pihak KKDM dan Waskita terkait Rencana Serah Terima Pekerjaan Perbaikan Jalan KH. Noer Ali Kalimalang Sisi Utara akibat Pembangunan Tol Becakayu Seksi 2A', '<p>Joint Survei dengan Pihak KKDM dan Waskita terkait Rencana Serah Terima Pekerjaan Perbaikan Jalan KH. Noer Ali Kalimalang Sisi Utara akibat Pembangunan Tol Becakayu Seksi 2A</p>\r\n', 'images/5e2253acbf551a658c2dcdc4bdbef672.jpeg', '2021-09-09 09:35:00', 4698, 0, 0, 'perbaikan, pekerjaan, serah terima', 'published', 'index', NULL, NULL, '2021-09-09 09:35:00', '2021-09-09 09:35:00', NULL),
('29a5c59b-4e14-4322-bef4-d98e735bb73c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Tingkatkan Kualitas SDM, DBMSDA Kota Bekasi Gelar Pelatihan Informatika', 'tingkatkan-kualitas-sdm,-dbmsda-kota-bekasi-gelar-pelatihan-informatika', 'Bekasi, 10 Juli 2025 Tingkatkan Kualitas SDM, DBMSDA Kota Bekasi Gelar Pelatihan Informatika Kota Bekasi – Dalam upaya meningkatkan kualitas sumber daya manusia (SDM), Dinas...', '<p>Bekasi, 10 Juli 2025<br />\r\nTingkatkan Kualitas SDM, DBMSDA Kota Bekasi Gelar Pelatihan Informatika</p>\r\n\r\n<p>Kota Bekasi &ndash; Dalam upaya meningkatkan kualitas sumber daya manusia (SDM), Dinas Bina Marga dan Sumber Daya Air (DBMSDA) Kota Bekasi menggelar pelatihan informatika dan pemanfaatan media sosial bagi jajaran pegawai, Kamis (10/7), bertempat di ruang rapat kantor DBMSDA.</p>\r\n\r\n<p>Pelatihan ini difokuskan pada penguatan kapasitas dalam penanganan pengaduan masyarakat serta penyusunan konten pemberitaan untuk publikasi kegiatan dinas. Kegiatan ini juga menjadi bagian dari strategi komunikasi publik DBMSDA guna memperkuat transparansi dan pelayanan informasi kepada masyarakat.</p>\r\n\r\n<p>Hadir sebagai narasumber, Muhamad Muchlis dari Dinas Komunikasi, Informatika, Statistik dan Persandian (Diskominfostandi) Kota Bekasi. Ia memberikan pembekalan teknis kepada para pegawai di bidang publikasi dan dokumentasi media DBMSDA, termasuk perwakilan dari Diskominfostandi.</p>\r\n\r\n<p>Dalam paparannya, Muchlis menjelaskan pentingnya penguasaan prinsip-prinsip dasar jurnalistik, terutama dalam menerapkan kaidah 5W + 1H (What, Who, When, Where, Why, dan How) dalam setiap penulisan berita dinas. Ia juga menekankan pentingnya ketepatan informasi serta konsistensi dalam penyampaian pesan publik oleh instansi pemerintahan.</p>\r\n\r\n<p>Kegiatan pelatihan ini merupakan arahan langsung dari sekretaris dinas bmsda selaku PPID pembantu pada Dinas BMSDA Kota Bekasi, yang menekankan pentingnya peran setiap pegawai dalam mendukung publikasi kegiatan dinas secara efektif dan profesional.</p>\r\n\r\n<p>Acara diakhiri dengan sesi foto bersama antara narasumber dan seluruh peserta pelatihan sebagai bentuk dokumentasi dan apresiasi atas partisipasi aktif para peserta dalam kegiatan In-House Training ini.</p>\r\n\r\n<p>Dms (DBMSDA)</p>\r\n', 'images/001fd05d0f184a63ff49977f0a9d9ae9.jpeg', '2025-07-10 09:30:00', 2990, 0, 0, 'kota bekasi, kegiatan, dinas', 'published', 'index', NULL, NULL, '2025-07-10 09:30:00', '2025-07-10 09:30:00', NULL),
('2a72d58c-f881-4466-b639-2120ca0ab428', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Rapat terkait Pembahasan lahan di Simpang Pekayon', 'rapat-terkait-pembahasan-lahan-di-simpang-pekayon', 'Rapat terkait Pembahasan lahan di Simpang Pekayon', '', 'images/adb930a6399d55706e461bf8cc17d23b.jpeg', '2025-07-04 03:45:00', 3228, 0, 0, 'pembahasan, pekayon, simpang', 'published', 'index', NULL, NULL, '2025-07-04 03:45:00', '2025-07-04 03:45:00', NULL),
('2bbc1997-b6cb-485d-83e0-0836c1f8e4f0', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', '3 TAHUN KEPEMIMPINAN Dr.Rahmat Effendi dan Dr.Tri Adhianto Tjahyono', '3-tahun-kepemimpinan-dr.rahmat-effendi-dan-dr.tri-adhianto-tjahyono', '3 Tahun Kepemimpinan @bangpepen03 bersama @mastriadhianto berharap menghasilkan yang terbaik untuk Kota Bekasi dalam capaian Visi Misinya. Kerja kita belum tuntas, kerja kita...', '<p>3 Tahun Kepemimpinan @bangpepen03 bersama @mastriadhianto berharap menghasilkan yang terbaik untuk Kota Bekasi dalam capaian Visi Misinya.</p>\r\n\r\n<p>Kerja kita belum tuntas, kerja kita masih ada yang harus dipertanggung jawabkan. Mari kita doakan bersama untuk sebuah hasil terbaik.</p>\r\n\r\n<p>Karena pelayanan kepada Masyarakat adalah prioritas utama kami.</p>\r\n\r\n<p>SALAM PATRIOT !!!!</p>\r\n\r\n<p>#3tahun #kepemimpinan #walikotabekasi #wakilwalikotabekasi #rahmateffendi #triadhianto #kotabekasi</p>\r\n', 'images/48bfd974aec3788e03e33c38f36ae747.jpg', '2021-09-20 12:40:00', 655, 0, 0, 'kota bekasi, kita, kepemimpinan', 'published', 'index', NULL, NULL, '2021-09-20 12:40:00', '2021-09-20 12:40:00', NULL),
('2cb676c1-0a9a-46f2-a739-9cbd0e8b3ecb', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan pohon di perum mutiara gading timur kecamatan mustikajaya', 'pemangkasan-pohon-di-perum-mutiara-gading-timur-kecamatan-mustikajaya', 'Pemangkasan pohon di perum mutiara gading timur kecamatan mustikajaya', '', 'images/b8318279f1e428e5d9637f3d77676791.jpeg', '2021-11-24 09:05:00', 2814, 0, 0, 'mustikajaya, pemangkasan, kecamatan', 'published', 'index', NULL, NULL, '2021-11-24 09:05:00', '2021-11-24 09:05:00', NULL),
('2eaf367b-a4a7-44ed-bb98-5060e4703d22', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat K3 Tim URC Bina Marga di jalan Chairil Anwar kecamatan Bekasi Timur', 'giat-k3-tim-urc-bina-marga-di-jalan-chairil-anwar-kecamatan-bekasi-timur', 'Giat K3 Tim URC Bina Marga di jalan Chairil Anwar kecamatan Bekasi Timur', '', 'images/4e86a411ddb3ef7714abdbfb56451334.jpeg', '2022-01-21 08:27:00', 1985, 0, 0, 'bekasi timur, kecamatan, chairil', 'published', 'index', NULL, NULL, '2022-01-21 08:27:00', '2022-01-21 08:27:00', NULL),
('2fb3ed9e-5297-4fad-93b0-ba774383ef66', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Monitoring pelaksanaan vaksinasi di SMPN 11 Kota Bekasi', 'monitoring-pelaksanaan-vaksinasi-di-smpn-11-kota-bekasi', 'Monitoring pelaksanaan vaksinasi di SMPN 11 Kota Bekasi', '', 'images/e3397559fabed4c88411e8418e0fce43.jpeg', '2021-08-20 08:30:00', 1446, 0, 0, 'kota bekasi, pelaksanaan, monitoring', 'published', 'index', NULL, NULL, '2021-08-20 08:30:00', '2021-08-20 08:30:00', NULL),
('30240c65-1372-4b20-a4de-bba888962c28', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'PENYIRAMAN TAMAN PEDESTRIAN JALAN AHMAD YANI', 'penyiraman-taman-pedestrian-jalan-ahmad-yani', 'PENYIRAMAN TAMAN PEDESTRIAN JALAN AHMAD YANI', '', 'images/4e0e448c41062579862d429dbdb6ae56.jpeg', '2021-12-13 01:57:00', 2987, 0, 0, 'penyiraman, taman, pedestrian', 'published', 'index', NULL, NULL, '2021-12-13 01:57:00', '2021-12-13 01:57:00', NULL),
('30f41bc9-3f68-4b56-ad99-e8815ccf1894', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Audensi bersama  Bpk. Wakil Wali Kota Bekasi dengan Forum RW BSK terkait pembangunan duplikasi cross', 'audensi-bersama--bpk.-wakil-wali-kota-bekasi-dengan-forum-rw-bsk-terkait-pembangunan-duplikasi-crossing-bsk', 'Audensi bersama Bpk. Wakil Wali Kota Bekasi dengan Forum RW BSK terkait pembangunan duplikasi cross', '', 'images/fe5e0ffb7a3c44295f9106b5a97d2a41.jpg', '2021-09-07 15:05:00', 1786, 1, 0, 'kota bekasi, pembangunan, duplikasi', 'published', 'index', NULL, NULL, '2021-09-07 15:05:00', '2021-09-07 15:05:00', NULL),
('3131a97a-d68e-4176-afc7-c9d48936f342', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pematusan saluran Sekunder Saluran Air Grand Dika Bekasi Timur', 'pematusan-saluran-sekunder-saluran-air-grand-dika-bekasi-timur', 'Pematusan saluran Sekunder Saluran Air Grand Dika Bekasi Timur', '', 'images/776ab5f2be6b973f434178e45bddd85b.jpeg', '2024-01-05 09:38:00', 733, 0, 0, 'bekasi timur, saluran, pematusan', 'published', 'index', NULL, NULL, '2024-01-05 09:38:00', '2024-01-05 09:38:00', NULL),
('31e5e95f-1587-461e-9c18-a7532a3a095b', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Tim URC PJU melaksanakan giat pemeliharaan lampu PJU DI lingkungan RSUD Bantargebang', 'tim-urc-pju-melaksanakan-giat-pemeliharaan-lampu-pju-di-lingkungan-rsud-bantargebang', 'Tim URC PJU melaksanakan giat pemeliharaan lampu PJU DI lingkungan RSUD Bantargebang', '', 'images/10a063742907737bff2a411f99bf207d.jpg', '2024-01-29 10:40:00', 1714, 0, 1, 'bantargebang, pemeliharaan, lampu', 'published', 'index', NULL, NULL, '2024-01-29 10:40:00', '2024-01-29 10:40:00', NULL),
('322e095f-d4eb-482e-8126-2c26aff7d11e', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'PEMKOT BEKASI SEDIAKAN SENTRA VAKSINASI DI STADION PCB ', 'pemkot-bekasi-sediakan-sentra-vaksinasi-di-stadion-pcb', 'KOTA BEKASI - Dalam rangka meningkatkan kekebalan kelompok di masyarakat atau herd immunity, Pemerintah Kota Bekasi gencar menggelar vaksinasi di banyak titik lokasi di seluruh...', '<p>KOTA BEKASI - Dalam rangka meningkatkan kekebalan kelompok di masyarakat atau herd immunity, Pemerintah Kota Bekasi gencar menggelar vaksinasi di banyak titik lokasi di seluruh wilayah Kecamatan/Kelurahan di Kota Bekasi, namun untuk menjangkau masyarakat lebih luas dan lebih banyak lagi, sehingga semakin banyak lagi masyarakat tervaksin, maka kini dibuka Sentra Vaksinasi di Stadion Patriot Candrabhaga (PCB).&nbsp;</p>\r\n\r\n<p>Sentra Vaksinasi Stadion PCB dibuka pada hari kerja (Senin s.d Jum&#39;at) dan menyediakan vaksin jenis Sinovac, Pfizer, dan Astra Zeneca baik untuk dosis pertama dan dosis kedua, maka masyarakat hanya perlu menyesuaikan kebutuhannya, hendak divaksin dosis pertama atau kedua.&nbsp;</p>\r\n\r\n<p>Baik dosis pertama dan dosis kedua pendaftarannya langsung di tempat menuju Gate 10 yang pelaksanaan vaksinnya ada di Gate 12 dengan membawa fotocopy KTP dan KK, serta khusus untuk dosis kedua diwajibkan menyertakan bukti kartu vaksinasi dosis pertama.&nbsp;</p>\r\n\r\n<p>Wali Kota Bekasi menyampaikan bahwa dibukanya Sentra Vaksinasi tujuannya adalah untuk mengakomodir kebutuhan masyarakat yang bingung mencari tempat untuk divaksin dan tentunya untuk menjaring masyarakat tervaksin lebih banyak lagi karena Stadion PCB merupakan tempat umum yang berada di pusat kota dimana aksesnya mudah dan terbuka lebar.&nbsp;</p>\r\n\r\n<p>&quot;Kami buka Sentra Vaksinasi biar warga itu tidak bingung cari-cari tempat vaksin, makanya kami buka di tempat umum pusat kota, areanya luas, dan aksesnya mudah, ditambah juga kami sebar di titik-titik lokasi yang berbeda di setiap Kelurahan Kota Bekasi. Harapannya, akan semakin banyak warga tervaksin demi tercapainya herd immunity.&quot; Ungkapnya. (PUT)</p>\r\n', 'images/4494ee5b16002b8ee95504f5e93b3fb9.jpeg', '2021-09-17 08:31:00', 3325, 0, 1, 'kota bekasi, dosis, kota', 'published', 'index', NULL, NULL, '2021-09-17 08:31:00', '2021-09-17 08:31:00', NULL),
('32ff0897-0a3b-4803-b253-80fbe766df58', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', ' penebangan di perum Puri gading RT.05/RW.08 jati melati,kec.pondok melati ', 'penebangan-di-perum-puri-gading-rt.05/rw.08-jati-melati,kec.pondok-melati', 'penebangan di perum Puri gading RT.05/RW.08 jati melati,kec.pondok melati', '', 'images/e7e18d77a9791aa7e2ceb98191b9df06.jpeg', '2021-09-23 08:23:00', 2098, 0, 1, 'pondok melati, melati, penebangan', 'published', 'index', NULL, NULL, '2021-09-23 08:23:00', '2021-09-23 08:23:00', NULL),
('34690621-d01e-42c8-a191-d6513d752138', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Konsultasi Publik AMDAL Rencana Pembangunan Fly Over Bulak Kapal Bekasi Timur', 'konsultasi-publik-amdal-rencana-pembangunan-fly-over-bulak-kapal-bekasi-timur', 'Bidang Perencanaan dan Jasa Konstruksi pada Dinas Bina Marga dan Sumber Daya Air Kota Bekasi melaksanakan kegiatan konsultasi publik dalam rangka penyusunan dokumen AMDAL...', '<p>Bidang Perencanaan dan Jasa Konstruksi pada Dinas Bina Marga dan Sumber Daya Air Kota Bekasi melaksanakan kegiatan konsultasi publik dalam rangka penyusunan dokumen AMDAL rencana pembangunan Fly Over Bulak Kapal yang berlokasi di Kecamatan Bekasi Timur.<br />\r\n<br />\r\nKegiatan ini merupakan bagian dari tahapan penting dalam proses perencanaan pembangunan guna memastikan keterbukaan informasi serta partisipasi aktif masyarakat terhadap rencana kegiatan yang akan dilaksanakan.<br />\r\n<br />\r\nKonsultasi publik ini dihadiri oleh unsur perangkat daerah terkait, perwakilan masyarakat terdampak, tokoh masyarakat, TNI dan Polri serta tim penyusun dokumen AMDAL.</p>\r\n', 'images/3e353c2109196f2ffdd9d4ca1fa1e07f.jpeg', '2026-04-15 09:35:00', 1780, 0, 0, 'bekasi timur, kota bekasi, kegiatan', 'published', 'index', NULL, NULL, '2026-04-15 09:35:00', '2026-04-15 09:35:00', NULL),
('38c66baa-7a16-40fe-a979-87d89b88f356', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Tim URC Bidang Bina Marga giat pengaspalan Jalan Pangkalan V Kelurahan Ciketing Kecamatan Bantargeba', 'tim-urc-bidang-bina-marga-giat-pengaspalan-jalan-pangkalan-v-kelurahan-ciketing-kecamatan-bantargebang', 'Tim URC Bidang Bina Marga giat pengaspalan Jalan Pangkalan V Kelurahan Ciketing Kecamatan Bantargeba', '', 'images/9cfe44345a09169c692a7f2a5a47de4d.jpeg', '2024-05-07 01:49:00', 3877, 0, 0, 'pengaspalan, bantargeba, kecamatan', 'published', 'index', NULL, NULL, '2024-05-07 01:49:00', '2024-05-07 01:49:00', NULL),
('3a32a3f1-5bc0-4da1-afaf-6f34f671921d', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Monitoring dan Evaluasi Pekerjaan Pembangunan tanggul dinding penahan tanah (DPT)', 'monitoring-dan-evaluasi-pekerjaan-pembangunan-tanggul-dinding-penahan-tanah-(dpt)', 'Wakil Walikota Bekasi Dr.Tri Adhianto bersama Dirjen SDA Kementrian PUPR Ir. Djarot Widyoko serta Kepala BWSCC Ir. R.R. Bambang Heri Mulyono, M. Si melakukan Monitoring dan...', '<p>Wakil Walikota Bekasi Dr.Tri Adhianto bersama Dirjen SDA Kementrian PUPR Ir. Djarot Widyoko serta Kepala BWSCC Ir. R.R. Bambang Heri Mulyono, M. Si melakukan Monitoring dan Evaluasi Pekerjaan Pembangunan tanggul dinding penahan tanah (DPT) yang berlokasi di perumahan kemang pratama kecamatan rawalumbu Kota Bekasi.</p>\r\n\r\n<p>Dalam kunjungan ini, hal &ndash; hal yang disampaikan oleh Dirjen SDA Kementrian PUPR Ir. Djarot Widyoko mengatakan Lahan mohon di konsepkan penanangannanya dan berkooordinasi dengan pemerintah kota bekasi agar pembangunan lebih cepat,&nbsp;Dikaji drainase yang masuk ke dalam kali bekasi serta selama proses pekerjaan berlangsung tenaga kerja dilapangan agar tetap melaksanakan protokol kesehatan penanganan Covid -19 seperti memakai masker, tetap menjaga jarak kerja dan mencuci tangan.</p>\r\n', 'images/2ee2c10e3109bc7034c5408c1cb646e5.jpeg', '2021-09-16 07:02:00', 1840, 0, 0, 'kota bekasi, rawalumbu, walikota bekasi', 'published', 'index', NULL, NULL, '2021-09-16 07:02:00', '2021-09-16 07:02:00', NULL),
('3cb51b74-5939-439b-8e82-03406a03c63f', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Tim Pematusan pemeliharaan saluran Skunder Kali Siluman Rw.23 Kelurahan Mustikajaya Kecamatan M', 'giat-tim-pematusan-pemeliharaan-saluran-skunder-kali-siluman-rw.23-kelurahan-mustikajaya-kecamatan-mustikajaya.', 'Giat Tim Pematusan pemeliharaan saluran Skunder Kali Siluman Rw.23 Kelurahan Mustikajaya Kecamatan M', '', 'images/42ead96a7351d0a1babe6d5c09c5cbd6.jpeg', '2022-08-04 08:26:00', 2211, 1, 0, 'pemeliharaan, mustikajaya, kecamatan', 'published', 'index', NULL, NULL, '2022-08-04 08:26:00', '2022-08-04 08:26:00', NULL),
('3d36fdef-f752-4684-b31d-2ebc26c98844', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemeliharaan Jalan', 'pemeliharaan-jalan', 'Tim URC Bidang Bina Marga melaksanakan giat Pemeliharaan jalan Lapangan Bekasi Tengah Kelurahan Margahayu Kecamatan Bekasi Timur.', '<p>Tim URC Bidang Bina Marga melaksanakan giat Pemeliharaan jalan Lapangan Bekasi Tengah Kelurahan Margahayu Kecamatan Bekasi Timur.</p>\r\n', 'images/40d94c70020a716aa62b6c0198e1ad5e.png', '2023-07-28 10:11:00', 2227, 1, 1, 'bekasi timur, pemeliharaan, bekasi', 'published', 'index', NULL, NULL, '2023-07-28 10:11:00', '2023-07-28 10:11:00', NULL),
('412da29a-1b9a-436e-9487-641026f4f740', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'rapat koordinasi evaluasi progres kegiatan', 'rapat-koordinasi-evaluasi-progres-kegiatan', 'rapat koordinasi evaluasi progres kegiatan', '', 'images/58ef68adcf54a3576f54357403d77f17.jpg', '2023-12-04 03:53:00', 2278, 0, 1, 'kegiatan, evaluasi, koordinasi', 'published', 'index', NULL, NULL, '2023-12-04 03:53:00', '2023-12-04 03:53:00', NULL),
('432e9d33-f1e8-4d0f-a9f8-4e00509a2db2', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat tim pematusan Normalisasi Saluran jalan pangkalan 1 Kecamatan Bantar Gebang', 'giat-tim-pematusan-normalisasi-saluran-jalan-pangkalan-1-kecamatan-bantar-gebang', 'Giat tim pematusan Normalisasi Saluran jalan pangkalan 1 Kecamatan Bantar Gebang', '', 'images/11150acc2c35373b5c6ff09e1fa98f9e.jpg', '2022-07-19 03:55:00', 3030, 0, 0, 'bantar gebang, normalisasi, kecamatan', 'published', 'index', NULL, NULL, '2022-07-19 03:55:00', '2022-07-19 03:55:00', NULL),
('445c7e7c-358e-4866-b00a-8e3475717f2b', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Perbaiakan lampu PJU Jl.Tomat Kel.Harapan Jaya Kec.bekasi Utara', 'perbaiakan-lampu-pju-jl.tomat-kel.harapan-jaya-kec.bekasi-utara', 'Perbaiakan lampu PJU Jl.Tomat Kel.Harapan Jaya Kec.bekasi Utara', '', 'images/c8eec8e68267c1014e9ea3c8f8bce7b7.jpeg', '2021-09-20 10:02:00', 96, 0, 0, 'bekasi utara, lampu, perbaiakan', 'published', 'index', NULL, NULL, '2021-09-20 10:02:00', '2021-09-20 10:02:00', NULL),
('460ec8ae-70a5-4a34-9cae-2524976df0ff', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Normalisasi DAS Rawalumbu kali unisma Bekasi timur', 'normalisasi-das-rawalumbu-kali-unisma-bekasi-timur', 'Normalisasi DAS Rawalumbu kali unisma Bekasi timur', '', 'images/50b584d35f6addca74b236e0ac91438d.jpeg', '2023-12-01 09:19:00', 3763, 0, 0, 'bekasi timur, rawalumbu, normalisasi', 'published', 'index', NULL, NULL, '2023-12-01 09:19:00', '2023-12-01 09:19:00', NULL),
('463d0483-b64e-480e-aea7-042a6e9b1f73', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'PERBAIKAN LAMPU PJU JALAN PANGKALAN 2 KEL.CIKIWUL', 'perbaikan-lampu-pju-jalan-pangkalan-2-kel.cikiwul', 'PERBAIKAN LAMPU PJU JALAN PANGKALAN 2 KEL.CIKIWUL', '', 'images/af337760680a08aa86b7f721dab5f0ec.jpeg', '2021-10-15 09:19:00', 3073, 0, 0, 'perbaikan, lampu, pangkalan', 'published', 'index', NULL, NULL, '2021-10-15 09:19:00', '2021-10-15 09:19:00', NULL),
('469e6d26-ccc0-464d-8429-9738e914df9c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'normalisasi saluran Jalan wibawa mukti rt 03 rw 16 depan sakura regency  Kel.jatiasih Kec.jatiasih', 'normalisasi-saluran-jalan-wibawa-mukti-rt-03-rw-16-depan-sakura-regency--kel.jatiasih-kec.jatiasih', 'normalisasi saluran Jalan wibawa mukti rt 03 rw 16 depan sakura regency Kel.jatiasih Kec.jatiasih', '', 'images/ff7f9dba5a0ad224927761fe93e5875a.jpeg', '2025-06-16 09:23:00', 4313, 0, 0, 'jatiasih, normalisasi, regency', 'published', 'index', NULL, NULL, '2025-06-16 09:23:00', '2025-06-16 09:23:00', NULL),
('485c3e52-43e1-4d76-b48f-a58593693ba4', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Penyiraman taman landmark pintu toll Bekasi Barat.', 'penyiraman-taman-landmark-pintu-toll-bekasi-barat.', 'Penyiraman taman landmark pintu toll Bekasi Barat.', '', 'images/ac8f19e92773669455a821ea222f9616.jpeg', '2022-08-04 08:25:00', 3018, 0, 0, 'bekasi barat, penyiraman, taman', 'published', 'index', NULL, NULL, '2022-08-04 08:25:00', '2022-08-04 08:25:00', NULL),
('48b1e8d0-8d08-4bb1-b80f-f759980167b5', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat timpematusan saluran tersier perumahan dukuh zamrud rw.12 kelurahan cimuning kecamatan mustika ', 'giat-timpematusan-saluran-tersier-perumahan-dukuh-zamrud-rw.12-kelurahan-cimuning-kecamatan-mustika-jaya.', 'Giat timpematusan saluran tersier perumahan dukuh zamrud rw.12 kelurahan cimuning kecamatan mustika', '', 'images/182b1f3032b59ea3cf4df706cf8708ea.jpeg', '2022-08-10 10:14:00', 4126, 0, 1, 'timpematusan, kecamatan, kelurahan', 'published', 'index', NULL, NULL, '2022-08-10 10:14:00', '2022-08-10 10:14:00', NULL);
INSERT INTO `articles` (`uuid`, `user_uuid`, `category_uuid`, `title`, `slug`, `excerpt`, `content`, `featured_image`, `scheduled_at`, `views`, `is_featured`, `is_popular`, `tagging`, `status`, `search_engine`, `link`, `video`, `created_at`, `updated_at`, `deleted_at`) VALUES
('48ef4ff9-7b65-4cc4-8bdb-ee6f4138285c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan Pohon di jln Raya H.Jole Kel.Bantar Gebang Kec.Bantargebang', 'pemangkasan-pohon-di-jln-raya-h.jole-kel.bantar-gebang-kec.bantargebang', 'Pemangkasan Pohon di jln Raya H.Jole Kel.Bantar Gebang Kec.Bantargebang', '', 'images/26208d9c2e5e3bd5c238348a4b6fac3b.jpeg', '2022-09-05 09:15:00', 2403, 0, 1, 'bantar gebang, bantargebang, pemangkasan', 'published', 'index', NULL, NULL, '2022-09-05 09:15:00', '2022-09-05 09:15:00', NULL),
('492ae670-b1e6-44eb-8f4f-7b1cbc26afe5', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Tim URC Taman Pemangkasan Pohon Jalan Baru Underpass', 'giat-tim-urc-taman-pemangkasan-pohon-jalan-baru-underpass', 'Giat Tim URC Taman Pemangkasan Pohon Jalan Baru Underpass', '', 'images/8fe89653b872363acac5ecdc7341743e.jpeg', '2022-04-21 06:27:00', 1097, 0, 1, 'taman, pemangkasan, underpass', 'published', 'index', NULL, NULL, '2022-04-21 06:27:00', '2022-04-21 06:27:00', NULL),
('49f2464c-9231-4f57-805c-3ef1fd96f6eb', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Tentang Pelaksanaan Program Vaksinasi COVID-19 Pada Gerai Vaksinasi di Pusat Perbelanjaan/Mall di Ko', 'tentang-pelaksanaan-program-vaksinasi-covid-19-pada-gerai-vaksinasi-di-pusat-perbelanjaan/mall-di-kota-bekasi', 'Pemerintah Kota Bekasi menerbitkan Surat Edaran Nomor : 443.1/1553/SET.COVID19 Tentang Pelaksanaan Program Vaksinasi COVID-19 Pada Gerai Vaksinasi di Pusat Perbelanjaan/Mall di...', '<p>&nbsp;</p>\r\n\r\n<p>Pemerintah Kota Bekasi menerbitkan Surat Edaran<br />\r\nNomor : 443.1/1553/SET.COVID19<br />\r\nTentang Pelaksanaan Program Vaksinasi COVID-19 Pada Gerai Vaksinasi di Pusat Perbelanjaan/Mall di Kota Bekasi.<br />\r\n<br />\r\nSurat Edaran tersebut berkenaan dengan pelaksanaan Program Vaksinasi Covid-19 di Kota Bekasi sebagai upaya untuk mencapai kekebalan kelompok di masyarakat (herd immunity) dalam rangka mengurangi transmisi/penularan Virus Covid-19 dan untuk menurunkan angka kesakitan serta kematian akibat Virus Covid-19, dengan ini agar memperhatikan hal-hal sebagai berikut:<br />\r\n<br />\r\n1. Pelaksanaan Program Vaksinasi Covid-19 dimaksud akan dilaksanakan pada tanggal 01 s.d. 31 Oktober 2021, yang bertempat di 17 titik lokasi di Kota Bekasi;<br />\r\n<br />\r\n2.Program Vaksinasi Covid-19 sebagaimana dimaksud pada point 1, akan dilaksanakan secara komprehensif kepada masyarakat umum di Kota Bekasi dengan menggunakan Vaksin Covid-19 yang tersedia sebanyak 100 (seratus) dosis per hari per titik lokasi.<br />\r\n<br />\r\nPemerintah Kota Bekasi secara gencar terus melakukan vaksinasi bagi warganya guna mencapai target herd imunnity.<br />\r\n<br />\r\n<a href=\"https://www.instagram.com/explore/tags/salampatriot/\">#salampatriot</a><br />\r\n<a href=\"https://www.instagram.com/explore/tags/humaskotabekasi/\">#humaskotabekasi</a></p>\r\n', 'images/37ccd46071aaafc2da671bd1c209d839.jpeg', '2021-10-04 09:53:00', 745, 0, 0, 'kota bekasi, covid, vaksinasi', 'published', 'index', NULL, NULL, '2021-10-04 09:53:00', '2021-10-04 09:53:00', NULL),
('4a5a880d-1124-49e6-a3f2-859c06cb69e8', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat TIM URC BINA MARGA Pengaspalan Jl. Telaga Mas RW.16 Perum Duta Harapan Kec. Bekasi Utara . ', 'giat-tim-urc-bina-marga-pengaspalan-jl.-telaga-mas-rw.16-perum-duta-harapan-kec.-bekasi-utara-.', 'Giat TIM URC BINA MARGA Pengaspalan Jl. Telaga Mas RW.16 Perum Duta Harapan Kec. Bekasi Utara .', '', 'images/bfbf9fc218132c982865b80bc8b229ea.jpg', '2021-10-29 14:34:00', 1504, 1, 0, 'bekasi utara, pengaspalan, harapan', 'published', 'index', NULL, NULL, '2021-10-29 14:34:00', '2021-10-29 14:34:00', NULL),
('4aa470ee-3aa2-4aea-b803-2867b54fc96e', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'PENYERAHAN BIBIT DAN PENANAMAN POHON', 'penyerahan-bibit-dan-penanaman-pohon', 'PT. PLN UP3 Bekasi bersama Dinas Bina Marga dan Sumber Daya Air Kota Bekasi menanam pohon bersama untuk menghijaukan dan meningkatkan kualitas udara di kota Bekasi.', '<p>PT. PLN UP3 Bekasi bersama Dinas Bina Marga dan Sumber Daya Air Kota Bekasi menanam pohon bersama untuk menghijaukan dan meningkatkan kualitas udara di kota Bekasi.</p>\r\n', 'images/e326bf80144845442a218591ee1f911f.jpeg', '2023-11-30 09:51:00', 1125, 0, 1, 'kota bekasi, bekasi, bersama', 'published', 'index', NULL, NULL, '2023-11-30 09:51:00', '2023-11-30 09:51:00', NULL),
('4b2b22d5-13a1-49ae-aaf0-9dea16543476', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pematusan saluran sekunder kali wisma jaya RW 017 Kel.duren jaya Kec.bekasi timur', 'pematusan-saluran-sekunder-kali-wisma-jaya-rw-017-kel.duren-jaya-kec.bekasi-timur', 'pematusan saluran sekunder kali wisma jaya RW 017 Kel.duren jaya Kec.bekasi timur', '', 'images/34bcd6246573504b9cc17b288894c62c.jpeg', '2024-01-16 11:31:00', 2978, 0, 0, 'bekasi timur, jaya, pematusan', 'published', 'index', NULL, NULL, '2024-01-16 11:31:00', '2024-01-16 11:31:00', NULL),
('4cdde6d0-0e81-4a0c-9c96-3c32de1a2963', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Menindak lanjuti laporan hari ini tim URC Bidang Bina Marga melaksanakan giat Penanganan Gapura Beka', 'menindak-lanjuti-laporan-hari-ini-tim-urc-bidang-bina-marga-melaksanakan-giat-penanganan-gapura-bekasi-timur', 'Menindak lanjuti laporan hari ini tim URC Bidang Bina Marga melaksanakan giat Penanganan Gapura Beka', '', 'images/5af813f5183c504d4da2b20eebc1adf9.png', '2023-07-12 09:35:00', 2347, 0, 1, 'melaksanakan, penanganan, menindak', 'published', 'index', NULL, NULL, '2023-07-12 09:35:00', '2023-07-12 09:35:00', NULL),
('4fb3cb8b-dc77-4b12-b8f1-b5c18846a3b7', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat lanjutan tim pematusan penanganan sampah di kali bong bekasi barat arah BKT Jakarta timur', 'giat-lanjutan-tim-pematusan-penanganan-sampah-di-kali-bong-bekasi-barat-arah-bkt-jakarta-timur', 'Giat lanjutan tim pematusan penanganan sampah di kali bong bekasi barat arah BKT Jakarta timur', '', 'images/49a8cb6fa1456645f4af2b94586b8353.jpeg', '2021-10-27 09:29:00', 2068, 0, 0, 'bekasi barat, penanganan, pematusan', 'published', 'index', NULL, NULL, '2021-10-27 09:29:00', '2021-10-27 09:29:00', NULL),
('4fe431d0-3b73-42d4-9ad3-c53b0d62daad', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'DBMSDA Kota Bekasi tutup Jalan Pekayon selama 2 Minggu', 'dbmsda-kota-bekasi-tutup-jalan-pekayon-selama-2-minggu', 'Pemerintah Kota Bekasi akan melakukan Penutupan jalan selama 2 minggu sehubungan dengan adanya pekerjaan rehabilitasi Saluran Drainase Perkotaan (Normalisasi Saluran Air...', '<p>Pemerintah Kota Bekasi akan melakukan Penutupan jalan selama 2 minggu sehubungan dengan adanya pekerjaan rehabilitasi Saluran Drainase Perkotaan (Normalisasi Saluran Air Perumahan Permata Pekayon) Oleh CV. Charles Marpa selaku pelaksana yang ditunjuk oleh Dinas Bina Marga &amp; Sumber Daya Air (DBMSDA) Kota Bekasi.&nbsp;</p>\r\n\r\n<p><br />\r\nPelaksanaan pekerjaan akan menyebabkan pembongkaran jalan existing dan penutupan jalan sementara pada ruas jl. Pekayon (perempatan permata Pekayon depan Gapura Perumahan Permata Pekayon).&nbsp;</p>\r\n\r\n<p><br />\r\nDinas Perhubungan dan Satlantas Polres Metro Bekasi Kota akan ditempatkan petugas pengatur lalu lintas selama 7 Hari x 24 Jam untuk membantu kelancaran dan ketertiban lalu Lintas pekerjaan tersebut.&nbsp;</p>\r\n\r\n<p><br />\r\nBerikut dibawah ini panduan bagi para pengendara maupun pelaku usaha yang akan melewati jl. Pekayon ;</p>\r\n\r\n<p>1. Arus Kendaraan dari arah toll barat menuju jati asih dialihkan sementara ke jalan Ki Ijo Bin Beih kemudian belok ke Jalan Ketapang.&nbsp;</p>\r\n\r\n<p>2. Arus Kendaraan dari Arah Jati Asih menuju ke Toll Barat dialihkan ke Jalan Ketapang kemudian belok ke Jalan Ki Ijo Bingung Beih.&nbsp;</p>\r\n\r\n<p><br />\r\nDiharapkan kerja sama dari masyarakat agar mematuhi prosedur yg berlaku dan menjaga ketertiban berlalu lintas. (Dro)</p>\r\n', 'images/50c157015840e3fb6ab6c7d9762a2221.jpg', '2021-09-24 09:31:00', 343, 0, 1, 'kota bekasi, jati asih, pekerjaan', 'published', 'index', NULL, NULL, '2021-09-24 09:31:00', '2021-09-24 09:31:00', NULL),
('54551100-832c-41f8-9d35-cb7c1af69051', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'indek kepuasan masyarakat triwuln ke II Tahun 2026', 'indek-kepuasan-masyarakat-triwuln-ke-ii-tahun-2026', 'Indeks Kepuasan Masyarakat Triwulan II 2026 Score 88.39 Kategori mutu pelayanan A (sangat baik) Jumlah responden 39 dengan rincian : 32 responden untuk Pelayanan Rekomendasi...', '<p>Indeks Kepuasan Masyarakat Triwulan II 2026<br />\r\nScore 88.39<br />\r\n<br />\r\nKategori mutu pelayanan A (sangat baik)<br />\r\nJumlah responden 39<br />\r\ndengan rincian :<br />\r\n32 responden untuk Pelayanan Rekomendasi Teknis Peil Banjir<br />\r\n7 responden untuk Pelayanan Rekomendasi Teknis Pemanfaatan Ruang Jalan</p>\r\n', 'images/c04691a8120d242d281e0b5c8ecb4ce8.jpeg', '2026-08-13 07:52:00', 1623, 0, 1, 'pelayanan, responden, rekomendasi', 'published', 'index', NULL, NULL, '2026-08-13 07:52:00', '2026-08-13 07:52:00', NULL),
('545c7b9f-95b3-4c27-b5bb-fa3d1a8a66e2', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pemeliharaan Taman Median Jalan Baru Cipendawa Kecamatan Rawalumbu', 'pemeliharaan-taman-median-jalan-baru-cipendawa-kecamatan-rawalumbu', 'pemeliharaan Taman Median Jalan Baru Cipendawa Kecamatan Rawalumbu', '', 'images/66db560efabc8cf49564bd59deca91d1.jpg', '2023-12-19 10:21:00', 1773, 1, 0, 'rawalumbu, pemeliharaan, taman', 'published', 'index', NULL, NULL, '2023-12-19 10:21:00', '2023-12-19 10:21:00', NULL),
('54675f03-d5d8-4b24-951a-9d6ffc6caa16', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'penyiraman Taman Median Jalan M.Hasibuan Bekasi Timur', 'penyiraman-taman-median-jalan-m.hasibuan-bekasi-timur', 'penyiraman Taman Median Jalan M.Hasibuan Bekasi Timur', '', 'images/76dfbcb11955b7f7e2cfc3a86c3b287e.jpeg', '2023-12-11 03:52:00', 4760, 0, 0, 'bekasi timur, penyiraman, taman', 'published', 'index', NULL, NULL, '2023-12-11 03:52:00', '2023-12-11 03:52:00', NULL),
('559fd71c-451b-47c9-bccf-72bdd96b21f7', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Kunjungan Pansus DPRD Kabupaten karawang terkait penyelenggaraan sistem drainase DPRD Kabupaten Kara', 'kunjungan-pansus-dprd-kabupaten-karawang-terkait-penyelenggaraan-sistem-drainase-dprd-kabupaten-karawang-provinsi-jawa-barat', 'Kunjungan Pansus DPRD Kabupaten karawang terkait penyelenggaraan sistem drainase DPRD Kabupaten Kara', '', 'images/c1c801f39717ebbf0c2c7f03cd290885.jpg', '2021-09-27 12:37:00', 4788, 0, 0, 'kabupaten, dprd, penyelenggaraan', 'published', 'index', NULL, NULL, '2021-09-27 12:37:00', '2021-09-27 12:37:00', NULL),
('5849920d-1c6d-4b9f-8c6d-093ce465dde7', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Kunjungan kerja pemerintah kota depok perihal pelaksanaan relokasi kabel udara di kota bekasi', 'kunjungan-kerja-pemerintah-kota-depok-perihal-pelaksanaan-relokasi-kabel-udara-di-kota-bekasi', 'Kunjungan kerja pemerintah kota depok perihal pelaksanaan relokasi kabel udara di kota bekasi', '', 'images/e47d7c612e7a43a57339986624e4b846.jpeg', '2022-01-12 05:14:00', 3857, 0, 0, 'kota bekasi, kota, pelaksanaan', 'published', 'index', NULL, NULL, '2022-01-12 05:14:00', '2022-01-12 05:14:00', NULL),
('585c36ff-5ba7-4f5d-a843-3dac812b78db', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangaksan pohon tumbang Jl.Kemandoran Kelurahan Pekayon Kecamatan Bekasi Selatan', 'pemangaksan-pohon-tumbang-jl.kemandoran-kelurahan-pekayon-kecamatan-bekasi-selatan', 'Pemangaksan pohon tumbang Jl.Kemandoran Kelurahan Pekayon Kecamatan Bekasi Selatan', '', 'images/2150cdcbe1904fd0a115125e14835ae4.jpeg', '2022-01-13 07:53:00', 3851, 0, 0, 'bekasi selatan, pemangaksan, kemandoran', 'published', 'index', NULL, NULL, '2022-01-13 07:53:00', '2022-01-13 07:53:00', NULL),
('5a50fd3a-559b-45d8-9055-aed0e7672a1a', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Survey lokasi kali rawatembaga', 'survey-lokasi-kali-rawatembaga', 'Kepala dinas bmsdakotabekasi Muhàmmad Solikhin bersama Komandan Kodim 0507 Bekasi Kolonel Arm Rico Ricardo Sirait Melaksanakan Giat Survey lokasi kali rawatembaga selasa 5...', '<p>Kepala dinas&nbsp;<a href=\"https://www.instagram.com/bmsdakotabekasi/\">bmsdakotabekasi</a>&nbsp;Muh&agrave;mmad Solikhin bersama Komandan Kodim 0507 Bekasi Kolonel Arm Rico Ricardo Sirait Melaksanakan Giat Survey lokasi kali rawatembaga selasa 5 desember 2023.<br />\r\n<br />\r\nDalam pelaksanaan survey ini Kodim 0507 Bekasi mewakili Angkatan Darat bersama pemerintah kota bekasi akan melaksanakan kegiatan pembersihan kali rawatembaga.</p>\r\n', 'images/214918a6baf4a51495d934a8946ab2e1.jpg', '2023-12-08 09:19:00', 2842, 0, 0, 'kota bekasi, kodim, kegiatan', 'published', 'index', NULL, NULL, '2023-12-08 09:19:00', '2023-12-08 09:19:00', NULL),
('5c428b3c-33ca-43bd-89a0-0c071f3b53ff', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Monitoring Pematusan Saluran Sekunder DAS BSK Kel. Jakasampurna', 'monitoring-pematusan-saluran-sekunder-das-bsk-kel.-jakasampurna', 'Monitoring Pematusan Saluran Sekunder DAS BSK Kel. Jakasampurna', '', 'images/4f72a840ca26be564a50eed51e554bb7.jpeg', '2021-09-08 07:30:00', 2143, 0, 0, 'jakasampurna, monitoring, pematusan', 'published', 'index', NULL, NULL, '2021-09-08 07:30:00', '2021-09-08 07:30:00', NULL),
('5cb969c6-9824-461d-a377-dc0d9c8c6d4c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemerintah Kota Bekasi meraih penghargaan Badan Publik Informatif Kategori Pemerintah Kota/Kabupaten', 'pemerintah-kota-bekasi-meraih-penghargaan-badan-publik-informatif-kategori-pemerintah-kota/kabupaten-se--jawa-barat-tahun-2021', 'Pemerintah Kota Bekasi meraih penghargaan Badan Publik Informatif Kategori Pemerintah Kota/Kabupaten Se- Jawa Barat Tahun 2021 pada Anugerah Keterbukaan Informasi Publik yang...', '<p>Pemerintah Kota Bekasi meraih penghargaan Badan Publik Informatif Kategori Pemerintah Kota/Kabupaten Se- Jawa Barat Tahun 2021 pada Anugerah Keterbukaan Informasi Publik yang diselenggarakan oleh @komisiinformasijawabarat&nbsp;</p>\r\n\r\n<p>Penghargaan ini merupakan bentuk komitmen Pemerintah Kota Bekasi dalam menyajikan informasi yang terbuka bagi khalayak luas dan mudah untuk diakses.</p>\r\n\r\n<p>Ke depannya penghargaan ini akan terus dipertahankan bahkan dikembangkan lebih baik.</p>\r\n\r\n<p>#salampatriot&nbsp;<br />\r\n#humaskotabekasi</p>\r\n', 'images/d6c4a53070e805a534c8800d39bea746.jpg', '2021-12-06 15:30:00', 863, 0, 0, 'kota bekasi, penghargaan, pemerintah', 'published', 'index', NULL, NULL, '2021-12-06 15:30:00', '2021-12-06 15:30:00', NULL),
('5dda64c5-a393-4a13-a289-70e5329bd2ca', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pendampingan Vaksinasi COVID 19', 'pendampingan-vaksinasi-covid-19', 'Kepala Dinas Bina Marga dan Sumber Daya Air hari ini mengunstruksikan seluruh aparaturnya melaksanakan giat pendampingan pelaksanaan vaksinsi covid-19 di 3 wilayah bekasi timur...', '<p>Kepala Dinas Bina Marga dan Sumber Daya Air hari ini mengunstruksikan seluruh aparaturnya melaksanakan giat pendampingan pelaksanaan vaksinsi covid-19 di 3 wilayah bekasi timur yaitu kelurahan&nbsp; margahayu, kelurahan duren jaya dan kelurahan aren jaya.</p>\r\n\r\n<p>Pelaksanaan vaksinasi hari ini menggunkan jenis vaksin Pfizer dosis ke 1 dan selaku petugas yang mendampingi para nakes bertugas sebagai penginput data P-Care, petugas pelayanan dan mobilisasi vaksin. Pelaksanaan vaksinasi akan di jadwalkan dua hari sabtu dan minggu.</p>\r\n\r\n<p>Ayoooo bagi warga kota bekasi yang belum vaksin jangan takut vaksin karna aman dan halal.</p>\r\n', 'images/21336dcb37512b77add44e30afa5cf90.jpg', '2021-09-05 09:15:00', 3417, 0, 1, 'bekasi timur, kota bekasi, vaksin', 'published', 'index', NULL, NULL, '2021-09-05 09:15:00', '2021-09-05 09:15:00', NULL),
('5ddbd47c-747f-41e6-84e1-ccc0a27866a4', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Tim taman melaksanakan giat penyiraman Taman Rawapanjang Kecamatan Rawalumbu', 'tim-taman-melaksanakan-giat-penyiraman-taman-rawapanjang-kecamatan-rawalumbu', 'Tim taman melaksanakan giat penyiraman Taman Rawapanjang Kecamatan Rawalumbu', '', 'images/3f9ba923685ddb7a25cff5784bd27595.jpg', '2024-01-24 12:46:00', 1923, 0, 1, 'rawalumbu, penyiraman, taman', 'published', 'index', NULL, NULL, '2024-01-24 12:46:00', '2024-01-24 12:46:00', NULL),
('5fcf2cd4-465c-49d6-9648-219e63d26b21', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat pematusan pasca banjir pembersihan lumpur di gang mawar RT:08/03 Kel. Margahayu Kec. Bekasi timur', 'giat-pematusan-pasca-banjir-pembersihan-lumpur-di-gang-mawar-rt:08/03-kel.-margahayu-kec.-bekasi-timur', 'Giat pematusan pasca banjir pembersihan lumpur di gang mawar RT:08/03 Kel. Margahayu Kec. Bekasi timur', '', 'images/4c9a0f63212778341043c7a9b48f5570.jpeg', '2025-07-09 09:47:00', 914, 0, 0, 'bekasi timur, pembersihan, margahayu', 'published', 'index', NULL, NULL, '2025-07-09 09:47:00', '2025-07-09 09:47:00', NULL),
('60ef61c9-7a59-403a-948e-f1a728f23454', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'INDEKS KEPUASAN MASYARAKAT (IKM)', 'indeks-kepuasan-masyarakat-(ikm)', 'Haiiiii sobat #bmsda selamat siang Berikut adalah hasil Survey Kepuasan Masyarakat Dinas Bina Marga dan Sumber Daya Air Kota Bekasi Semester I Tahun 2022. Dengan nilai...', '<p>Haiiiii sobat #bmsda selamat siang</p>\r\n\r\n<p>Berikut adalah hasil Survey Kepuasan Masyarakat Dinas Bina Marga dan Sumber Daya Air Kota Bekasi Semester I Tahun 2022. Dengan nilai rata-rata 82,19% (Kategori Baik).</p>\r\n\r\n<p>Terimakasih sobat sekalian dalam memberi penilaian terhadap kami.</p>\r\n\r\n<p>#pemkotbekasi<br />\r\n#kotabekasi<br />\r\n#cerdaskreatifmajusejahteraihsankotaku</p>\r\n', 'images/c28ded121337ff7a201151ea73fb4d81.jpg', '2022-09-02 07:47:00', 1006, 0, 0, 'kota bekasi, sobat, rata', 'published', 'index', NULL, NULL, '2022-09-02 07:47:00', '2022-09-02 07:47:00', NULL),
('622418e4-4f7d-48f5-aaee-ce99a7883d77', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'kunjungan kerja Komisi C DPRD Kota Depok', 'kunjungan-kerja-komisi-c-dprd-kota-depok', 'Sekretaris dinas Bina Marga dan Sumber Daya Air Kota Bekasi Idi Santoso menerima kunjungan kerja Komisi C DPRD Kota Depok di ruang rapat audio visual. Didampingi Kepala Bidang...', '<p>Sekretaris dinas Bina Marga dan Sumber Daya Air Kota Bekasi&nbsp;Idi Santoso menerima kunjungan kerja Komisi C DPRD Kota Depok di ruang rapat audio visual.<br />\r\n<br />\r\nDidampingi Kepala Bidang Bina Marga Subrin Sutoro memaparkan terkait data dan informasi penataan serta pembangunan reklame di kawasan Kota.<br />\r\n&nbsp;</p>\r\n', 'images/153df394c17c038015af7eeff691d0f3.JPG', '2023-09-13 08:37:00', 1853, 0, 1, 'kota bekasi, kota, marga', 'published', 'index', NULL, NULL, '2023-09-13 08:37:00', '2023-09-13 08:37:00', NULL),
('6330b32d-3cc9-4157-8c0e-6874fee833bf', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat URC Bina Marga pengecoran menhole jalan raya narogong', 'giat-urc-bina-marga-pengecoran-menhole-jalan-raya-narogong', 'Giat URC Bina Marga pengecoran menhole jalan raya narogong', '', 'images/3e917c713401ae609ed81b373b128a09.jpg', '2021-11-02 15:28:00', 3241, 0, 1, 'pengecoran, narogong, menhole', 'published', 'index', NULL, NULL, '2021-11-02 15:28:00', '2021-11-02 15:28:00', NULL),
('6343cb52-6b8d-42fb-8cf9-f695b41e34e2', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat tim pematusan pengangguran sampah di saluran kali lengkak', 'giat-tim-pematusan-pengangguran-sampah-di-saluran-kali-lengkak', 'Giat tim pematusan pengangguran sampah di saluran kali lengkak', '', 'images/83ce4360a84b3f4db8fdca7b5f4fafc2.jpg', '2021-11-03 16:10:00', 90, 0, 1, 'pengangguran, pematusan, lengkak', 'published', 'index', NULL, NULL, '2021-11-03 16:10:00', '2021-11-03 16:10:00', NULL),
('63620168-490a-469e-903a-d811dc2ca02f', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pembuatan Deker * Villa Mas Garden Perwira, Bekasi Utara', 'pembuatan-deker-*-villa-mas-garden-perwira,-bekasi-utara', 'Pembuatan Deker * Villa Mas Garden Perwira, Bekasi Utara', '', 'images/f74a02958ada8841ba6e267bd0f77b4b.jpg', '2025-06-18 01:28:00', 659, 1, 0, 'bekasi utara, pembuatan, perwira', 'published', 'index', NULL, NULL, '2025-06-18 01:28:00', '2025-06-18 01:28:00', NULL),
('636f5e1e-d655-4748-be98-2b9fe7389afc', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'SALURAN TERSIER DEPAN SD JATIWARINGIN 1 LINGKAR  APG Kelurahan Jatiwarimngin Kecamatan Pondok gede', 'saluran-tersier-depan-sd-jatiwaringin-1-lingkar--apg-kelurahan-jatiwarimngin-kecamatan-pondok-gede', 'SALURAN TERSIER DEPAN SD JATIWARINGIN 1 LINGKAR APG Kelurahan Jatiwarimngin Kecamatan Pondok gede', '', 'images/29f2855bb800ef716e6f95fa6b5d30bf.jpg', '2023-12-13 09:24:00', 4674, 0, 0, 'pondok gede, jatiwarimngin, jatiwaringin', 'published', 'index', NULL, NULL, '2023-12-13 09:24:00', '2023-12-13 09:24:00', NULL),
('640d2ac1-fb69-47c1-a3a1-8572841b4800', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat tim URC Bina Marga pemeliharaan jalan akses masuk wisata kuliner kecamatan Bekasi Selatan', 'giat-tim-urc-bina-marga-pemeliharaan-jalan-akses-masuk-wisata-kuliner-kecamatan-bekasi-selatan', 'Giat tim URC Bina Marga pemeliharaan jalan akses masuk wisata kuliner kecamatan Bekasi Selatan', '', 'images/e0199eccb4ab437a9d3e5879810fcb01.jpeg', '2022-01-25 03:49:00', 3708, 0, 0, 'bekasi selatan, pemeliharaan, kecamatan', 'published', 'index', NULL, NULL, '2022-01-25 03:49:00', '2022-01-25 03:49:00', NULL),
('66352c93-8fd3-408c-ad33-c4c370963120', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pembahasan Peninggian Jembatan Jatimulya Kabupaten Bekasi, Pelebaran Saluran Tanah Apit dan Jembatan', 'pembahasan-peninggian-jembatan-jatimulya-kabupaten-bekasi,-pelebaran-saluran-tanah-apit-dan-jembatan-mutiara-colombus', 'Kepala bidang SDA Dinas Bina Marga dan Sumber Daya Air Pemerintah Kota Bekasi memimpin Rapat koordinasi dengan Pemerintah kabupaten bekasi. Menindak lanjuti kesepakatan bersama...', '<p>Kepala bidang SDA Dinas Bina Marga dan Sumber Daya Air Pemerintah Kota Bekasi memimpin Rapat koordinasi dengan Pemerintah kabupaten bekasi. Menindak lanjuti kesepakatan bersama Pemerintah Kota Bekasi &nbsp;dengan Pemerintah Kabupaten Bekasi&nbsp; tentang kerjasama pembangunan perbatasan yaitu pengendalian Daerah Aliran Sungai (DAS) dan Penanganan banjir Kabupaten dan Kota.</p>\r\n\r\n<p>Rakor yang di hadiri oleh jajaran dari Dinas SDABMBK Kabupaten Bekasi, Camat Mustikajaya Kota Bekasi, Camat Medan Satria Kota Bekasi, Camat Tambun Selatan Kabupaten Bekasi, Camat &nbsp;Setu Kabupaten Bekasi, Camat Tarumajaya Kabupaten Bekasi dan perwakilan PT Graha Cipta Persada selaku Pengembang Mutiara Columbus serta perwakilan PT Damai Putra Group selaku Pengembang Harapan Indah.</p>\r\n\r\n<p>Dalam rakor kali ini yang beragendakan pembahasan peninggian jembatan jatimulya Kabupaten Bekasi, pelebaran saluran tanah apit dan jembatan mutiara colombus. Pemerintah kabupaten bekasi &nbsp;menganggarkan di tahun 2022 untuk peninggikan jembatan jatimulya, PT Graha Cipta Persada selaku Pengembang Mutiara Columbus akan membongkar 1 jembatan dan PT Damai Putra Group selaku Pengembang Harapan Indah akan ikut serta dalam penanganan banjir. &nbsp;</p>\r\n\r\n<p>Secara bertahap Pemerintah Kota Bekasi dan Pemerintah kabupaten bekasi akan terus intens berkoordinasi mengatasi penanganan di perbatasan wilayah kabupaten dan kota sesuai kesepakatan bersama anatar pemerintah kota Bekasi dgn kabupaten tentang kerjasama pembangunan wilayah perbatasan no 1255 thn 2018 dan no 134.4/KB.84/AKS/XII/2018.</p>\r\n', 'images/a45446d701445efdd0b85615d03dae81.jpeg', '2021-09-27 11:27:00', 3728, 0, 0, 'kota bekasi, kabupaten bekasi, medan satria', 'published', 'index', NULL, NULL, '2021-09-27 11:27:00', '2021-09-27 11:27:00', NULL),
('664454c1-b98f-4227-a6e5-2e44b8547ea9', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Tim URC Bina Marga Grebek K3 di Jalan Chairil Anwar Kecamatan Bekasi Timur ', 'giat-tim-urc-bina-marga-grebek-k3-di-jalan-chairil-anwar-kecamatan-bekasi-timur', 'Giat Tim URC Bina Marga Grebek K3 di Jalan Chairil Anwar Kecamatan Bekasi Timur', '', 'images/8d61aa09c766237ed0f8ff0ba5d5446b.jpeg', '2022-01-28 08:07:00', 1498, 0, 0, 'bekasi timur, kecamatan, chairil', 'published', 'index', NULL, NULL, '2022-01-28 08:07:00', '2022-01-28 08:07:00', NULL),
('66b5f7cc-195a-4de9-9d7b-c3fba33d8122', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat pematusan saluran sekunder kali bong RW 014  Kel.kota baru Kec.bekasi barat', 'giat-pematusan-saluran-sekunder-kali-bong-rw-014--kel.kota-baru-kec.bekasi-barat', 'Giat pematusan saluran sekunder kali bong RW 014 Kel.kota baru Kec.bekasi barat', '', 'images/98dcff37186f555d925f4ae61a104686.jpeg', '2023-11-17 07:08:00', 4173, 0, 0, 'bekasi barat, pematusan, sekunder', 'published', 'index', NULL, NULL, '2023-11-17 07:08:00', '2023-11-17 07:08:00', NULL),
('689a4348-70ca-4950-922c-f8508cd736a6', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Pemangkasan pohon di lingkungan kantor kecamatan jatiasih', 'giat-pemangkasan-pohon-di-lingkungan-kantor-kecamatan-jatiasih', 'Giat Pemangkasan pohon di lingkungan kantor kecamatan jatiasih', '', 'images/0b13a2ab444bf65e100bdd74de8229f6.jpeg', '2022-07-19 05:13:00', 3637, 1, 0, 'pemangkasan, kecamatan, jatiasih', 'published', 'index', NULL, NULL, '2022-07-19 05:13:00', '2022-07-19 05:13:00', NULL),
('695f1037-db92-40ab-9567-fd17d7a81975', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'PEMANGKASAN POHON JL.RAYA KALI BARU RW 10 KEL.KOTA BARU KEC.BEKASI BARAT', 'pemangkasan-pohon-jl.raya-kali-baru-rw-10-kel.kota-baru-kec.bekasi-barat', 'PEMANGKASAN POHON JL.RAYA KALI BARU RW 10 KEL.KOTA BARU KEC.BEKASI BARAT', '', 'images/ea582a75c3eb75ae56218747a4cac6a6.jpeg', '2021-10-26 09:17:00', 1039, 0, 0, 'bekasi barat, baru, pemangkasan', 'published', 'index', NULL, NULL, '2021-10-26 09:17:00', '2021-10-26 09:17:00', NULL),
('6a82c2d3-9e04-4dda-9d0d-03eec77bd546', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Rapat Pembahasan perencanaan taman kolong tol becakayu', 'rapat-pembahasan-perencanaan-taman-kolong-tol-becakayu', 'Pagi ini Sekretaris dinas bmsda bersama kepala bidang memimpin Rapat Pembahasan perencanaan taman kolong tol becakayu, DBMSDA dengan Pihak Swasta di Kota Bekasi. Dalam program...', '<p>Pagi ini Sekretaris dinas bmsda bersama kepala bidang memimpin Rapat Pembahasan perencanaan taman kolong tol becakayu, DBMSDA dengan Pihak Swasta di Kota Bekasi.<br />\r\n<br />\r\nDalam program sinergisitas membangun kota Bekasi dengan kegiatan CSR</p>\r\n', 'images/f32ed112138d758c1c8b470f8b3d6858.jpeg', '2023-01-05 04:49:00', 2883, 1, 1, 'kota bekasi, taman, kegiatan', 'published', 'index', NULL, NULL, '2023-01-05 04:49:00', '2023-01-05 04:49:00', NULL),
('6d7887db-51fa-42c6-837d-bf7cdee061f9', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Core Values ASN BERAKHLAK di dinas Bina Marga dan Sumber Daya air Kota Bekasi', 'core-values-asn-berakhlak-di-dinas-bina-marga-dan-sumber-daya-air-kota-bekasi', 'Dinas Bina Marga dan Sumber Daya Air Kota Bekasi berkomitmen menerapkan nilai dasar ASN BERAKHLAK. Dengan berorientasi pada pelayanan, bekerja akuntabel, kompeten, harmonis,...', '<p>Dinas Bina Marga dan Sumber Daya Air Kota Bekasi berkomitmen menerapkan nilai dasar ASN BERAKHLAK. Dengan berorientasi pada pelayanan, bekerja akuntabel, kompeten, harmonis, loyal, adaptif, dan kolaboratif, kami hadir memastikan pembangunan serta pemeliharaan jalan dan sumber daya air berjalan profesional demi kenyamanan masyarakat Kota Bekasi.</p>\r\n', 'images/d225fd96537c82f7679792c133b05e53.jpeg', '2025-12-04 09:28:00', 2634, 0, 0, 'kota bekasi, pemeliharaan, bekasi', 'published', 'index', NULL, NULL, '2025-12-04 09:28:00', '2025-12-04 09:28:00', NULL),
('6d89ed6c-0fa1-4e58-a4af-93db0349047a', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Rapat pembahasan rencana pembangunan sekolah rakyat dan Polder Air Kecamatan Bantargebang Kota Bekasi', 'rapat-pembahasan-rencana-pembangunan-sekolah-rakyat-dan-polder-air-kecamatan-bantargebang-kota-bekasi', 'Rapat pembahasan rencana pembangunan sekolah rakyat dan Polder Air Kecamatan Bantargebang Kota Bekasi', '', 'images/bc491fbc7c7ed9c55110578994e193df.jpeg', '2025-06-18 03:27:00', 70, 0, 0, 'kota bekasi, bantargebang, pembangunan', 'published', 'index', NULL, NULL, '2025-06-18 03:27:00', '2025-06-18 03:27:00', NULL),
('6f72ccfe-0a7f-4a94-8d1b-9a089cf8f02d', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Normalisasi Perum Pondok Cipta RW 11 Kelurahan Bintara Kecamatan Bekasi Barat', 'normalisasi-perum-pondok-cipta-rw-11-kelurahan-bintara-kecamatan-bekasi-barat', 'Normalisasi Perum Pondok Cipta RW 11 Kelurahan Bintara Kecamatan Bekasi Barat', '', 'images/295f11e98b2ed27631d3ac72799d79ae.jpg', '2023-12-08 09:21:00', 2983, 0, 0, 'bekasi barat, normalisasi, kecamatan', 'published', 'index', NULL, NULL, '2023-12-08 09:21:00', '2023-12-08 09:21:00', NULL),
('70441a40-71a8-460c-bcc1-4e60c70f287c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan Pohon Jl Raya Juanda Rw 10 Kel Margahayu Kec Bekasi Timur', 'pemangkasan-pohon-jl-raya-juanda-rw-10-kel-margahayu-kec-bekasi-timur', 'Pemangkasan Pohon Jl Raya Juanda Rw 10 Kel Margahayu Kec Bekasi Timur', '', 'images/5a368c2b9194e85d2e581e1ed4c5d1d6.jpeg', '2021-09-13 04:31:00', 3590, 0, 1, 'bekasi timur, pemangkasan, margahayu', 'published', 'index', NULL, NULL, '2021-09-13 04:31:00', '2021-09-13 04:31:00', NULL),
('71be788f-f666-4400-85fc-9ce127f02df2', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pembersihan tali air di U-Turn jalan ahmad yani kecamatan bekasi selatan.', 'pembersihan-tali-air-di-u-turn-jalan-ahmad-yani-kecamatan-bekasi-selatan.', 'pembersihan tali air di U-Turn jalan ahmad yani kecamatan bekasi selatan.', '', 'images/a6d476b8cc82c7e36680c0cb35b9d06c.jpeg', '2024-01-17 10:25:00', 4355, 1, 1, 'bekasi selatan, pembersihan, kecamatan', 'published', 'index', NULL, NULL, '2024-01-17 10:25:00', '2024-01-17 10:25:00', NULL),
('71ff0651-d3e7-45f6-bcf0-bc3ee3829eac', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemeliharaan dan Pembersihan daun, ranting dan sampah di pedestrian jalan chairil anwar kecamatan be', 'pemeliharaan-dan-pembersihan-daun,-ranting-dan-sampah-di-pedestrian-jalan-chairil-anwar-kecamatan-bekasi-timur', 'Pemeliharaan dan Pembersihan daun, ranting dan sampah di pedestrian jalan chairil anwar kecamatan be', '', 'images/ac4f31e5866d20cbdb3eae30985b1535.jpeg', '2022-02-07 02:54:00', 561, 1, 0, 'pemeliharaan, pembersihan, pedestrian', 'published', 'index', NULL, NULL, '2022-02-07 02:54:00', '2022-02-07 02:54:00', NULL),
('740cac0e-c7e0-4736-b761-55f3396b267a', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemeliharaan lampu PJU Jalan Rawatembaga Kecamatan Bekasi Selatan.', 'pemeliharaan-lampu-pju-jalan-rawatembaga-kecamatan-bekasi-selatan.', 'Pemeliharaan lampu PJU Jalan Rawatembaga Kecamatan Bekasi Selatan.', '', 'images/3302da3d3c5ca6748642e85b2f94c799.jpeg', '2022-07-22 08:38:00', 2501, 0, 1, 'bekasi selatan, pemeliharaan, lampu', 'published', 'index', NULL, NULL, '2022-07-22 08:38:00', '2022-07-22 08:38:00', NULL),
('743208a3-f598-48fd-a7af-1233c0f51a44', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pemeliharaan lampu PJU di Jalan Raya Pondok Gede - Kecamatan Pondok Gede', 'pemeliharaan-lampu-pju-di-jalan-raya-pondok-gede---kecamatan-pondok-gede', 'pemeliharaan lampu PJU di Jalan Raya Pondok Gede - Kecamatan Pondok Gede', '', 'images/a80b8323c2e6883db089333bb51e0666.jpeg', '2024-02-28 09:31:00', 4842, 0, 1, 'pondok gede, pemeliharaan, lampu', 'published', 'index', NULL, NULL, '2024-02-28 09:31:00', '2024-02-28 09:31:00', NULL),
('74b95b33-b6c6-4a70-a3c0-9fca0a0d1abf', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat URC Pematusan penanganan sampah kali bong Kecamatan bekasi Barat crosing BKT Jakarta Timur', 'giat-urc-pematusan-penanganan-sampah-kali-bong-kecamatan-bekasi-barat-crosing-bkt-jakarta-timur', 'Giat URC Pematusan penanganan sampah kali bong Kecamatan bekasi Barat crosing BKT Jakarta Timur', '', 'images/44c329c8ae7a97212c643e9256a90639.jpg', '2021-10-25 13:25:00', 2113, 0, 0, 'bekasi barat, penanganan, kecamatan', 'published', 'index', NULL, NULL, '2021-10-25 13:25:00', '2021-10-25 13:25:00', NULL),
('79249505-bf3a-4fa0-9d6e-14f8f95108b3', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pengesetan lampu LED di jln Surya 2 galaxi Jakasetia Bekasi Selatan', 'pengesetan-lampu-led-di-jln-surya-2-galaxi-jakasetia-bekasi-selatan', 'Pengesetan lampu LED di jln Surya 2 galaxi Jakasetia Bekasi Selatan', '<h2>Pengesetan lampu LED di jln Surya 2 galaxi Jakasetia Bekasi Selatan</h2>\r\n', 'images/34db49888c5ae4ac78f49c83d4a9d58a.jpg', '2020-11-10 23:25:00', 3825, 0, 0, 'bekasi selatan, jakasetia, galaxi', 'published', 'index', NULL, NULL, '2020-11-10 23:25:00', '2020-11-10 23:25:00', NULL),
('79c88750-12ab-401f-9ea0-8820d3b0d248', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat URC Bina Marga pengaspalan jalan sersan aswan kecamatan bekasi timur', 'giat-urc-bina-marga-pengaspalan-jalan-sersan-aswan-kecamatan-bekasi-timur', 'Giat URC Bina Marga pengaspalan jalan sersan aswan kecamatan bekasi timur', '', 'images/59ddecc939a0c1d0c60eaaeea922db95.jpeg', '2021-10-25 03:22:00', 2212, 0, 1, 'bekasi timur, pengaspalan, kecamatan', 'published', 'index', NULL, NULL, '2021-10-25 03:22:00', '2021-10-25 03:22:00', NULL),
('7a49fdc6-e085-47c1-8e1f-70e1a12bf42d', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Pemangkasan pohon di Jalan Buaran Bong Raya. SDN Kayuringin Jaya 2.', 'giat-pemangkasan-pohon-di-jalan-buaran-bong-raya.-sdn-kayuringin-jaya-2.', 'Giat Pemangkasan pohon di Jalan Buaran Bong Raya. SDN Kayuringin Jaya 2. Kel. Kayuringin Jaya. Kec.Bekasi Selatan.', '<p>Giat Pemangkasan pohon<br />\r\ndi Jalan Buaran Bong Raya.<br />\r\nSDN Kayuringin Jaya 2.<br />\r\n<br />\r\nKel. Kayuringin Jaya.<br />\r\nKec.Bekasi Selatan.</p>\r\n', 'images/37c2ababd461e710765099d6f9fd5962.jpeg', '2025-06-13 06:59:00', 2349, 0, 0, 'bekasi selatan, kayuringin, jaya', 'published', 'index', NULL, NULL, '2025-06-13 06:59:00', '2025-06-13 06:59:00', NULL),
('7b4e48c2-50c8-478f-b98d-70759e1a19ab', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Gubernur Jawa Barat Ridwan Kamil menyerahkan Surat Tugas kepada Wakil Wali Kota Bekasi Tri Adhianto', 'gubernur-jawa-barat-ridwan-kamil-menyerahkan-surat-tugas-kepada-wakil-wali-kota-bekasi-tri-adhianto', '#Repost @humaskotabekasi —— Gubernur Jawa Barat Ridwan Kamil menyerahkan Surat Tugas kepada Wakil Wali Kota Bekasi Tri Adhianto menjadi Plt Wali Kota Bekasi di Rumah Dinas...', '<p>#Repost @humaskotabekasi&nbsp;<br />\r\n&mdash;&mdash;<br />\r\nGubernur Jawa Barat Ridwan Kamil menyerahkan Surat Tugas kepada Wakil Wali Kota Bekasi Tri Adhianto menjadi Plt Wali Kota Bekasi di Rumah Dinas Gubernur Jawa Barat, Jumat (7/1/2022).&nbsp;</p>\r\n\r\n<p>Turut hadir menjadi saksi, Wakil Gubernur Jawa Barat Uu Ruzhanul Ulum, dan pejabat dari Pemerintah Kota Bekasi.&nbsp;</p>\r\n\r\n<p>Ridwan Kamil menyampaikan, proses penyerahan surat tugas segera dilaksanakan mengingat pelayanan kepemerintahan harus tetap berjalan kondusif, tidak boleh dalam keadaan kosong, agar dapat dipertanggung jawabkan.&nbsp;</p>\r\n\r\n<p>&quot;Jadi hari ini Pak Wakil dipanggil ke Bandung karena kami tadi menyerahkan surat pengangkatan beliau sebagai Plt Wali Kota Bekasi. Dengan surat itu, maka beliau bisa melakukan pelayanan publik, menandatangani dokumen, dan&nbsp; menangani hal yang bersifat hukum karena tidak boleh ada kekosongan hukum,&quot; ucap Ridwan.&nbsp;</p>\r\n\r\n<p>Dasar hukum pengangkatan Wakil Wali Kota Bekasi menjadi Plt. Wali Kota Bekasi yakni Undang-Undang Nomor 23 Tahun 2014 tentang Pemerintah Daerah sebagaimana telah diubah dengan Undang-Undang Nomor 9 Tahun 2015 tentang Perubahan Kedua Atas Undang-Undang Nomor 23 Tahun 2014 tentang Pemerintah Daerah. Undang-undang tersebut mengatur hal-hal sebagai berikut:&nbsp;</p>\r\n\r\n<p>1. Pada Pasal 65 ayat (3) ditegaskan bahwa kepala daerah yang sedang menjalani masa tahanan dilarang melaksanakan tugas dan kewenangannya.&nbsp;<br />\r\n2. Pada Pasal 65 ayat (1) huruf c ditegaskan bahwa wakil kepala daerah melaksanakan tugas dan wewenang kepala daerah apabila kepala daerah menjalani masa tahanan atau berhalangan sementara.&nbsp;</p>\r\n\r\n<p>3. Pada pasal 91 ayat (2) huruf b ditegaskan bahwa gubernur sebagai wakil Pemerintah Pusat mempunyai tugas melakukan monitoring, evaluasi, dan supervisi terhadap penyelenggaraan pemerintah daerah kabupaten/kota yang ada di wilayahnya.&nbsp;</p>\r\n\r\n<p>Penyerahan surat penugasan tersebut juga sebagai tindak lanjut surat dari Menteri Dalam Negeri Tito Karnavian yang meminta Pemerintah Provinsi Jawa Barat segera menata kepemerintahan Jawa Barat secara administratif.&nbsp;</p>\r\n\r\n<p>Tri Adhianto yang ditunjuk menjadi Plt. Wali Kota Bekasi mengungkapkan, akan menjalankan arahan dan tugas sebagaimanamestinya.&nbsp;</p>\r\n\r\n<p>#salampatriot<br />\r\n#humaskotabekasi</p>\r\n', 'images/c8eab5d4b690afb80567883346da9551.jpg', '2022-01-07 15:44:00', 2000, 0, 1, 'kota bekasi, evaluasi, undang', 'published', 'index', NULL, NULL, '2022-01-07 15:44:00', '2022-01-07 15:44:00', NULL),
('7bb6a776-4b97-4507-a705-14a0681cae5d', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pembersihan taman cut mutia', 'pembersihan-taman-cut-mutia', 'pembersihan taman cut mutia', '', 'images/248a9ff5ecb36e2bd16e54b607a89306.jpeg', '2021-11-29 02:21:00', 3660, 0, 0, 'taman, pembersihan, mutia', 'published', 'index', NULL, NULL, '2021-11-29 02:21:00', '2021-11-29 02:21:00', NULL),
('7cc8051b-37e8-4a46-8c0e-1955f0c75e81', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'proses pembongkaran tembok yg jebol Perum. Bojong Menteng indah Kel Bojong menteng Kec.Rawalumbu', 'proses-pembongkaran-tembok-yg-jebol-perum.-bojong-menteng-indah-kel-bojong-menteng-kec.rawalumbu', 'proses pembongkaran tembok yg jebol Perum. Bojong Menteng indah Kel Bojong menteng Kec.Rawalumbu', '', 'images/02b32780dcf8514ac9cbb901ea542193.jpeg', '2025-07-07 03:31:00', 4500, 1, 1, 'rawalumbu, menteng, bojong', 'published', 'index', NULL, NULL, '2025-07-07 03:31:00', '2025-07-07 03:31:00', NULL),
('80987031-a058-4a92-961c-219935d2710e', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'PERBAIKAN LAMPU PJU JL.ASTER KEL.KOTA BARU KEC.BEKASI BARAT', 'perbaikan-lampu-pju-jl.aster-kel.kota-baru-kec.bekasi-barat', 'PERBAIKAN LAMPU PJU JL.ASTER KEL.KOTA BARU KEC.BEKASI BARAT', '', 'images/dab7f940015fb97a34a781aaba792a10.jpeg', '2021-08-25 08:47:00', 2910, 0, 1, 'bekasi barat, perbaikan, lampu', 'published', 'index', NULL, NULL, '2021-08-25 08:47:00', '2021-08-25 08:47:00', NULL),
('8138bd53-31f2-44de-8143-0b46784a87d5', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat pematusan Saluran Sekunder Jembatan Chandra Indah Rt. 001 Rw. 015 Kel. Jatirahayu Kec. Pondok melati', 'giat-pematusan-saluran-sekunder-jembatan-chandra-indah-rt.-001-rw.-015-kel.-jatirahayu-kec.-pondok-melati', 'Giat pematusan Saluran Sekunder Jembatan Chandra Indah Rt. 001 Rw. 015 Kel. Jatirahayu Kec. Pondok melati', '', 'images/fed99e076a6211a1d8a0477232892038.jpg', '2025-06-16 09:24:00', 1135, 1, 0, 'pondok melati, jatirahayu, pematusan', 'published', 'index', NULL, NULL, '2025-06-16 09:24:00', '2025-06-16 09:24:00', NULL),
('820c19ed-6e1d-4e1f-bfe9-bc8e10fed096', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Joint survey di kali jambe km 19 terkait banjir dan sampah dengan Kementerian PUPR dirjen BM, Jasa M', 'joint-survey-di-kali-jambe-km-19-terkait-banjir-dan-sampah-dengan-kementerian-pupr-dirjen-bm,-jasa-marga-dan-pemkab-bekasi.', 'Joint survey di kali jambe km 19 terkait banjir dan sampah dengan Kementerian PUPR dirjen BM, Jasa M', '', 'images/5c8f632c288805c52e4d1783bf222c4e.jpg', '2021-09-27 12:51:00', 4214, 0, 0, 'kementerian, terkait, banjir', 'published', 'index', NULL, NULL, '2021-09-27 12:51:00', '2021-09-27 12:51:00', NULL),
('82dfaa70-2d7a-4aa3-8f21-7c9414b5a367', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan diwilayah perumahan rawalumbu', 'pemangkasan-diwilayah-perumahan-rawalumbu', 'Pemangkasan diwilayah perumahan rawalumbu', '', 'images/12ecae576a448461eb0b4f1ef9105857.jpeg', '2021-10-14 10:08:00', 4301, 1, 0, 'rawalumbu, pemangkasan, diwilayah', 'published', 'index', NULL, NULL, '2021-10-14 10:08:00', '2021-10-14 10:08:00', NULL),
('838fbf6c-fef2-4837-b2fc-1359e530a823', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemeliharaan lampu PJU di perumahan bojongmenteng Kecamatan Rawalumbu.', 'pemeliharaan-lampu-pju-di-perumahan-bojongmenteng-kecamatan-rawalumbu.', 'Pemeliharaan lampu PJU di perumahan bojongmenteng Kecamatan Rawalumbu.', '', 'images/98e97c08600f5c628a6a64577e026fad.jpeg', '2022-08-04 08:25:00', 2818, 0, 0, 'rawalumbu, pemeliharaan, lampu', 'published', 'index', NULL, NULL, '2022-08-04 08:25:00', '2022-08-04 08:25:00', NULL),
('840ab508-3dd8-461f-8ef8-bb2bf4f406d8', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan pohon jalan raya pekayon - jatiasih ', 'pemangkasan-pohon-jalan-raya-pekayon---jatiasih', 'Pemangkasan pohon jalan raya pekayon - jatiasih', '', 'images/1503ed9af3c4c185a1320719149c0a36.jpeg', '2021-08-20 08:22:00', 4982, 0, 0, 'pemangkasan, jatiasih, pekayon', 'published', 'index', NULL, NULL, '2021-08-20 08:22:00', '2021-08-20 08:22:00', NULL),
('84d25353-4f71-4d47-b582-9158b3b27b7f', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Mari teruskan warisan sejarah semangat insan KORPRI melalui KORPRI Berkarya, Melayani, Dan Menyatuka', 'mari-teruskan-warisan-sejarah-semangat-insan-korpri-melalui-korpri-berkarya,-melayani,-dan-menyatukan-bangsa,-selamat-atas-hut-korpri-ke-50-merdeka!!!', 'Mari teruskan warisan sejarah semangat insan KORPRI melalui KORPRI Berkarya, Melayani, Dan Menyatuka', '', 'images/02c0195f178934cbf570be9a0019c6ec.jpg', '2021-11-29 02:35:00', 793, 0, 1, 'korpri, menyatuka, berkarya', 'published', 'index', NULL, NULL, '2021-11-29 02:35:00', '2021-11-29 02:35:00', NULL),
('8714cd13-7d99-415e-bf41-21491b3f6b45', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Normalisasi saluran tana apit kecamatan medan satria', 'normalisasi-saluran-tana-apit-kecamatan-medan-satria', 'Normalisasi saluran tana apit kecamatan medan satria', '', 'images/2700acabd48b435f9bf89edb3666078f.jpeg', '2021-09-17 08:06:00', 2842, 0, 0, 'medan satria, normalisasi, kecamatan', 'published', 'index', NULL, NULL, '2021-09-17 08:06:00', '2021-09-17 08:06:00', NULL),
('87659e83-62cd-4dcb-8285-d7c274db80ec', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Monitoring Kepala Dinas', 'monitoring-kepala-dinas', 'Monitoring kepala Dinas Bina Marga dan Sumber Daya Air Kota bekasi terkait pembangunan di tiga lokasi wilayah kecamatan Bantargebang 1.pelebaran jalan pangkalan II Bantar...', '<p>Monitoring kepala Dinas Bina Marga dan Sumber Daya Air Kota bekasi terkait pembangunan&nbsp;di tiga lokasi wilayah kecamatan Bantargebang&nbsp;1.pelebaran jalan pangkalan II Bantar gebang 2.perbaikan jalan pangkalan V 3.pekerjaan saluran depan Yon Armed</p>\r\n', 'images/d00202ceb07ed6b28ba414bd118c85d9.jpeg', '2021-09-06 07:41:00', 656, 1, 0, 'kota bekasi, bantar gebang, bantargebang', 'published', 'index', NULL, NULL, '2021-09-06 07:41:00', '2021-09-06 07:41:00', NULL),
('87d3f63e-3b5d-4330-9835-7337d0fdda3b', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Kunjungan kerja dari DPRD Kabupaten Jembrana Bali', 'kunjungan-kerja-dari-dprd-kabupaten-jembrana-bali', 'alhamdulilah pagi ini kami menerima Kunjungan kerja dari DPRD Kabupaten Jembrana Bali. Kepala Bidang Sumber Daya Air menerima dan memberikan paparan terkait sistem drainase dan...', '<p>alhamdulilah pagi ini kami menerima Kunjungan kerja dari DPRD Kabupaten Jembrana Bali.<br />\r\n<br />\r\nKepala Bidang Sumber Daya Air menerima dan memberikan paparan terkait sistem drainase dan perencanaan pembangunan daerah.</p>\r\n', 'images/cda3412aeffcf8421e719b4e7c8f4e0f.jpeg', '2022-01-26 04:20:00', 4372, 0, 0, 'menerima, alhamdulilah, pembangunan', 'published', 'index', NULL, NULL, '2022-01-26 04:20:00', '2022-01-26 04:20:00', NULL),
('887a41df-9294-4817-96d2-ca15f61554a4', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'GIAT TIM URC BINAMARGA Normalisasi Saluran & Tali Air Di Jalan. Ahmad yani Posisis depan hotel amaro', 'giat-tim-urc-binamarga-normalisasi-saluran-&-tali-air-di-jalan.-ahmad-yani-posisis-depan-hotel-amarosa', 'GIAT TIM URC BINAMARGA Normalisasi Saluran & Tali Air Di Jalan. Ahmad yani Posisis depan hotel amaro', '', 'images/7b7da9eacea5f1e710d65d553e2b46bd.jpeg', '2022-02-07 02:41:00', 2596, 1, 0, 'normalisasi, binamarga, posisis', 'published', 'index', NULL, NULL, '2022-02-07 02:41:00', '2022-02-07 02:41:00', NULL),
('88eb5df2-3b26-4b5b-aef2-8742375335fe', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pembangunan tanggul dinding penahan tanah (DPT)', 'pembangunan-tanggul-dinding-penahan-tanah-(dpt)', 'Yukkk dilihat progres pembangunan refitalisasi kali bekasi di minggu ke 37 Pembangunan tanggul dinding penahan tanah (DPT) dibeberapa titik aliran kali bekasi sudah masuk di...', '<p>Yukkk dilihat progres pembangunan refitalisasi kali bekasi di minggu ke 37<br />\r\n<br />\r\nPembangunan tanggul dinding penahan tanah (DPT) dibeberapa titik aliran kali bekasi sudah masuk di minggu ke 37. Pembangunan di kerjakan oleh @<a href=\"https://www.instagram.com/kemenpupr/\">kemenpupr</a>&nbsp;<a href=\"https://www.instagram.com/pupr_sda_ciliwungcisadane/\">@pupr_sda_ciliwungcisadane</a><br />\r\n<br />\r\nSemoga dengan terbanguannya tanggul penahan dinding (DPT) ini dapat mencegah ketika air kali bekasi tinggi.</p>\r\n', 'images/12a243146c6b772a81b4b5d0d33931ad.jpeg', '2021-11-01 08:44:00', 2296, 0, 0, 'pembangunan, bekasi, kali', 'published', 'index', NULL, NULL, '2021-11-01 08:44:00', '2021-11-01 08:44:00', NULL),
('8b047965-771d-4afc-b4c9-c29761cffec3', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemasangan Jaringan Kabel PJU Jalan raya vila Jatirasa kelurahan Jatrasa - kecamatan Jatiasih', 'pemasangan-jaringan-kabel-pju-jalan-raya-vila-jatirasa-kelurahan-jatrasa---kecamatan-jatiasih', 'Pemasangan Jaringan Kabel PJU Jalan raya vila Jatirasa kelurahan Jatrasa - kecamatan Jatiasih', '', 'images/a127feb623f71d230976508956924ecd.jpg', '2023-12-18 08:44:00', 1069, 1, 1, 'jaringan, pemasangan, kecamatan', 'published', 'index', NULL, NULL, '2023-12-18 08:44:00', '2023-12-18 08:44:00', NULL),
('8b2632b1-88b7-4b35-9f47-f37653bd0dde', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemeliharaan Lampu PJU di Jalan Palem Raya rw 17 Kelurahan Pekayon Jaya Kecamatan Bekasi Selatan', 'pemeliharaan-lampu-pju-di-jalan-palem-raya-rw-17-kelurahan-pekayon-jaya-kecamatan-bekasi-selatan', 'Pemeliharaan Lampu PJU di Jalan Palem Raya rw 17 Kelurahan Pekayon Jaya Kecamatan Bekasi Selatan', '', 'images/a3d2a6323c6b42351485719ba2d841e7.jpg', '2023-12-12 07:46:00', 3522, 1, 0, 'bekasi selatan, pemeliharaan, lampu', 'published', 'index', NULL, NULL, '2023-12-12 07:46:00', '2023-12-12 07:46:00', NULL),
('8cb4f2ff-93e6-4483-b074-ec0470b41188', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan pohon Jl Raya Agus Salim Kel.Bekasi Jaya Kec.Bekasi Timur', 'pemangkasan-pohon-jl-raya-agus-salim-kel.bekasi-jaya-kec.bekasi-timur', 'Pemangkasan pohon Jl Raya Agus Salim Kel.Bekasi Jaya Kec.Bekasi Timur', '', 'images/cf520f27652ad47ef6ee970970cf0aec.jpeg', '2025-07-04 09:43:00', 4977, 0, 0, 'bekasi timur, bekasi, pemangkasan', 'published', 'index', NULL, NULL, '2025-07-04 09:43:00', '2025-07-04 09:43:00', NULL);
INSERT INTO `articles` (`uuid`, `user_uuid`, `category_uuid`, `title`, `slug`, `excerpt`, `content`, `featured_image`, `scheduled_at`, `views`, `is_featured`, `is_popular`, `tagging`, `status`, `search_engine`, `link`, `video`, `created_at`, `updated_at`, `deleted_at`) VALUES
('8d0a0452-bde6-468b-b5ca-4bfaad323656', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pemeliharaan lampu PJU RT.03 RW.05 Kelurahan Sumur Batu Kecamatan Bantargebang', 'pemeliharaan-lampu-pju-rt.03-rw.05-kelurahan-sumur-batu-kecamatan-bantargebang', 'pemeliharaan lampu PJU RT.03 RW.05 Kelurahan Sumur Batu Kecamatan Bantargebang', '', 'images/3e3aa0a07cdc61ad4541448ebf6fcea8.jpg', '2023-12-20 08:54:00', 900, 0, 0, 'bantargebang, pemeliharaan, lampu', 'published', 'index', NULL, NULL, '2023-12-20 08:54:00', '2023-12-20 08:54:00', NULL),
('8d47f676-f783-4e2a-b91a-3a9ee442f710', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Tim Pematusan Penanganan Saluran RW.09 Kelurahan Duren Jaya Kecamatan Bekasi timur', 'giat-tim-pematusan-penanganan-saluran-rw.09-kelurahan-duren-jaya-kecamatan-bekasi-timur', 'Giat Tim Pematusan Penanganan Saluran RW.09 Kelurahan Duren Jaya Kecamatan Bekasi timur', '', 'images/f4ad0f610913aaceb285c5e92c71af3c.jpeg', '2022-01-21 08:28:00', 4662, 0, 0, 'bekasi timur, penanganan, kecamatan', 'published', 'index', NULL, NULL, '2022-01-21 08:28:00', '2022-01-21 08:28:00', NULL),
('8ebd8e74-0ddb-4560-848e-0a4e2b54248d', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat tim Pematusan Normalisasi Saluran Jalan Raya Kodau Kecamatan Jatiasih.', 'giat-tim-pematusan-normalisasi-saluran-jalan-raya-kodau-kecamatan-jatiasih.', 'Giat tim Pematusan Normalisasi Saluran Jalan Raya Kodau Kecamatan Jatiasih.', '', 'images/c39c48decce0b3daa3dfb7d9f21b696d.jpeg', '2022-07-22 08:39:00', 3258, 0, 0, 'normalisasi, kecamatan, pematusan', 'published', 'index', NULL, NULL, '2022-07-22 08:39:00', '2022-07-22 08:39:00', NULL),
('917e8a06-e1e9-4c09-9e58-896c62eff5cc', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan Pohon Angsana Jln. Keranggan Permai Rt.001/RT.015 Kel. Jatisampurna Kec.Jatisampurna Kota Bekasi.', 'pemangkasan-pohon-angsana-jln.-keranggan-permai-rt.001/rt.015-kel.-jatisampurna-kec.jatisampurna-kota-bekasi.', 'Pemangkasan Pohon Angsana Jln. Keranggan Permai Rt.001/RT.015 Kel. Jatisampurna Kec.Jatisampurna Kota Bekasi.', '', 'images/7f59971674828f2777e4f49f0ac6a93a.jpeg', '2025-06-18 01:29:00', 921, 0, 1, 'kota bekasi, jatisampurna, pemangkasan', 'published', 'index', NULL, NULL, '2025-06-18 01:29:00', '2025-06-18 01:29:00', NULL),
('92939402-173d-4aa1-8216-e437c14d5913', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Perbaikan lampu PJU Jl.Ading Kel.bantargebang kec.bantargebang', 'perbaikan-lampu-pju-jl.ading-kel.bantargebang-kec.bantargebang', 'Perbaikan lampu PJU Jl.Ading Kel.bantargebang kec.bantargebang', '', 'images/a3cdcdc63c4d543eb32772b483c2e5c2.jpeg', '2021-09-14 08:19:00', 4701, 0, 1, 'bantargebang, perbaikan, lampu', 'published', 'index', NULL, NULL, '2021-09-14 08:19:00', '2021-09-14 08:19:00', NULL),
('93af70e2-b4bd-47c9-8d3e-57c82294542d', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Perbaikan lampu PJU JL.Sersan marjuki ', 'perbaikan-lampu-pju-jl.sersan-marjuki', 'Perbaikan lampu PJU JL.Sersan marjuki', '', 'images/0600f8638c4de4796657e953eb735519.jpeg', '2021-09-28 10:42:00', 4091, 0, 1, 'perbaikan, lampu, marjuki', 'published', 'index', NULL, NULL, '2021-09-28 10:42:00', '2021-09-28 10:42:00', NULL),
('946d7ca1-2183-4f9f-b80c-9e431a64eb2d', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan Pohon di pertigaan Jl.Palem Barat RW.016 Pekayon Jaya Bekasi Selatan', 'pemangkasan-pohon-di-pertigaan-jl.palem-barat-rw.016-pekayon-jaya-bekasi-selatan', 'Pemangkasan Pohon di pertigaan Jl.Palem Barat RW.016 Pekayon Jaya Bekasi Selatan', '', 'images/d9f36e2fdac19226235913fbe04bd8b0.jpeg', '2022-02-02 05:46:00', 1405, 0, 0, 'bekasi selatan, pemangkasan, pertigaan', 'published', 'index', NULL, NULL, '2022-02-02 05:46:00', '2022-02-02 05:46:00', NULL),
('95723612-6a39-49ab-ac94-4d7e53c21803', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pemangkasan pohon tumbang di Jalan Cut Mutia Kecamatan Bekasi Timur', 'pemangkasan-pohon-tumbang-di-jalan-cut-mutia-kecamatan-bekasi-timur', 'pemangkasan pohon tumbang di Jalan Cut Mutia Kecamatan Bekasi Timur', '', 'images/c3f26a52edbdd03ba0b638aea8472f10.jpeg', '2024-01-03 03:06:00', 355, 0, 0, 'bekasi timur, pemangkasan, kecamatan', 'published', 'index', NULL, NULL, '2024-01-03 03:06:00', '2024-01-03 03:06:00', NULL),
('96775bf5-7a71-48fe-bdc6-17ecb6c726fa', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat pematusan saluran sekunder tytyan indah rw 12 Kelurahan Kalibaru', 'giat-pematusan-saluran-sekunder-tytyan-indah-rw-12-kelurahan-kalibaru', 'Giat pematusan saluran sekunder tytyan indah rw 12 Kelurahan Kalibaru', '', 'images/376f5f8b7bff130b3569776a35351019.jpeg', '2024-05-07 01:55:00', 1964, 0, 0, 'kelurahan, pematusan, kalibaru', 'published', 'index', NULL, NULL, '2024-05-07 01:55:00', '2024-05-07 01:55:00', NULL),
('967c394b-c309-45ae-9154-6469c6fc8cde', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan Pohon Perumahan Taman Kota Kel.Bekasi Jaya', 'pemangkasan-pohon-perumahan-taman-kota-kel.bekasi-jaya', 'Pemangkasan Pohon Perumahan Taman Kota Kel.Bekasi Jaya', '', 'images/4728fbcc45f04b42c16050b85ef0d242.jpeg', '2021-10-13 08:56:00', 581, 0, 0, 'taman, pemangkasan, perumahan', 'published', 'index', NULL, NULL, '2021-10-13 08:56:00', '2021-10-13 08:56:00', NULL),
('9731bd8e-589e-44ee-ba1b-801053659bb3', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'PERBAIKAN JARINGAN PJU PERUM BTR BLOK D KEL.CIMUNING KEC.MUSTIKA JAYA', 'perbaikan-jaringan-pju-perum-btr-blok-d-kel.cimuning-kec.mustika-jaya', 'PERBAIKAN JARINGAN PJU PERUM BTR BLOK D KEL.CIMUNING KEC.MUSTIKA JAYA', '', 'images/b08b46fe162b2ee767f9d85e02560a7d.jpeg', '2021-11-12 08:25:00', 754, 0, 1, 'mustika jaya, perbaikan, jaringan', 'published', 'index', NULL, NULL, '2021-11-12 08:25:00', '2021-11-12 08:25:00', NULL),
('9a893dc6-bacd-4c62-9885-670500154759', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Selamat hari pahlawan 10 November 2021  PAHLAWAN INSPIRASIKU  ', 'selamat-hari-pahlawan-10-november-2021--pahlawan-inspirasiku', 'Selamat hari pahlawan 10 November 2021 PAHLAWAN INSPIRASIKU', '', 'images/5e254c487acefc614d470074b67f84eb.jpg', '2021-11-10 08:40:00', 3619, 1, 0, 'pahlawan, inspirasiku, selamat', 'published', 'index', NULL, NULL, '2021-11-10 08:40:00', '2021-11-10 08:40:00', NULL),
('9bdeef7d-80cc-49a1-a12f-d616452016ba', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Penebangan Pohon ', 'penebangan-pohon', 'Hujan deras disertai angin kencang dengan intensitas tinggi mengakibatkan pohon tumbang di beberapa titik sepanjang Jalan Raya Narogong, Kecamatan Rawalumbu. Tim URC DBMSDA...', '<p>Hujan deras disertai angin kencang dengan intensitas tinggi mengakibatkan pohon tumbang di beberapa titik sepanjang Jalan Raya Narogong, Kecamatan Rawalumbu.<br />\r\n<br />\r\nTim URC DBMSDA Kota Bekasi saat ini tengah tersebar di titik-titik lokasi untuk melakukan evakuasi, pemotongan batang pohon, serta pembersihan badan jalan guna memastikan keamanan pengguna jalan.<br />\r\n<br />\r\n? Status: Proses penanganan sedang berlangsung. Kami upayakan agar arus lalu lintas kembali normal secepatnya.<br />\r\n<br />\r\nGiat evakuasi dan pembersihan jalur ini Di monitor llangsung oleh Kepala Bidang Pemanfaatan Ruang Milik Jalan dan Taman (PRJT) untuk memastikan kelancaran arus lalu lintas dan keamanan pengguna jalan.</p>\r\n', 'images/fb6fc8c375468ef0146e3026220c6cca.jpeg', '2026-04-13 02:11:00', 3092, 0, 0, 'kota bekasi, rawalumbu, evakuasi', 'published', 'index', NULL, NULL, '2026-04-13 02:11:00', '2026-04-13 02:11:00', NULL),
('9da88a7d-50b7-44d7-989b-d0f7782d617f', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Tim URC PJU Bidang Prasarana Jalan giat Pemeliharaan lampu PJU Jalan Mandor Aren Jaya', 'tim-urc-pju-bidang-prasarana-jalan-giat-pemeliharaan-lampu-pju-jalan-mandor-aren-jaya', 'Tim URC PJU Bidang Prasarana Jalan giat Pemeliharaan lampu PJU Jalan Mandor Aren Jaya', '', 'images/8a718293c2df0a8314a1010ad8a34829.jpeg', '2024-05-07 01:46:00', 2941, 1, 1, 'pemeliharaan, lampu, prasarana', 'published', 'index', NULL, NULL, '2024-05-07 01:46:00', '2024-05-07 01:46:00', NULL),
('9da89957-6e4d-466d-a203-9b4789a2b562', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Evaluasi pekerjaan dan Briefing staf bidang P&P', 'evaluasi-pekerjaan-dan-briefing-staf-bidang-p&p', 'Evaluasi pekerjaan dan Briefing staf bidang P&P', '<h2>Evaluasi pekerjaan dan Briefing staf bidang P&amp;P</h2>\r\n', 'images/59bfba0c658068f58269e493f6e22e65.jpg', '2020-11-10 23:35:00', 4611, 0, 1, 'pekerjaan, evaluasi, briefing', 'published', 'index', NULL, NULL, '2020-11-10 23:35:00', '2020-11-10 23:35:00', NULL),
('9e6a44b7-e283-465b-973c-a4d9c36004e0', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Perjuangan belum usai, jadilah Kartini untuk hidupmu dan sekelilingmu. Majulah perempuan Indonesia. ', 'perjuangan-belum-usai,-jadilah-kartini-untuk-hidupmu-dan-sekelilingmu.-majulah-perempuan-indonesia.-selamat-hari-kartini.', 'Perjuangan belum usai, jadilah Kartini untuk hidupmu dan sekelilingmu. Majulah perempuan Indonesia.', '', 'images/36d1470bc25198d15eb22b2137f23b46.png', '2022-04-21 06:27:00', 2780, 1, 0, 'sekelilingmu, perjuangan, indonesia', 'published', 'index', NULL, NULL, '2022-04-21 06:27:00', '2022-04-21 06:27:00', NULL),
('9e7656ff-994c-4290-b238-10e5e9344c46', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Kegiatan pagi ini mengurangi TMA air polder pengasinan', 'kegiatan-pagi-ini-mengurangi-tma-air-polder-pengasinan', 'Kegiatan pagi ini mengurangi TMA air polder pengasinan', '', 'images/ef51b2de359f57c51a27e5ac9ca02c03.jpeg', '2026-04-13 02:32:00', 182, 0, 0, 'pengasinan, kegiatan, mengurangi', 'published', 'index', NULL, NULL, '2026-04-13 02:32:00', '2026-04-13 02:32:00', NULL),
('a1d67d7b-b114-4446-bc03-e8b3c991d1d9', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan pohon di jalan pangeran jayakarta', 'pemangkasan-pohon-di-jalan-pangeran-jayakarta', 'Pemangkasan pohon di jalan pangeran jayakarta', '', 'images/5e48d13b30ef2f048794b90c61580f65.jpeg', '2022-01-12 04:45:00', 2922, 0, 0, 'pemangkasan, jayakarta, pangeran', 'published', 'index', NULL, NULL, '2022-01-12 04:45:00', '2022-01-12 04:45:00', NULL),
('a2903e0e-6b29-4a2c-9730-93cd9118a0b6', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', ' pagi ini kami tim URC Bina Marga melaksanakan normalisasi dan pembersihan tali air di jalan KH.Agus', 'pagi-ini-kami-tim-urc-bina-marga-melaksanakan-normalisasi-dan-pembersihan-tali-air-di-jalan-kh.agus-salim-kecamatan-bekasi-timur.', 'pagi ini kami tim URC Bina Marga melaksanakan normalisasi dan pembersihan tali air di jalan KH.Agus', '', 'images/1b675e0061d687dcb9b8bcccd084bee3.jpeg', '2022-02-02 04:48:00', 3617, 1, 1, 'melaksanakan, normalisasi, pembersihan', 'published', 'index', NULL, NULL, '2022-02-02 04:48:00', '2022-02-02 04:48:00', NULL),
('a292f67d-ce66-4ded-aba1-698a2683eb8a', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'perbaikan bibir saluran di Simpang jl.M Hasibuan Jl.Dewi Sartika Kel Margahayu kec. Bekasi timur.', 'perbaikan-bibir-saluran-di-simpang-jl.m-hasibuan-jl.dewi-sartika-kel-margahayu-kec.-bekasi-timur.', 'perbaikan bibir saluran di Simpang jl.M Hasibuan Jl.Dewi Sartika Kel Margahayu kec. Bekasi timur.', '', 'images/99b5715e9121eacb0615d5644d4d2ecf.jpeg', '2025-07-11 04:51:00', 3479, 1, 1, 'bekasi timur, perbaikan, margahayu', 'published', 'index', NULL, NULL, '2025-07-11 04:51:00', '2025-07-11 04:51:00', NULL),
('a474857e-57fe-4d1c-b41d-259c7a755b60', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Survey bersama kementrian PU di jalan sudirman', 'survey-bersama-kementrian-pudi-jalan-sudirman', 'Survey bersama kementrian PU @kementerianpu di jalan sudirman sta 2+100 sisi kanan arah Jakarta yang di wakili oleh staff PPK 15. Pihak kementrian PU siap menangani banjir...', '<p>Survey bersama kementrian PU&nbsp;<a href=\"https://www.instagram.com/kementerianpu/\">@kementerianpu</a>&nbsp;di jalan sudirman sta 2+100 sisi kanan arah Jakarta yang di wakili oleh staff PPK 15.<br />\r\n<br />\r\nPihak kementrian PU siap menangani banjir bersama pemerintah Kota Bekasi di jalan Sudirman sta 2+100 (depan SPBU vivo) dan membuat saluran baru dari depan SPBU VIVO ke arah Kali Jati Luhur/Kali Rawa Tembaga dengan kontruksi U-Ditch.</p>\r\n', 'images/933d44169a6363c9d95876385685ef7a.jpeg', '2025-06-13 06:55:00', 441, 0, 1, 'kota bekasi, kementrian, sudirman', 'published', 'index', NULL, NULL, '2025-06-13 06:55:00', '2025-06-13 06:55:00', NULL),
('a5dce200-c0df-4fde-b77a-c211a8ab35f5', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat tim pematusan dan alat berat penanganan tanah longsor perum graha mustikajaya', 'giat-tim-pematusan-dan-alat-berat-penanganan-tanah-longsor-perum-graha-mustikajaya', 'Giat tim pematusan dan alat berat penanganan tanah longsor perum graha mustikajaya', '', 'images/4274689d92b706c02506e4e60394a031.jpeg', '2021-11-08 10:50:00', 1261, 0, 0, 'mustikajaya, penanganan, pematusan', 'published', 'index', NULL, NULL, '2021-11-08 10:50:00', '2021-11-08 10:50:00', NULL),
('a61cb732-e893-4a87-aba6-ca083968ca05', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat URC Bina Marga Pembuatan sumur resapan di kantor kelurahan bekasi jaya', 'giat-urc-bina-marga-pembuatan-sumur-resapan-di-kantor-kelurahan-bekasi-jaya', 'Giat URC Bina Marga Pembuatan sumur resapan di kantor kelurahan bekasi jaya', '', 'images/cb6dc135e9d892e135e0bb396fc38e8c.jpeg', '2022-01-19 08:31:00', 488, 1, 0, 'kelurahan, pembuatan, resapan', 'published', 'index', NULL, NULL, '2022-01-19 08:31:00', '2022-01-19 08:31:00', NULL),
('a7264974-9c2c-444d-84c0-83e22c4b41e1', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'SELAMAT HARI GURU 25 NOVEMBER 2021', 'selamat-hari-guru-25-november-2021', 'Mempunyai ketetapan, tidak tergoyahkan, berisi dengan berilmu pengetahuan, hingga yakin dengan seyakin-yakinnya bahwa apa yang dilakukannya adalah benar dan baik. - Ki Hajar...', '<p>Mempunyai ketetapan, tidak tergoyahkan, berisi dengan berilmu pengetahuan, hingga yakin dengan seyakin-yakinnya bahwa apa yang dilakukannya adalah benar dan baik. - Ki Hajar Dewantara.<br />\r\n<br />\r\nSELAMAT HARI GURU 25 NOVEMBER 2021</p>\r\n', 'images/59a9556e1e824182e6e60a9a9079112a.jpg', '2021-11-25 04:06:00', 1591, 0, 0, 'dilakukannya, pengetahuan, tergoyahkan', 'published', 'index', NULL, NULL, '2021-11-25 04:06:00', '2021-11-25 04:06:00', NULL),
('a739fec6-1870-4eb6-a4c6-961042fa51af', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'enanganan  rumpun Bambu longsor Kali Cakung,Kel.Jatimurni Rw 05', 'enanganan--rumpun-bambu-longsor-kali-cakung,kel.jatimurni-rw-05', 'enanganan rumpun Bambu longsor Kali Cakung,Kel.Jatimurni Rw 05', '', 'images/c97645f8f7ce4d146e3c97fdfd79a7da.jpeg', '2025-07-11 06:12:00', 2886, 0, 0, 'enanganan, jatimurni, longsor', 'published', 'index', NULL, NULL, '2025-07-11 06:12:00', '2025-07-11 06:12:00', NULL),
('a976971f-fe1c-4c9a-a73d-25acbd4e1f16', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'MONITORING PEMBUATAN SUMUR RESAPAN', 'monitoring-pembuatan-sumur-resapan', 'Kepala Dinas Bina Marga dan Sumber Daya Air di dampingi Kepala UPTD BMSDA Jatiasih dan Camat Kecamatan Jatiasih monitoring kegiatan pembuatan sumur resapan di Kecamatan Jatiasih.', '<p>Kepala Dinas Bina Marga dan Sumber Daya Air di dampingi Kepala UPTD BMSDA Jatiasih dan Camat Kecamatan Jatiasih monitoring kegiatan pembuatan sumur resapan di Kecamatan Jatiasih.</p>\r\n', 'images/f29cc293367b8aac8e7732cd8e772707.png', '2023-07-04 04:40:00', 3274, 0, 0, 'kegiatan, jatiasih, kecamatan', 'published', 'index', NULL, NULL, '2023-07-04 04:40:00', '2023-07-04 04:40:00', NULL),
('a99ee890-5557-47a6-9561-70e345e194e3', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'giat pembersihan saluran crosing tol perumahan Bumi Bekasi Baru Kecamatan Rawalumbu', 'giat-pembersihan-saluran-crosing-tol-perumahan-bumi-bekasi-baru-kecamatan-rawalumbu', 'giat pembersihan saluran crosing tol perumahan Bumi Bekasi Baru Kecamatan Rawalumbu', '', 'images/ee886f7e03f37da3ff5590c379d3f4f3.jpeg', '2023-11-28 07:52:00', 3190, 0, 0, 'rawalumbu, pembersihan, kecamatan', 'published', 'index', NULL, NULL, '2023-11-28 07:52:00', '2023-11-28 07:52:00', NULL),
('ac338d5f-c1e7-4771-aeee-cdcda31411fa', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Tim URC PJU melaksanakan giat Pemeliharan lampu PJU Jalan. Asih 1. Kelurahan. Jatisari - Kecamatan. ', 'tim-urc-pju-melaksanakan-giat-pemeliharan-lampu-pju-jalan.-asih-1.-kelurahan.-jatisari---kecamatan.-jatiasih.', 'Tim URC PJU melaksanakan giat Pemeliharan lampu PJU Jalan. Asih 1. Kelurahan. Jatisari - Kecamatan.', '', 'images/18722489e46e7f1a654970b487d93aac.jpg', '2023-11-07 07:24:00', 105, 0, 0, 'lampu, melaksanakan, pemeliharan', 'published', 'index', NULL, NULL, '2023-11-07 07:24:00', '2023-11-07 07:24:00', NULL),
('ac9d33ed-5ff3-4947-bc07-278adb9f197f', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Penyiraman taman jatiasih jalan wibawamukti kecamatan jatiasih', 'penyiraman-taman-jatiasih-jalan-wibawamukti-kecamatan-jatiasih', 'Penyiraman taman jatiasih jalan wibawamukti kecamatan jatiasih', '', 'images/487c774531117bb893483a53e90ec5dc.jpeg', '2022-01-31 08:07:00', 2995, 0, 0, 'penyiraman, taman, jatiasih', 'published', 'index', NULL, NULL, '2022-01-31 08:07:00', '2022-01-31 08:07:00', NULL),
('b05f3c25-18cb-4fce-89f0-a3d07ad5c946', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Pematuean saluran sekunder PDAM kp sawah indah RW 005', 'giat-pematuean-saluran-sekunder-pdam-kp-sawah-indah-rw-005', 'Giat Pematuean saluran sekunder PDAM kp sawah indah RW 005 Kel marga Mulya Kec.bekasi Utara', '<p>Giat Pematuean saluran sekunder PDAM kp sawah indah RW 005<br />\r\n<br />\r\nKel marga Mulya<br />\r\nKec.bekasi Utara</p>\r\n', 'images/0de25f5f24b05cf01e056b5776bbceee.jpg', '2025-06-13 07:02:00', 2042, 0, 0, 'bekasi utara, pematuean, sekunder', 'published', 'index', NULL, NULL, '2025-06-13 07:02:00', '2025-06-13 07:02:00', NULL),
('b0925b3b-e42f-44b7-bd8c-ea9496902505', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'URC Pematusan penanganan genangan luapan saluran tersier jl. Caman raya pertigaan apotik argia Jatib', 'urc-pematusan-penanganan-genangan-luapan-saluran-tersier-jl.-caman-raya-pertigaan-apotik-argia-jatibening.', 'URC Pematusan penanganan genangan luapan saluran tersier jl. Caman raya pertigaan apotik argia Jatib', '', 'images/47124c93f316c5afec2d9325cc89197e.jpeg', '2021-08-24 02:27:00', 432, 0, 0, 'penanganan, pematusan, pertigaan', 'published', 'index', NULL, NULL, '2021-08-24 02:27:00', '2021-08-24 02:27:00', NULL),
('b1a75eef-5d2d-4a2d-b7d6-a73eea15191f', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pengaspalan Gg.Turi Kelurahan Margahayu Kecamatan Bekasi Timur.', 'pengaspalan-gg.turi-kelurahan-margahayu-kecamatan-bekasi-timur.', 'Pengaspalan Gg.Turi Kelurahan Margahayu Kecamatan Bekasi Timur.', '', 'images/78631d94c69472bcb714e8d1d48a090b.jpeg', '2022-09-05 08:38:00', 2843, 0, 0, 'bekasi timur, pengaspalan, kecamatan', 'published', 'index', NULL, NULL, '2022-09-05 08:38:00', '2022-09-05 08:38:00', NULL),
('b1f7a210-c07f-420e-bf5c-c2843ae5cb85', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Penopingan pemeliharaan di median tengah. Jln utama Raya A Yani Kel Margajaya. Kec.Bekasi Selatan.', 'penopingan-pemeliharaan-di-median-tengah.-jln-utama-raya-a-yani-kel-margajaya.-kec.bekasi-selatan.', 'Penopingan pemeliharaan di median tengah. Jln utama Raya A Yani Kel Margajaya. Kec.Bekasi Selatan.', '<p>Penopingan pemeliharaan di median tengah.<br />\r\nJln utama Raya A Yani<br />\r\nKel Margajaya.<br />\r\nKec.Bekasi Selatan.</p>\r\n', 'images/03fcc16f3c6d16adec5c4aad2a633196.jpeg', '2025-06-16 02:22:00', 793, 0, 0, 'bekasi selatan, pemeliharaan, penopingan', 'published', 'index', NULL, NULL, '2025-06-16 02:22:00', '2025-06-16 02:22:00', NULL),
('b37b9431-f27d-480c-b33d-c68f1d34e5ea', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pembersihan saluran sekunder perumahan pondok cikunir indah RT 10 RW 12 Kelurahan Jatibening Kecamat', 'pembersihan-saluran-sekunder-perumahan-pondok-cikunir-indah-rt-10-rw-12-kelurahan-jatibening-kecamatan-pondok-gede', 'pembersihan saluran sekunder perumahan pondok cikunir indah RT 10 RW 12 Kelurahan Jatibening Kecamat', '', 'images/5904562c47dd118ac3b79ca2e4a35a52.jpeg', '2024-01-23 10:01:00', 4191, 0, 0, 'pembersihan, jatibening, kelurahan', 'published', 'index', NULL, NULL, '2024-01-23 10:01:00', '2024-01-23 10:01:00', NULL),
('b3b3e2df-a5f4-493d-9fdc-60627a2ee46a', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Monitoring walikota bekasi  bersama kepala dinas bmsdakotabekasi di pembangunan crosing kali BSK', 'monitoring-walikota-bekasi--bersama-kepala-dinas-bmsdakotabekasi-di-pembangunan-crosing-kali-bsk', 'Monitoring walikota bekasi bersama kepala dinas bmsdakotabekasi di pembangunan crosing kali BSK', '', 'images/a8b17b5934231b5214ba5ee8fd00cf3b.jpeg', '2021-09-16 07:05:00', 2350, 0, 0, 'kota bekasi, walikota bekasi, bmsdakotabekasi', 'published', 'index', NULL, NULL, '2021-09-16 07:05:00', '2021-09-16 07:05:00', NULL),
('b5b42e69-bf16-4cdf-9ee3-14c8979f1927', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Perbaikan lampu PJU diwilayah rt.03 rw.06 kel.mustika jaya kec.mustika jaya', 'perbaikan-lampu-pju-diwilayah-rt.03-rw.06-kel.mustika-jaya-kec.mustika-jaya', 'Perbaikan lampu PJU diwilayah rt.03 rw.06 kel.mustika jaya kec.mustika jaya', '', 'images/813189791b15479f33be4dbc57c37863.jpg', '2021-09-07 01:46:00', 2995, 0, 0, 'mustika jaya, perbaikan, lampu', 'published', 'index', NULL, NULL, '2021-09-07 01:46:00', '2021-09-07 01:46:00', NULL),
('b6de1481-3f2b-4182-ac24-cc209834f821', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pemangkaskan pohon jalan raya narogong', 'pemangkaskan-pohon-jalan-raya-narogong', 'Pasca hujan deras dan angin kencang, Tim URC DBMSDA langsung meluncur ke Jl. Raya Narogong, Kecamatan Bantargebang untuk menangani pohon tumbang yang sempat menghambat lalu...', '<p>Pasca hujan deras dan angin kencang, Tim URC DBMSDA langsung meluncur ke Jl. Raya Narogong, Kecamatan Bantargebang untuk menangani pohon tumbang yang sempat menghambat lalu lintas.<br />\r\n<br />\r\nDahan dan batang pohon langsung dievakuasi agar jalanan kembali aman dilalui masyarakat. Himbauan bagi para pengendara: Tetap waspada dan berhati-hati di jalan, terutama saat cuaca ekstrem!</p>\r\n', 'images/5fc3aa61f3980b7d1178292346bce8dd.jpeg', '2026-04-13 02:28:00', 3432, 0, 1, 'bantargebang, evakuasi, langsung', 'published', 'index', NULL, NULL, '2026-04-13 02:28:00', '2026-04-13 02:28:00', NULL),
('b7c725f6-18df-4ff7-8a21-361a1eb02c4b', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Saluran sekunder perumahan vila taman Kartini RW 023  Kel margahayu Kec.bekasi timur', 'saluran-sekunder-perumahan-vila-taman-kartini-rw-023--kel-margahayu-kec.bekasi-timur', 'Saluran sekunder perumahan vila taman Kartini RW 023 Kel margahayu Kec.bekasi timur', '', 'images/6847ebb2f19eb5dc03d0bb34d1ad36b6.jpeg', '2023-11-17 07:08:00', 4279, 0, 0, 'bekasi timur, taman, margahayu', 'published', 'index', NULL, NULL, '2023-11-17 07:08:00', '2023-11-17 07:08:00', NULL),
('b7fbcc93-172f-4735-b8b2-d26ffe705d0c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'PENANGANAN GENANGAN JALAN JUANDA KECAMATAN BEKASI TIMUR', 'penanganan-genangan-jalan-juanda-kecamatan-bekasi-timur', 'PENANGANAN GENANGAN JALAN JUANDA KECAMATAN BEKASI TIMUR', '', 'images/b82e0a9d00082c555160bff15f20b950.jpeg', '2021-10-18 09:36:00', 514, 0, 0, 'bekasi timur, penanganan, kecamatan', 'published', 'index', NULL, NULL, '2021-10-18 09:36:00', '2021-10-18 09:36:00', NULL),
('bb009917-3029-47a2-8f35-a34936837cbc', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pemangkasan di Jalan Ir.H.Juanda Kecamatan Bekasi Timur', 'pemangkasan-di-jalan-ir.h.juanda-kecamatan-bekasi-timur', 'pemangkasan di Jalan Ir.H.Juanda Kecamatan Bekasi Timur', '', 'images/c325e17e5c1270e88bdc383c04d98860.jpg', '2024-01-16 11:16:00', 2217, 0, 1, 'bekasi timur, pemangkasan, kecamatan', 'published', 'index', NULL, NULL, '2024-01-16 11:16:00', '2024-01-16 11:16:00', NULL),
('bb2141ae-3dae-4e61-a493-d65a80c836de', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Tim Pematusan Giat Lanjutan Normalosasi saluran tersier Jl.Raya Mustikajaya Depan Pintu,Mutiara Gadi', 'tim-pematusan-giat-lanjutan-normalosasi-saluran-tersier-jl.raya-mustikajaya-depan-pintu,mutiara-gading-timur', 'Tim Pematusan Giat Lanjutan Normalosasi saluran tersier Jl.Raya Mustikajaya Depan Pintu,Mutiara Gadi', '', 'images/e9390aa90fc10914a45af114fce84b5a.jpg', '2023-11-07 07:07:00', 1139, 0, 0, 'mustikajaya, normalosasi, pematusan', 'published', 'index', NULL, NULL, '2023-11-07 07:07:00', '2023-11-07 07:07:00', NULL),
('bb5b6deb-2bfb-46a5-ac22-f1fdad139b63', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat tim URC Bidang SDA penanganan genangan di wilayah rt.02,06 rw.01 kelurahan durenjaya kecamatan ', 'giat-tim-urc-bidang-sda-penanganan-genangan-di-wilayah-rt.02,06-rw.01-kelurahan-durenjaya-kecamatan-bekasi-timur', 'Giat tim URC Bidang SDA penanganan genangan di wilayah rt.02,06 rw.01 kelurahan durenjaya kecamatan', '', 'images/7eb9fb212b025cb438360900589e922f.jpeg', '2022-01-19 08:32:00', 3227, 0, 1, 'penanganan, durenjaya, kecamatan', 'published', 'index', NULL, NULL, '2022-01-19 08:32:00', '2022-01-19 08:32:00', NULL),
('bb757812-f4e6-49ea-a7c1-640ca4008a9e', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Serah terima jabatan pejabat eselon IV di lingkungan @bmsdakotabekasi', 'serah-terima-jabatan-pejabat-eselon-iv-di-lingkungan-@bmsdakotabekasi', 'Serah terima jabatan pejabat eselon IV di lingkungan @bmsdakotabekasi', '<h2>Serah terima jabatan pejabat eselon IV di lingkungan @bmsdakotabekasi</h2>\r\n', 'images/d7219718bb4339af4134ad1bd409e232.jpg', '2020-11-10 23:30:00', 1302, 0, 0, 'serah terima, jabatan, bmsdakotabekasi', 'published', 'index', NULL, NULL, '2020-11-10 23:30:00', '2020-11-10 23:30:00', NULL),
('bc720167-cbc2-4aba-aad9-3efe4e482126', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'penyerahan pompa Air di wilayah Rt 01 Rw 01 kelurahan Jati cempaka kecamatan Pondok gede', 'penyerahan-pompa-air-di-wilayah-rt-01-rw-01-kelurahan-jati-cempaka-kecamatan-pondok-gede', 'penyerahan pompa Air di wilayah Rt 01 Rw 01 kelurahan Jati cempaka kecamatan Pondok gede', '', 'images/9b8e1487a4dc20786f79e116bc2996e5.jpeg', '2024-01-05 09:37:00', 4305, 0, 1, 'pondok gede, penyerahan, kecamatan', 'published', 'index', NULL, NULL, '2024-01-05 09:37:00', '2024-01-05 09:37:00', NULL),
('bd742c3a-9104-48d6-ae3d-c3f4a3c7b917', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Kunjungan Kerja DPRD-Kabupaten Pandeglang', 'kunjungan-kerja-dprd-kabupaten-pandeglang', 'Kota Bekasi, 19 September 2025 - Dinas Bina Marga dan Sumber Daya Air (DBMSDA) Kota Bekasi menjadi tujuan kunjungan kerja dari DPRD-Kabupaten Pandeglang. Kunjungan tersebut...', '<p>Kota Bekasi, 19 September 2025 - Dinas Bina Marga dan Sumber Daya Air (DBMSDA) Kota Bekasi menjadi tujuan kunjungan kerja dari DPRD-Kabupaten Pandeglang. Kunjungan tersebut diterima oleh Bapak Toni Purwantoro S.E., M.A.. Kepala Bidang Prasana Ruang Jalan dan Taman.<br />\r\n<br />\r\nDBMSDA Kota Bekasi menyambut baik kunjungan ini sebagai bentuk apresiasi terhadap kinerja dan pengalaman mereka dalam penyelenggaraan pemerintahan daerah.<br />\r\n<br />\r\nKabupaten Pandeglang melakukan kunjungan kerja dengan fokus pada penertiban kabel optik telepon kota bekasi. Dalam kunjungan ini, tim dari Kabupaten Pandeglang mempelajari bagaimana DBMSDA merencanakan dan menertibkan, termasuk koordinasi dalam penertiban.<br />\r\n<br />\r\nToni Purwantoro mengatakan bahwa kunjungan kerja ini diharapkan dapat memberikan dampak bagi kabupaten pandeglang dalam masalah penanangan penertiban kabel optik.<br />\r\n<br />\r\nAcara ditutup dengan ramah tamah dan sesi foto bersama seluruh tamu yang hadir. (dms)</p>\r\n', 'images/9fbb80a64f26ef160bcc000fdc7b6de0.jpg', '2025-09-19 09:21:00', 4048, 0, 0, 'kota bekasi, taman, kunjungan', 'published', 'index', NULL, NULL, '2025-09-19 09:21:00', '2025-09-19 09:21:00', NULL),
('bdbcc361-4a4e-4c82-848f-be31cd12e00a', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'INDEKS KEPUASAN MASYARAKAT (IKM) DINAS BINA MARGA DAN SUMBER DAYA AIR KOTA BEKASI	PEMERINTAH KOTA BE', 'indeks-kepuasan-masyarakat-(ikm)-dinas-bina-marga-dan-sumber-daya-air-kota-bekasipemerintah-kota-bekasi-semester-i-tahun-2021', 'INDEKS KEPUASAN MASYARAKAT (IKM) DINAS BINA MARGA DAN SUMBER DAYA AIR KOTA BEKASI PEMERINTAH KOTA BE', '', 'images/8a139912be190461c828ab991a314108.jpg', '2021-07-21 06:59:00', 498, 0, 0, 'kota bekasi, kota, masyarakat', 'published', 'index', NULL, NULL, '2021-07-21 06:59:00', '2021-07-21 06:59:00', NULL),
('beaac5b9-5d0b-46ac-aedc-4819198e4e00', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Jln. Baru I Gusti Nguray Ray, Kranji Bekasi Barat #. Panel depan perum Violet perbaikan Jaringan dan', 'jln.-baru-i-gusti-nguray-ray,-kranji-bekasi-barat-#.-panel-depan-perum-violet-perbaikan-jaringan-dan', 'Jln. Baru I Gusti Nguray Ray, Kranji Bekasi Barat #. Panel depan perum Violet perbaikan Jaringan dan komponen', '<p>Jln. Baru I Gusti Nguray Ray, Kranji Bekasi Barat #. Panel depan perum Violet perbaikan Jaringan dan komponen</p>\r\n', 'images/191bdb299d720eccde28249168eb8c2a.jpg', '2020-11-10 23:11:00', 2619, 0, 0, 'bekasi barat, kranji, perbaikan', 'published', 'index', NULL, NULL, '2020-11-10 23:11:00', '2020-11-10 23:11:00', NULL),
('befdfdf3-4547-4d2c-9cda-da870ce2d8fc', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pemangkasan pohon Jl Wibawa Mukti  Wil Rw 04 Kel  Jati Sari Kec  Jati Asih', 'pemangkasan-pohon-jl-wibawa-mukti--wil-rw-04-kel--jati-sari-kec--jati-asih', 'pemangkasan pohon Jl Wibawa Mukti Wil Rw 04 Kel Jati Sari Kec Jati Asih', '', 'images/57df52f161716bb46fe74f8993d99523.jpeg', '2025-08-11 03:34:00', 2755, 0, 0, 'jati asih, jati, pemangkasan', 'published', 'index', NULL, NULL, '2025-08-11 03:34:00', '2025-08-11 03:34:00', NULL),
('bf6b7a3b-5de6-43f2-93a7-0a4ad9e495b7', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Perbaikan lampu PJU JL.Dewi Sartika kecamatan bekasi timur', 'perbaikan-lampu-pju-jl.dewi-sartika-kecamatan-bekasi-timur', 'Perbaikan lampu PJU JL.Dewi Sartika kecamatan bekasi timur', '', 'images/aca265cef6a848ce9c8d03ff3ae55075.jpeg', '2021-12-21 09:24:00', 2846, 0, 0, 'bekasi timur, perbaikan, lampu', 'published', 'index', NULL, NULL, '2021-12-21 09:24:00', '2021-12-21 09:24:00', NULL),
('bfddcc82-b3e4-4cd2-a687-d57dbe903ed6', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pelajari Ketentuan Disiplin PNS Terbaru Melalui PP No. 94/2021', 'pelajari-ketentuan-disiplin-pns-terbaru-melalui-pp-no.-94/2021', 'JAKARTA – Pegawai negeri sipil (PNS) kini memiliki regulasi terbaru mengenai disiplin PNS. Ketentuan mengenai larangan, kewajiban, serta hukuman disiplin bagi PNS termuat dalam...', '<p>JAKARTA &ndash; Pegawai negeri sipil (PNS) kini memiliki regulasi terbaru mengenai disiplin PNS. Ketentuan mengenai larangan, kewajiban, serta hukuman disiplin bagi PNS termuat dalam PP No. 94/2021 tentang Disiplin PNS.</p>\r\n\r\n<p>Beleid ini menegaskan bahwa PNS diharuskan menaati kewajiban serta tidak melakukan larangan sebagaimana tercantum dalam peraturan ini. Adapun kewajiban bagi PNS tersebut disebutkan dalam Pasal 3 sebanyak delapan kewajiban dan sembilan kewajiban yang terdapat pada Pasal 4. Sedangkan, terdapat 14 larangan yang harus dihindari oleh PNS sebagaimana tercantum dalam Pasal 5.</p>\r\n\r\n<p>&ldquo;Bagi PNS yang tidak menaati ketentuan sebagaimana dimaksud dalam Pasal 3 sampai dengan Pasal 5 dijatuhi hukuman disiplin,&rdquo; bunyi Pasal 7 dalam kebijakan ini.</p>\r\n\r\n<p>Gagalnya PNS dalam menjalani kewajiban serta melanggar larangan yang telah diatur tersebut akan menyebabkan yang bersangkutan menerima hukuman disiplin. Adapun tingkatan dan jenis hukuman disiplin disebutkan dalam Pasal 8.</p>\r\n\r\n<p>Tingkat hukuman disiplin terbagi menjadi tiga, yakni hukuman disiplin ringan, sedang, hingga berat. Untuk jenis hukuman disiplin, terbagi berdasarkan tingkatan.</p>\r\n\r\n<p>Bagi hukuman disiplin ringan, jenis hukumannya terdiri atas teguran lisan, teguran tertulis, serta pernyataan tidak puas secara tertulis. Untuk tingkat hukuman disiplin sedang, hukuman yang diberikan adalah pemotongan tunjangan kinerja sebesar 25 persen yang terbagi menjadi tiga kurun waktu, yakni selama 6 bulan, 9 bulan, dan 12 bulan.</p>\r\n\r\n<p>Hukuman disiplin berat juga terbagi tiga. Pertama, penurunan jabatan setingkat lebih rendah selama 12 bulan. Kedua, pembebasan dari jabatannya menjadi jabatan pelaksana selama 12 bulan. Ketiga, pemberhentian dengan hormat tidak atas permintaan sendiri sebagai PNS.</p>\r\n\r\n<p>Kebijakan ini salah satunya mengatur PNS terkait dengan disiplin masuk kerja dan juga jam kerja. Pelanggaran atas kewajiban yang tercantum dalam Pasal 4 huruf f ini dapat dikenakan tiga tingkatan hukuman disiplin.</p>\r\n\r\n<p>PNS yang tidak masuk kerja tanpa alasan selama tiga hingga sepuluh hari termasuk pelanggaran tingkat ringan. Hukuman yang dijatuhkan berupa:<br />\r\n&nbsp;1. teguran lisan bagi PNS yang tidak masuk kerja tanpa alasan yang sah secara kumulatif selama tiga hari kerja dalam satu tahun;&nbsp;<br />\r\n2. teguran tertulis bagi PNS yang tidak masuk kerja tanpa alasan yang sah secara kumulatif selama 4-6 hari kerja dalam satu tahun; dan&nbsp;<br />\r\n3. pernyataan tidak puas secara tertulis bagi PNS yang tidak masuk kerja tanpa alasan yang sah secara kumulatif selama 7-10 hari kerja dalam satu tahun.</p>\r\n\r\n<p>Sementara PNS yang tidak masuk kerja tanpa alasan selama sebelas hingga 20 hari termasuk pelanggaran tingkat sedang, maka PNS bersangkutan dapat menerima hukuman disiplin sebagai berikut:<br />\r\n1. pemotongan tukin sebesar 25 persen selama 6 bulan bagi PNS yang tidak masuk kerja tanpa alasan yang sah secara kumulatif selama 11-13 hari kerja dalam satu tahun;&nbsp;<br />\r\n2. pemotongan tukin sebesar 25 persen selama 9 bulan bagi PNS yang tidak masuk kerja tanpa alasan yang sah secara kumulatif selama 14-16 hari kerja dalam satu tahun;&nbsp;<br />\r\n3. pemotongan tukin sebesar 25 persen selama 12 bulan bagi PNS yang tidak masuk kerja tanpa alasan yang sah secara kumulatif selama 17-20 (dua puluh) hari kerja dalam satu tahun.</p>\r\n\r\n<p>Sedangkan, apabila pelanggarannya termasuk kategori berat, hukumannya berupa:<br />\r\n1. penurunan jabatan setingkat lebih rendah selama 12 bulan bagi PNS yang tidak masuk kerja tanpa alasan yang sah secara kumulatif selama 21-24 hari kerja dalam satu tahun;&nbsp;<br />\r\n2. pembebasan dari jabatannya menjadi jabatan pelaksana selama 12 bulan bagi PNS yang tidak masuk kerja tanpa alasan yang sah secara kumulatif selama 25- 27 hari kerja dalam satu tahun;&nbsp;<br />\r\n3. pemberhentian dengan hormat tidak atas permintaan sendiri sebagai PNS bagi PNS yang tidak masuk kerja tanpa alasan yang sah secara kumulatif selama 28 hari kerja atau lebih dalam satu tahun; dan<br />\r\n&nbsp;4. pemberhentian dengan hormat tidak atas permintaan sendiri sebagai PNS bagi PNS yang tidak masuk kerja tanpa alasan yang sah secara terus menerus selama 10 hari kerja dan diberhentikan pembayaran gajinya sejak bulan berikutnya.</p>\r\n\r\n<p>Di dalam PP No. 94/2021 ini juga mengatur hukuman disiplin atas pelanggaran netralitas, dimana dalam Pasal 5 huruf n, PNS dilarang memberikan dukungan kepada peserta pemilu dan pilkada. Pelanggaran akan larangan tersebut akan diberikan hukuman disiplin sedang hingga berat.</p>\r\n\r\n<p>Hukuman disiplin sedang akan diberikan bagi PNS yang memberikan dukungan dengan mengikuti kampanye dan dengan menggunakan atribut partai atau PNS. Sedangkan hukuman disiplin diberikan bagi PNS yang memberikan dukungan sesuai yang disebutkan pada Pasal 5 huruf n angka 3-7.</p>\r\n\r\n<p>Selain itu, salah satu yang juga diatur dalam kebijakan ini adalah terkait dengan pemberian layanan kepada masyarakat dimana PNS dilarang untuk melakukan pungutan di luar ketentuan, sebagaimana tercantum dalam Pasal 5 huruf g. Bagi PNS yang melakukan pungutan diluar ketentuan yang berlaku, akan mendapatkan hukuman disiplin sedang jika berdampak negatif pada unit kerja dan/atau instansi yang bersangkutan, serta hukuman disiplin berat juga berdampak negatif negara dan/atau pemerintah.</p>\r\n\r\n<p>PP yang ditandatangani oleh Presiden Joko Widodo ini juga memuat ketentuan mengenai pejabat yang berwenang memberikan hukuman disiplin kepada PNS yang melanggar kewajiban dan larangan. Kemudian, juga memuat secara rinci mengenai tata cara pemeriksaan, penjatuhan, dan penyampaian keputusan hukuman disiplin. Selain itu, termaktub dalam PP ini adalah mengenai berlakunya hukuman disiplin serta pendokumentasian keputusan hukuman disiplin.</p>\r\n\r\n<p>Bukan hanya bagi PNS, ketentuan yang dimuat dalam PP ini juga berlaku secara mutatis mutandis bagi CPNS. Disebutkan juga bahwa ketentuan pelaksanaan dari PP ini akan diatur lebih lanjut oleh Peraturan Badan Kepegawaian Negara.</p>\r\n\r\n<p>Kebijakan mengenai disiplin PNS ini mulai berlaku sejak diundangkan pada 31 Agustus 2021. Dengan keluarnya kebijakan ini maka PP No. 53/2010 tentang Disiplin PNS dinyatakan dicabut, namun ketentuan mengenai jenis hukuman disiplin sedang dalam PP tersebut masih dinyatakan berlaku hingga PP mengenai Gaji dan Tunjangan berlaku, sebagaimana tertera di Pasal 42.</p>\r\n\r\n<p>Adapun PP ini diterbitkan dalam rangka melaksanakan ketentuan dalam UU No. 5/2014 tentang Aparatur Sipil Negara mengenai PNS wajib mematuhi ketentuan disiplin PNS untuk menjamin terpeliharanya tata tertib dalam kelancaran pelaksanaan tugas. Selain itu, juga untuk mewujudkan PNS yang berintegritas moral, profesional, dan akuntabel serta mendorong PNS lebih produktif, maka diperlukan peraturan disiplin PNS sebagai pedoman.</p>\r\n\r\n<p>Untuk memahami lebih lanjut mengenai pengaturan disiplin PNS, PP No. 94/2021 dapat diakses di JDIH Kementerian PANRB melalui tautan: https://jdih.menpan.go.id/puu-1286-Peraturan%20Pemerintah.html (ald/HUMAS MENPANRB)</p>\r\n', 'images/2caad8a258fb0f9f22a84f5debbd13df.jpg', '2021-09-24 08:49:00', 4262, 0, 0, 'jabatan, disiplin, hukuman', 'published', 'index', NULL, NULL, '2021-09-24 08:49:00', '2021-09-24 08:49:00', NULL),
('c0676ca8-b13f-45e9-a300-2f0d2e99901e', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Apel pagi dan berdoa tim pematusan sebelum mengawali aktifitas di pagi hari ini.', 'apel-pagi-dan-berdoa-tim-pematusan-sebelum-mengawali-aktifitas-di-pagi-hari-ini.', 'Apel pagi dan berdoa tim pematusan sebelum mengawali aktifitas di pagi hari ini.', '', 'images/cb34ff1ea3cb2e7f598b3eb8f5312aa3.jpeg', '2021-11-08 02:51:00', 1058, 1, 0, 'pagi, aktifitas, mengawali', 'published', 'index', NULL, NULL, '2021-11-08 02:51:00', '2021-11-08 02:51:00', NULL),
('c1735367-28fc-45f0-a893-bca38b15722e', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Kunjungan Kerja DPRD Kabupaten Pringsewu terkait Pembahasan Pembangunan dan Pengelolaan Saluran Untuk Pencegahan Banjir.', 'kunjungan-kerja-dprd-kabupaten-pringsewu-terkait-pembahasan-pembangunan-dan-pengelolaan-saluran-untuk-pencegahan-banjir.', 'Kunjungan Kerja DPRD Kabupaten Pringsewu terkait Pembahasan Pembangunan dan Pengelolaan Saluran Untuk Pencegahan Banjir.', '', 'images/8f6d8daa5484ff417745e560bc322772.jpeg', '2025-07-25 07:47:00', 1346, 0, 0, 'pembangunan, pengelolaan, pembahasan', 'published', 'index', NULL, NULL, '2025-07-25 07:47:00', '2025-07-25 07:47:00', NULL),
('c268cede-b0ea-4501-96d0-9059983a5b9b', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemerintah Kota Bekasi mulai tanggal 1 April 2022 untuk program Layanan Kesehatan Masyarakat Berbasi', 'pemerintah-kota-bekasi-mulai-tanggal-1-april-2022-untuk-program-layanan-kesehatan-masyarakat-berbasis-nik-(lkm-nik)-tetap-berjalan.', 'Pemerintah Kota Bekasi mulai tanggal 1 April 2022 untuk program Layanan Kesehatan Masyarakat Berbasis NIK (LKM-NIK) tetap berjalan. Untuk layanan peserta LKM difokuskan di...', '<p>Pemerintah Kota Bekasi mulai tanggal 1 April 2022 untuk program Layanan Kesehatan Masyarakat Berbasis NIK (LKM-NIK) tetap berjalan. Untuk layanan peserta LKM difokuskan di Rumah Sakit Pemerintah guna mengoptimalkan fungsi Rumah Sakit Pemerintah.<br />\r\nRumah Sakit di Kota Bekasi :<br />\r\n1.&nbsp;&nbsp; &nbsp;RS Chasbullah Abdul Madjid Kota Bekasi;<br />\r\n2.&nbsp;&nbsp; &nbsp;RSUD Kelas D Pondok Gede<br />\r\n3.&nbsp;&nbsp; &nbsp;RSUD Kelas D Bantar Gebang<br />\r\n4.&nbsp;&nbsp; &nbsp;RSUD Kelas D Jati Sampurna<br />\r\n5.&nbsp;&nbsp; &nbsp;RSUD Kelas D Bekasi Utara</p>\r\n\r\n<p>Sasaran LKM NIK: &nbsp;<br />\r\nMasyarakat Kota Bekasi yang tidak mempunyai jaminan layanan kesehatan.</p>\r\n\r\n<p>Untuk Pelayanan kasus-kasus khusus dan kasus ODGJ dilakukan di RSUD di luar Kota Bekasi yaitu :<br />\r\n1.&nbsp;&nbsp; &nbsp;RSCM Jakarta<br />\r\n2.&nbsp;&nbsp; &nbsp;RSJP Harapan Kita Jakarta<br />\r\n3.&nbsp;&nbsp; &nbsp;RS Jiwa dr Soeharto Heerdjan Jakarta<br />\r\n4.&nbsp;&nbsp; &nbsp;RS &nbsp;dr. H. Marzoeki Mahdi Bogor</p>\r\n\r\n<p>Dasar Hukum :<br />\r\n1.&nbsp;&nbsp; &nbsp;Peraturan Presiden Nomor 82 Tahun 2018 tentang Jaminan Kesehatan pasal 102 yang berbunyi : &quot;Pemerintah Daerah yang menyelenggarakan jaminan kesehatan daerah wajib mengintegrasikan kedalam program Jaminan Kesehatan yang diselenggarakan oleh BPJS Kesehatan&quot;&nbsp;<br />\r\n2.&nbsp;&nbsp; &nbsp;Instruksi Presiden Nomor 1 Tahun 2022 tentang Optimalisasi &nbsp;Pelaksanaan Program Jaminan Kesehatan Nasional</p>\r\n\r\n<p>Berdasarkan aturan diatas pemerintah Kota Bekasi akan mengintegrasikan kepesertaan pelayanan jaminan kesehatan LKM NIK ke dalam Program Jaminan Kesehatan Nasional secara bertahap.&nbsp;</p>\r\n\r\n<p>Sumber: PPID Dinkes Kota Bekasi</p>\r\n', 'images/14bdbfb59e1e4e52579cfdefdc33a2d7.jpeg', '2022-03-25 09:26:00', 4510, 0, 0, 'bekasi utara, kota bekasi, pondok gede', 'published', 'index', NULL, NULL, '2022-03-25 09:26:00', '2022-03-25 09:26:00', NULL),
('c317c35e-97d6-4fc4-ae7b-a232672080ed', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'giat pematusan urc pengangkatan samampah kali kapuk  samping PT logos bersama tim kata  Kel.pejuang Kec.medan Satria', 'giat-pematusan-urc-pengangkatan-samampah-kali-kapuk--samping-pt-logos-bersama-tim-kata--kel.pejuang-kec.medan-satria', 'giat pematusan urc pengangkatan samampah kali kapuk samping PT logos bersama tim kata Kel.pejuang Kec.medan Satria', '', 'images/9d0c14ddc7b11f5e4f21e6d8c64cc0b1.jpeg', '2025-07-07 04:00:00', 838, 1, 0, 'medan satria, pengangkatan, pematusan', 'published', 'index', NULL, NULL, '2025-07-07 04:00:00', '2025-07-07 04:00:00', NULL),
('c34fc119-7bc7-42ff-9058-8e282d7a70f5', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Satu Padu Bangun Budaya Anti Korupsi  Selamat Hari Anti Korupsi Sedunia 2021', 'satu-padu-bangun-budaya-anti-korupsi--selamat-hari-anti-korupsi-sedunia-2021', 'Satu Padu Bangun Budaya Anti Korupsi Selamat Hari Anti Korupsi Sedunia 2021', '', 'images/c0899a50fcb96e8e2122eeec603920d0.jpg', '2021-12-09 06:01:00', 4207, 0, 1, 'korupsi, anti, sedunia', 'published', 'index', NULL, NULL, '2021-12-09 06:01:00', '2021-12-09 06:01:00', NULL),
('c64ffd9d-2a42-4d56-b9d2-9fd2a9e283b8', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Rapat pembahasan pengembalian kondisi jalan di ruas Jl I Gusti Ngurah Rai dan Jl M Hasibuan pada jalur distribusi SPAM Jatiluhur 1 yg di kelola oleh PT. Wika Tirta Jaya Jatiluhur.', 'rapat-pembahasan-pengembalian-kondisi-jalan-di-ruas-jl-i-gusti-ngurah-rai-dan-jl-m-hasibuan-pada-jalur-distribusi-spam-jatiluhur-1-yg-di-kelola-oleh-pt.-wika-tirta-jaya-jatiluhur.', 'Rapat pembahasan pengembalian kondisi jalan di ruas Jl I Gusti Ngurah Rai dan Jl M Hasibuan pada jalur distribusi SPAM Jatiluhur 1 yg di kelola oleh PT. Wika Tirta Jaya...', '<p>Rapat pembahasan pengembalian kondisi jalan di ruas Jl I Gusti Ngurah Rai dan Jl M Hasibuan pada jalur distribusi SPAM Jatiluhur 1 yg di kelola oleh PT. Wika Tirta Jaya Jatiluhur.<br />\r\n<br />\r\nBahwa berkenaan dengan monitoring tim BMSDA dan aduan masyarakat terkait pengembalian kondisi jalan, PT. WTJJ selaku pengelola jalur distribusi SPAM di ruas Jl I gusti ngurah rai akan melakukan perbaikan jalan yang rusak dengan menggunakan rigid pavement yang dilaksanakan segera dalam waktu dekat.</p>\r\n', 'images/44f730e361f4031e0f2ddd22c533ae3e.jpeg', '2025-07-09 09:42:00', 104, 0, 0, 'perbaikan, pengembalian, distribusi', 'published', 'index', NULL, NULL, '2025-07-09 09:42:00', '2025-07-09 09:42:00', NULL),
('c74dd971-b8f1-4b5f-a357-9e76e4d0d0b3', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'normalisasi saluran di Jalan M. Yamin Pasar Baru, Duren Jaya, Bekasi Timur', 'normalisasi-saluran-di-jalan-m.-yamin-pasar-baru,-duren-jaya,-bekasi-timur', 'Pemeliharaan dan peningkatan fungsi saluran terus dilakukan untuk mendukung kelancaran aliran air di Kota Bekasi. Dinas BMSDA melaksanakan normalisasi saluran di Jalan M. Yamin...', '<p>Pemeliharaan dan peningkatan fungsi saluran terus dilakukan untuk mendukung kelancaran aliran air di Kota Bekasi.<br />\r\n<br />\r\nDinas BMSDA melaksanakan normalisasi saluran di Jalan M. Yamin Pasar Baru, Duren Jaya, Bekasi Timur, dengan melakukan pembongkaran dan pembersihan saluran dari material yang menghambat aliran.<br />\r\n<br />\r\nLangkah ini menjadi bagian dari upaya menjaga kondisi saluran agar dapat berfungsi secara optimal.<br />\r\n&nbsp;</p>\r\n', 'images/22970d2474779712356cf6a15414d997.jpeg', '2026-09-07 03:40:00', 2836, 0, 0, 'bekasi timur, kota bekasi, pemeliharaan', 'published', 'index', NULL, NULL, '2026-09-07 03:40:00', '2026-09-07 03:40:00', NULL),
('c916d7c4-ad52-4f65-8008-06f040037956', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Rapat koordinasi rencana pelebaran jalan sisi selatan saluran kalimalang', 'rapat-koordinasi-rencana-pelebaran-jalan-sisi-selatan-saluran-kalimalang', 'Rapat koordinasi rencana pelebaran jalan sisi selatan saluran kalimalang (sisi gerbang tol jakasampurna) arah jakarta di ruang rapat sekda kota bekasi. Dihadiri oleh unsur PJT...', '<p>Rapat koordinasi rencana pelebaran jalan sisi selatan saluran kalimalang (sisi gerbang tol jakasampurna) arah jakarta di ruang rapat sekda kota bekasi.<br />\r\n<br />\r\nDihadiri oleh unsur PJT II, BBWS Citarum, Distaru, Dishub, Satpol PP dan Kecamatan Bekasi Selatan.</p>\r\n', 'images/88523da3c926870ca45750d2a3552c07.jpeg', '2023-12-14 10:35:00', 471, 0, 0, 'bekasi selatan, kota bekasi, selatan', 'published', 'index', NULL, NULL, '2023-12-14 10:35:00', '2023-12-14 10:35:00', NULL),
('c963c413-384a-49fd-a7db-5b34dd2a97ab', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Sosialisasi Kawasan Tanpa Rokok dan Deteksi Dini Penyakit Tidak Menular dan Kesehatan Jiwa', 'sosialisasi-kawasan-tanpa-rokok-dan-deteksi-dini-penyakit-tidak-menular-dan-kesehatan-jiwa', 'Aparatur DBMSDA Melaksanakan Sosialisasi Kawasan Tanpa Rokok dan Deteksi Dini Penyakit Tidak Menular dan Kesehatan Jiwa oleh Puskesmas Sepanjang Jaya di Ruang Rapat DBMSDA', '<p>Aparatur DBMSDA Melaksanakan Sosialisasi Kawasan Tanpa Rokok dan Deteksi Dini Penyakit Tidak Menular dan Kesehatan Jiwa oleh Puskesmas Sepanjang Jaya di Ruang Rapat DBMSDA</p>\r\n', 'images/3ebc3b783c0ba689b9a99edebf1fd4e5.jpeg', '2025-06-13 06:58:00', 1619, 0, 0, 'dbmsda, melaksanakan, sosialisasi', 'published', 'index', NULL, NULL, '2025-06-13 06:58:00', '2025-06-13 06:58:00', NULL),
('ca3c2e16-1004-45e3-933b-a05210c907c4', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemangkasan pohon di jalan juanda simpang jalan dewi sartika', 'pemangkasan-pohon-di-jalan-juanda-simpang-jalan-dewi-sartika', 'Pemangkasan pohon di jalan juanda simpang jalan dewi sartika', '', 'images/8879de73dd3d66e68ac17611dcd8f828.jpeg', '2021-12-13 09:51:00', 3452, 0, 0, 'pemangkasan, sartika, simpang', 'published', 'index', NULL, NULL, '2021-12-13 09:51:00', '2021-12-13 09:51:00', NULL);
INSERT INTO `articles` (`uuid`, `user_uuid`, `category_uuid`, `title`, `slug`, `excerpt`, `content`, `featured_image`, `scheduled_at`, `views`, `is_featured`, `is_popular`, `tagging`, `status`, `search_engine`, `link`, `video`, `created_at`, `updated_at`, `deleted_at`) VALUES
('cbbb30ca-cff8-4299-88a3-6f15e55436ae', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat tim pematusan pembersihan Polder pengasinan kecamatan rawalumbu', 'giat-tim-pematusan-pembersihan-polder-pengasinan-kecamatan-rawalumbu', 'Giat tim pematusan pembersihan Polder pengasinan kecamatan rawalumbu', '', 'images/c34d3ecd3a4c6ed7ddc6f1874b5125bb.jpeg', '2021-12-01 10:47:00', 1487, 0, 0, 'rawalumbu, pengasinan, pembersihan', 'published', 'index', NULL, NULL, '2021-12-01 10:47:00', '2021-12-01 10:47:00', NULL),
('cdcdce4d-c5cb-4138-b1df-80c46992ca4c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'penyiraman taman median tengah Jalan Chairil Anwar Kec.Bekasi Timur', 'penyiraman-taman-median-tengah-jalan-chairil-anwar-kec.bekasi-timur', 'penyiraman taman median tengah Jalan Chairil Anwar Kec.Bekasi Timur', '', 'images/f03fe586c6ee13587f77c9b6da75e1ec.jpeg', '2025-07-04 09:45:00', 4563, 0, 0, 'bekasi timur, penyiraman, taman', 'published', 'index', NULL, NULL, '2025-07-04 09:45:00', '2025-07-04 09:45:00', NULL),
('ceac02e7-d979-4c6a-ae80-cf58053aaf05', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'giat Pinyiraman Taman Jalan Tawes Raya Kelurahan Kayuringin Kecamatan Bekasi Selatan', 'giat-pinyiraman-taman-jalan-tawes-raya-kelurahan-kayuringin-kecamatan-bekasi-selatan', 'giat Pinyiraman Taman Jalan Tawes Raya Kelurahan Kayuringin Kecamatan Bekasi Selatan', '', 'images/bc8fb17a1654340ab66dca59b04f7cd6.jpeg', '2024-01-15 10:18:00', 2332, 0, 0, 'bekasi selatan, taman, kayuringin', 'published', 'index', NULL, NULL, '2024-01-15 10:18:00', '2024-01-15 10:18:00', NULL),
('cfcb21ce-1da3-404d-b822-44a0a219374c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'MAKLUMAT PELAYANAN 2026', 'maklumat-pelayanan-2026', 'MAKLUMAT PELAYANAN 2026', '', 'images/4fbbb9e7308a797203b9c0a72fc53441.jpeg', '2026-07-13 08:12:00', 4806, 0, 0, 'pelayanan, maklumat', 'published', 'index', NULL, NULL, '2026-07-13 08:12:00', '2026-07-13 08:12:00', NULL),
('d0f6a890-5c70-4f26-bc0d-49b6a751828b', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'kegiatan tim pangkas 24 mei 2019 Mengerjakan di jl pramuka di depan asrama kodim0507 bekasi kel marg', 'kegiatan-tim-pangkas-24-mei-2019-mengerjakan-di-jl-pramuka-di-depan-asrama-kodim0507-bekasi-kel-marga-jaya', 'kegiatan tim pangkas 24 mei 2019 Mengerjakan di jl pramuka di depan asrama kodim0507 bekasi kel marga jaya', '<h2>kegiatan tim pangkas 24 mei 2019 Mengerjakan di jl pramuka di depan asrama kodim0507 bekasi kel marga jaya</h2>\r\n', 'images/ae90ca8e1c52d1ce05776a834798fd18.jpg', '2020-11-10 23:12:00', 242, 0, 1, 'marga jaya, pramuka, kodim', 'published', 'index', NULL, NULL, '2020-11-10 23:12:00', '2020-11-10 23:12:00', NULL),
('d193ce7a-c73c-4630-bb0a-81b6c88e816a', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pemangkasan di komplek vida', 'pemangkasan-di-komplek-vida', 'pemangkasan di komplek vida', '', 'images/4b0e405782d6a8b9d5580556b2833f03.jpeg', '2021-06-15 02:13:00', 3448, 1, 0, 'pemangkasan, komplek, vida', 'published', 'index', NULL, NULL, '2021-06-15 02:13:00', '2021-06-15 02:13:00', NULL),
('d19aac7a-0a59-4c22-9e9f-6f85d96cee1b', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'giat Tim pematusan di lokasi longsor kali cakung perbatasan kecamatan jatiasih dgn pondok melati.', 'giat-tim-pematusan-di-lokasi-longsor-kali-cakung-perbatasan-kecamatan-jatiasih-dgn-pondok-melati.', 'giat Tim pematusan di lokasi longsor kali cakung perbatasan kecamatan jatiasih dgn pondok melati.', '', 'images/c94881c8c991bd52ae93c3343210c753.jpeg', '2021-10-06 10:06:00', 2552, 0, 0, 'pondok melati, perbatasan, kecamatan', 'published', 'index', NULL, NULL, '2021-10-06 10:06:00', '2021-10-06 10:06:00', NULL),
('d250a244-9d89-4dd5-b8c3-741c4ada263c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pembahasan inventarisasi jembatan eksisting dalam rangka penataan taman pedestrian dan wisata air kawasan kalimalang', 'pembahasan-inventarisasi-jembatan-eksisting-dalam-rangka-penataan-taman-pedestrian-dan-wisata-air-kawasan-kalimalang', 'Hari ini sekretaris dinas bmsda Idi Sutanto memimpin rapat inventarisasi kepemilikan jembatan dan utilitas rksisting, serta rencana pemanfaatan sepadan saluran dan wisata air...', '<p>Hari ini sekretaris dinas bmsda Idi Sutanto memimpin rapat inventarisasi kepemilikan jembatan dan utilitas rksisting, serta rencana pemanfaatan sepadan saluran dan wisata air kalimalang.<br />\r\n<br />\r\nTurut hadir perwakilan dari Ditjen SDA Kementerian Pekerjaan Umum hingga pelaku usaha di kawasan tersebut<br />\r\n&nbsp;</p>\r\n', 'images/1d54cb7aad5ea8438f369e00df49879c.jpeg', '2025-07-18 08:55:00', 30, 0, 0, 'pekerjaan, inventarisasi, kementerian', 'published', 'index', NULL, NULL, '2025-07-18 08:55:00', '2025-07-18 08:55:00', NULL),
('d2904d79-4d86-4328-ad1a-30959b8f9407', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat timPematusan', 'giat-timpematusan', 'saluran sekunder irigasi rw.02 Kelurahan Perwira Kecamatan Bekasi Utara.', '<p>saluran sekunder irigasi rw.02 Kelurahan Perwira Kecamatan Bekasi Utara.</p>\r\n', 'images/0566b84a07601ac9975649a63cd966a8.jpeg', '2023-07-27 08:23:00', 3566, 0, 1, 'bekasi utara, kecamatan, kelurahan', 'published', 'index', NULL, NULL, '2023-07-27 08:23:00', '2023-07-27 08:23:00', NULL),
('d3364b65-68d6-40e7-8217-fa3fcb1c93dd', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'giat penyiraman Taman Median Jalan Igusti Ngurah Rai Kecamatan Bekasi Barat', 'giat-penyiraman-taman-median-jalan-igusti-ngurah-rai-kecamatan-bekasi-barat', 'giat penyiraman Taman Median Jalan Igusti Ngurah Rai Kecamatan Bekasi Barat', '', 'images/94dc1c7a777427dc80483e7b265f2f51.jpg', '2023-12-20 01:54:00', 2658, 0, 1, 'bekasi barat, penyiraman, taman', 'published', 'index', NULL, NULL, '2023-12-20 01:54:00', '2023-12-20 01:54:00', NULL),
('d372d715-76f9-4249-a36a-d1f86f724fd5', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Kunjungan kerja DPRD Bandung barat terkait penanganan sistem drainase di wilayah kota bekasi', 'kunjungan-kerja-dprd-bandung-barat-terkait-penanganan-sistem-drainase-di-wilayah-kota-bekasi', 'Kunjungan kerja DPRD Bandung barat terkait penanganan sistem drainase di wilayah kota bekasi', '', 'images/44828c78312d712f753b3aac06c2ce9c.jpeg', '2021-11-10 09:30:00', 1806, 0, 0, 'kota bekasi, penanganan, kunjungan', 'published', 'index', NULL, NULL, '2021-11-10 09:30:00', '2021-11-10 09:30:00', NULL),
('d3b153ec-7a83-449a-83de-db789886e797', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Penyiraman taman median tengah di jalan raya pengasinan kecamatan rawalumbu', 'penyiraman-taman-median-tengah-di-jalan-raya-pengasinan-kecamatan-rawalumbu', 'Penyiraman taman median tengah di jalan raya pengasinan kecamatan rawalumbu', '<h2>Penyiraman taman median tengah di jalan raya pengasinan kecamatan rawalumbu</h2>\r\n', 'images/78c46ca8ed24469ee001fac5f192bd56.jpg', '2020-11-10 23:33:00', 1594, 0, 1, 'rawalumbu, pengasinan, penyiraman', 'published', 'index', NULL, NULL, '2020-11-10 23:33:00', '2020-11-10 23:33:00', NULL),
('d3e55312-f479-426f-8d8a-987741f2f322', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Kegiatan Darmawanita Persatuan Kota Bekasi,dalamrangka Bakti sosial kepada Pegawai PHL Pematusan ( U', 'kegiatan-darmawanita-persatuan-kota-bekasi,dalamrangka-bakti-sosial-kepada-pegawai-phl-pematusan-(-uptd-pematusan-kota-bekasi)', 'Kegiatan Darmawanita Persatuan Kota Bekasi,dalamrangka Bakti sosial kepada Pegawai PHL Pematusan ( U', '', 'images/231c12846404a5d759af436022399866.jpeg', '2021-11-18 08:54:00', 1958, 0, 1, 'kota bekasi, kegiatan, dalamrangka', 'published', 'index', NULL, NULL, '2021-11-18 08:54:00', '2021-11-18 08:54:00', NULL),
('d41f7b93-8286-4743-ba88-cf2570b08c13', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'WAKIL WALIKOTA BEKASI PIMPIN APEL EVALUASI KINERJA 2021 DBMSDA', 'wakil-walikota-bekasi-pimpin-apel-evaluasi-kinerja-2021-dbmsda', '*WAKIL WALI KOTA BEKASI PIMPIN APEL EVALUASI KINERJA 2021 DBMSDA* KOTA BEKASI - Dalam rangka peningkatkan mutu pelayanan Pemerintah Kota Bekasi, Wakil Wali Kota Bekasi Tri...', '<p><br />\r\n*WAKIL WALI KOTA BEKASI PIMPIN APEL EVALUASI KINERJA 2021 DBMSDA*</p>\r\n\r\n<p>KOTA BEKASI - Dalam rangka peningkatkan mutu pelayanan Pemerintah Kota Bekasi, Wakil Wali Kota Bekasi Tri Adhianto pimpin apel evaluasi kinerja Dinas Bina Marga Sumber Daya Air dikantor (DBMSDA) dihalaman kantor BMSDA Kelurahan Margahayu Kecamatan Bekasi Timur, Selasa (28/12/2021).</p>\r\n\r\n<p>Turut hadir Kepala Dinas BMSDA Arif Maulana, para pejabat struktural dinas Bmsda, dan Seluruh petugas BMSDA, yang terdiri dari beberapa sub-bidang diantaranya, bidang Bina Marga, bidang Sumber daya Air, Bidang Perencanaan, bidang Penerangan Jalan Umum dan Taman.</p>\r\n\r\n<p>Dalam kesempatan apel pagi hari ini (28/12), pria yang kerap disapa Mas Tri menyampaikan apresiasi kepada Dinas BMSDA atas adanya perubahan dari segi meminimalisir banjir dan kesigapan secara responsif rekan-rekan DBMSDA terhadap pengaduan warga masyarakat.</p>\r\n\r\n<p>&quot;Pasca kejadian insiden banjir 2020 kita mulai terus bebenah, dari perbaikan tanggul, perbaikan drainase,&nbsp; membuat resapan air dilokasi potensi banjir, membuat folder air dan masih banyak lagi, saya sangat apresiasi betul kinerja dari rekan-rekan BMSDA,&quot; ucap Tri</p>\r\n\r\n<p>Tri juga mengatakan, dari semua yang dikerjakan memang belum semuanya teratasi secara maksimal, masih ada beberapa daerah yang masih mengalami banjir saat intensitas curah hujan tinggi dan debit air dikali meningkat.</p>\r\n\r\n<p>&quot;dari semuanya yang kita kerjakan, memang belum semua daerah terbebas dari banjir, kita masih terus bebenah, masih terus berproses, masih terus di evaluasi, dan semoga ditahun berikutnya warga Kota Bekasi dapat terbebas dari banjir,&quot; Tutup Tri Adhianto.</p>\r\n\r\n<p>wan</p>\r\n', 'images/98d35bfe1646cb1afaf284c3402bd953.jpg', '2021-12-28 10:35:00', 3348, 0, 0, 'bekasi timur, kota bekasi, perbaikan', 'published', 'index', NULL, NULL, '2021-12-28 10:35:00', '2021-12-28 10:35:00', NULL),
('d5616842-c141-421a-92f4-3fc9b16b7021', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat tim URC Bina Marga Pemeliharaan jalan Igusti Ngurahrai kecamatan bekasi barat', 'giat-tim-urc-bina-marga-pemeliharaan-jalan-igusti-ngurahrai-kecamatan-bekasi-barat', 'Giat tim URC Bina Marga Pemeliharaan jalan Igusti Ngurahrai kecamatan bekasi barat', '', 'images/414c63571309e76b3aed2c0ac1c8b1c6.jpeg', '2022-01-18 05:19:00', 4942, 0, 0, 'bekasi barat, pemeliharaan, kecamatan', 'published', 'index', NULL, NULL, '2022-01-18 05:19:00', '2022-01-18 05:19:00', NULL),
('d6c7c586-b727-4d12-8bc4-7b7caa20f387', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pembersihan dan perawatan taman cut mutia kecamatan bekasi timur', 'pembersihan-dan-perawatan-taman-cut-mutia-kecamatan-bekasi-timur', 'Pembersihan dan perawatan taman cut mutia kecamatan bekasi timur', '', 'images/a930e7a1b0e81bf23d2e3bcab962bc81.jpeg', '2022-01-14 03:26:00', 1693, 0, 0, 'bekasi timur, taman, pembersihan', 'published', 'index', NULL, NULL, '2022-01-14 03:26:00', '2022-01-14 03:26:00', NULL),
('d6d75aa4-077e-4148-8402-bc02d0849915', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', ' tim UPTD Pematusan dan tim UPTD Alatberat melanjutkan giat pembersihan Saluran Skunder Kali Abang T', 'tim-uptd-pematusan-dan-tim-uptd-alatberat-melanjutkan-giat-pembersihan-saluran-skunder-kali-abang-tengah-kel.kali-abang-tengah-kec.bekasi-utara', 'tim UPTD Pematusan dan tim UPTD Alatberat melanjutkan giat pembersihan Saluran Skunder Kali Abang T', '', 'images/41ccc900cd2411a9682f2a71eb401631.jpeg', '2024-01-31 09:40:00', 4838, 0, 1, 'uptd, melanjutkan, pembersihan', 'published', 'index', NULL, NULL, '2024-01-31 09:40:00', '2024-01-31 09:40:00', NULL),
('d8ca9b92-f851-48f6-9476-c7efa25404d6', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pemeliharaan Taman Kecapi Kelurahan Jatiwarna Kecamatan Pondok Melati', 'pemeliharaan-taman-kecapi-kelurahan-jatiwarna-kecamatan-pondok-melati', 'pemeliharaan Taman Kecapi Kelurahan Jatiwarna Kecamatan Pondok Melati', '', 'images/41e63d4742971ab3455ce2f5ce28107a.jpeg', '2023-12-11 10:15:00', 3121, 0, 0, 'pondok melati, pemeliharaan, taman', 'published', 'index', NULL, NULL, '2023-12-11 10:15:00', '2023-12-11 10:15:00', NULL),
('db074a23-ff9c-4512-941a-70d896713cac', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pelatihan dan Sertifikasi Tenaga Terampil Konstruksi Tahun 2023', 'pelatihan-dan-sertifikasi-tenaga-terampil-konstruksi-tahun-2023', 'Hari ini 100 pegawai Non ASN Dinas Bina Marga dan Sumber Daya Air Kota Bekasi mengikuti Kegiatan Pelatihan dan Sertifikasi Tenaga Terampil Konstruksi Tahun 2023, dilingkungan...', '<p>Hari ini 100 pegawai Non ASN Dinas Bina Marga dan Sumber Daya Air Kota Bekasi mengikuti Kegiatan Pelatihan dan Sertifikasi Tenaga Terampil Konstruksi Tahun 2023, dilingkungan Dinas BMSDA Kota Bekasi.<br />\r\n<br />\r\nKegiatan diawali dengan pembukaan yang dibuka secara langsung oleh Bapak H. Muhammad Solikhin S.SIT., M.M . Beliau mengatakan bahwa pelatihan kali ini dapat menjadi bekal bagi para pegawai pada saat pekerjaan kontruksi dan bekal untuk penerimaan ASN/PPPK. Beliau berpesan agar dapat di ikuti pelatihan ini dengan baik dan serius.<br />\r\n<br />\r\nDihadiri oleh Narasumber Ketua Lembaga Sertifikasi Profesi Asosiasi Tenaga Ahli Konstruksi Indonesia (LSP ATAKI), Bapak Apriyan Susanto, ST. MT , Perwakilan dari Program Studi Teknik SIpil Universitas Muhammadiyah Jakarta (UMJ), Direktur PT. Karya Cipta Konsultan Nusantara, Bapak Dr. Mohammad Imamuddin, ST. MT selaku Peyelenggara Pelatihan.<br />\r\n<br />\r\nTujuan Pelatihan tersedianya Aparatur DBMSDA Kota Bekasi berkualitas dan kompeten sebagai salah satu indikator dalam proses penyelenggaraan jalan dan jembatan, saluran drainase maupun fasilitas Prasarana Jalan di Kota Bekasi.</p>\r\n', 'images/a3149a9fb1b4e36b734cbe3e5e1d39ef.jpg', '2023-10-24 10:18:00', 156, 0, 1, 'kota bekasi, pekerjaan, kegiatan', 'published', 'index', NULL, NULL, '2023-10-24 10:18:00', '2023-10-24 10:18:00', NULL),
('dcbc158e-39a7-4255-8400-a0266fc79384', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Menindak lanjuti laporan dari RW 11-12 Villa Jatirasa Kecamatan Jatiasih untuk melakukan pengecekan ', 'menindak-lanjuti-laporan-dari-rw-11-12-villa-jatirasa-kecamatan-jatiasih-untuk-melakukan-pengecekan-pompa', 'Menindak lanjuti laporan dari RW 11-12 Villa Jatirasa Kecamatan Jatiasih untuk melakukan pengecekan', '', 'images/4b0c0093b1b873354a6d2f93a8f1c133.jpg', '2023-11-07 07:41:00', 464, 0, 0, 'pengecekan, kecamatan, melakukan', 'published', 'index', NULL, NULL, '2023-11-07 07:41:00', '2023-11-07 07:41:00', NULL),
('dcc4ab10-e8c7-4b0d-b993-e98dbbb98d88', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Tim URC Bina Marga pengecoran jalan inspeksi kalimalang kec.bekasi timur', 'giat-tim-urc-bina-marga-pengecoran-jalan-inspeksi-kalimalang-kec.bekasi-timur', 'Giat Tim URC Bina Marga pengecoran jalan inspeksi kalimalang kec.bekasi timur', '', 'images/e2906e3316366e78002ebe4992a01ccb.jpg', '2021-11-22 15:11:00', 3824, 0, 0, 'bekasi timur, kalimalang, pengecoran', 'published', 'index', NULL, NULL, '2021-11-22 15:11:00', '2021-11-22 15:11:00', NULL),
('dcef6b0e-8e74-4cba-87c5-39463d81ded6', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'PENYIRAMAN TAMAN FLY OVER RAWAPANJANG', 'penyiraman-taman-fly-over-rawapanjang', 'PENYIRAMAN TAMAN FLY OVER RAWAPANJANG', '', 'images/93f1505156a490c1192e45f3f77284ba.jpeg', '2021-11-29 02:30:00', 3183, 0, 0, 'penyiraman, taman, rawapanjang', 'published', 'index', NULL, NULL, '2021-11-29 02:30:00', '2021-11-29 02:30:00', NULL),
('e05f233a-02be-414b-95db-d8ce5fc4e8e5', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Dinas Bina Marga dan Sumber Daya Air (DBMSDA) Kota bekasi menggelar serah terima jabatan Kepala Dinas', 'dinas-bina-marga-dan-sumber-daya-air-dbmsda-kota-bekasi-menggelar-serah-terima-jabatan-kepala-dinas', 'Bekasi, 8 September 2025 Dinas Bina Marga dan Sumber Daya Air (DBMSDA) Kota bekasi menggelar serah terima jabatan Kepala Dinas Bina Marga dan Sumber Daya Air Kota Bekasi. Acara...', '<p>Bekasi, 8 September 2025</p>\r\n\r\n<p>Dinas Bina Marga dan Sumber Daya Air (DBMSDA) Kota bekasi menggelar serah terima jabatan Kepala Dinas Bina Marga dan Sumber Daya Air Kota Bekasi.</p>\r\n\r\n<p>Acara ini menandai penyerahan jabatan dari Kepala DBMSDA sebelumnya Drs. Aceng Solahudin, kepada Pelaksana Tugas (Plt) Kepala dinas yang baru Idi Sutanto, ST, MM, MT.</p>\r\n\r\n<p>Dalam sambutannya Aceng Solahudin menyampaikan apresiasi kepada seluruh ASN dilingkungan DBMSDA atas kerja samanya selama kepemimpinannya.</p>\r\n\r\n<p>Sementara itu, Idi Sutanto dalam sambutannya mengucapkan terimakasih atas kepemimpinan Pak Aceng selama ini dan juga mengajak seluruh jajaran untuk bekerja sama dalam mendukung program-progam bapak walikota.</p>\r\n\r\n<p>Acara sertijab berlangsung secara khidmat dan di hadiri seluruh pejabat struktural, fungsional serta pegawai di lingkungan DBMSDA Kota Bekasi. (dms)</p>\r\n', 'images/7eee0cbff016c191ea4fea5c50130859.jpeg', '2025-09-09 03:24:00', 2777, 0, 0, 'kota bekasi, serah terima, jabatan', 'published', 'index', NULL, NULL, '2025-09-09 03:24:00', '2025-09-09 03:24:00', NULL),
('e3b61b34-77d0-480b-89ba-1528eadd6087', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Tim Pematusan K3 diwilayah kelurahan pengasinan kecamatan rawalumbu', 'giat-tim-pematusan-k3-diwilayah-kelurahan-pengasinan-kecamatan-rawalumbu', 'Giat Tim Pematusan K3 diwilayah kelurahan pengasinan kecamatan rawalumbu', '', 'images/268f30e135bdd0a74d47892f1a641e14.jpeg', '2025-08-11 03:18:00', 1053, 0, 0, 'rawalumbu, pengasinan, diwilayah', 'published', 'index', NULL, NULL, '2025-08-11 03:18:00', '2025-08-11 03:18:00', NULL),
('e6b0a8a7-f504-473e-9cbc-3df004d93fa8', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat tim URC bina marga pengaspalan jalan igusti ngurahrai kecamatan bekasi barat', 'giat-tim-urc-bina-marga-pengaspalan-jalan-igusti-ngurahrai-kecamatan-bekasi-barat', 'Giat tim URC bina marga pengaspalan jalan igusti ngurahrai kecamatan bekasi barat', '', 'images/1e6df4a90082a6bc39ab9974dd407472.jpeg', '2021-12-24 09:39:00', 1665, 0, 0, 'bekasi barat, pengaspalan, kecamatan', 'published', 'index', NULL, NULL, '2021-12-24 09:39:00', '2021-12-24 09:39:00', NULL),
('e6e1dea0-8bc8-4b71-a441-24c99ac6685d', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Perbaikan lampu PJU jalan lingkungan Rw10 kelurahan harapan baru', 'perbaikan-lampu-pju-jalan-lingkungan-rw10-kelurahan-harapan-baru', 'Perbaikan lampu PJU jalan lingkungan Rw10 kelurahan harapan baru', '', 'images/e706fdbf4256c597d8cc9edd86edc70b.jpg', '2024-01-24 10:22:00', 4050, 0, 0, 'perbaikan, lampu, kelurahan', 'published', 'index', NULL, NULL, '2024-01-24 10:22:00', '2024-01-24 10:22:00', NULL),
('e770bd26-0faf-466e-809b-888355b5b704', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat pembersihan saluran sekunder samping pintu tol becakayu marga jaya - bekasi selatan', 'giat-pembersihan-saluran-sekunder-samping-pintu-tol-becakayu-marga-jaya---bekasi-selatan', 'Giat pembersihan saluran sekunder samping pintu tol becakayu marga jaya - bekasi selatan', '', 'images/2bbe8c5f67df0e985199d047d2ff05ae.jpg', '2025-06-23 04:14:00', 939, 0, 1, 'bekasi selatan, marga jaya, pembersihan', 'published', 'index', NULL, NULL, '2025-06-23 04:14:00', '2025-06-23 04:14:00', NULL),
('e7cbcac3-16f1-4950-8968-b44a12749d80', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat Perbaikan lampu PJU Gg. Bawang Kelurahan Cimuning Kecamatan Mustikajaya', 'giat-perbaikan-lampu-pju-gg.-bawang-kelurahan-cimuning-kecamatan-mustikajaya', 'Giat Perbaikan lampu PJU Gg. Bawang Kelurahan Cimuning Kecamatan Mustikajaya', '', 'images/2829f87f4a9f99474d2d694d3c60421c.jpeg', '2024-01-15 10:19:00', 4149, 0, 0, 'perbaikan, lampu, mustikajaya', 'published', 'index', NULL, NULL, '2024-01-15 10:19:00', '2024-01-15 10:19:00', NULL),
('e84ec794-fd5d-445b-babc-dd65a156381b', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Sekretaris dinas bmsda Idi Sutanto di dampingi oleh kepala bidang PJK dan Subag Umum dan Kepegawaian, memberikan SK PPPK kepada 159 Pegawai di lingkungan Dinas BMSDA', 'sekretaris-dinas-bmsda-idi-sutanto-di-dampingi-oleh-kepala-bidang-pjk-dan-subag-umum-dan-kepegawaian,-memberikan-sk-pppk-kepada-159-pegawai-di-lingkungan-dinas-bmsda', 'Sekretaris dinas bmsda Idi Sutanto di dampingi oleh kepala bidang PJK dan Subag Umum dan Kepegawaian, memberikan SK PPPK kepada 159 Pegawai di lingkungan Dinas BMSDA', '', 'images/380d41e9d441b00d8ef44ed7d57d1443.jpeg', '2025-07-09 09:44:00', 4627, 0, 1, 'bmsda, dinas, kepegawaian', 'published', 'index', NULL, NULL, '2025-07-09 09:44:00', '2025-07-09 09:44:00', NULL),
('e8c1a73e-96df-4d25-8fd0-9bafdbdc7b11', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat tim URC Bina Marga penanganan kabel menjuntai di jalan H Jole kelurahan pedurenan', 'giat-tim-urc-bina-marga-penanganan-kabel-menjuntai-di-jalan-h-jole-kelurahan-pedurenan', 'Giat tim URC Bina Marga penanganan kabel menjuntai di jalan H Jole kelurahan pedurenan', '', 'images/4d26760eb3db5f8c66ba15b34142add9.jpeg', '2022-01-18 05:20:00', 4486, 0, 1, 'penanganan, kelurahan, menjuntai', 'published', 'index', NULL, NULL, '2022-01-18 05:20:00', '2022-01-18 05:20:00', NULL),
('e93f867e-a99c-495d-8b26-9b5b4164112d', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', ' pemangkasan pohon SMAN 1 Bekasi Kelurahan Bekasi Jaya Kecamatan Bekasi Timur', 'pemangkasan-pohon-sman-1-bekasi-kelurahan-bekasi-jaya-kecamatan-bekasi-timur', 'pemangkasan pohon SMAN 1 Bekasi Kelurahan Bekasi Jaya Kecamatan Bekasi Timur', '', 'images/c351fb1a713a685acec8268e7371154d.png', '2023-12-18 06:15:00', 2219, 0, 1, 'bekasi timur, bekasi, pemangkasan', 'published', 'index', NULL, NULL, '2023-12-18 06:15:00', '2023-12-18 06:15:00', NULL),
('e980a7bf-1822-4e4e-a995-7e8a5e089d2e', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'pemangkasan pohon Jalan Ir.H.Juanda Kecamatan Bekasi Timur', 'pemangkasan-pohon-jalan-ir.h.juanda-kecamatan-bekasi-timur', 'pemangkasan pohon Jalan Ir.H.Juanda Kecamatan Bekasi Timur', '', 'images/75218228bbb9778b3d739043854cc665.jpg', '2023-12-20 01:53:00', 4723, 0, 1, 'bekasi timur, pemangkasan, kecamatan', 'published', 'index', NULL, NULL, '2023-12-20 01:53:00', '2023-12-20 01:53:00', NULL),
('ea0a6f17-b746-40e1-af81-b69e7f9c6983', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Melaksanakan pemangkasan dan penebangan pohon di perum centuri 2 Pekayon Bekasi Selatan Kota Bekasi.', 'melaksanakan-pemangkasan-dan-penebangan-pohon-di-perum-centuri-2-pekayon-bekasi-selatan-kota-bekasi.', 'Melaksanakan pemangkasan dan penebangan pohon di perum centuri 2 Pekayon Bekasi Selatan Kota Bekasi.', '', 'images/7df06cc85cc9ea27a007ced11415f631.jpeg', '2021-08-19 04:31:00', 4875, 0, 0, 'bekasi selatan, kota bekasi, bekasi', 'published', 'index', NULL, NULL, '2021-08-19 04:31:00', '2021-08-19 04:31:00', NULL),
('eccdbae9-6e7d-4dba-85ab-becd4444122c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'penyiraman Taman Median Jalan KH.Noer Ali Kecamatan Bekasi Selatan.', 'penyiraman-taman-median-jalan-kh.noer-ali-kecamatan-bekasi-selatan.', 'penyiraman Taman Median Jalan KH.Noer Ali Kecamatan Bekasi Selatan.', '', 'images/47568bff958281b3caaea05fce41e13a.jpeg', '2023-12-12 06:17:00', 4715, 0, 0, 'bekasi selatan, penyiraman, taman', 'published', 'index', NULL, NULL, '2023-12-12 06:17:00', '2023-12-12 06:17:00', NULL),
('efc9487c-423f-4ae1-b478-de2337e9fc00', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Evakuasi tiang yg tertabrak di jln transyogi', 'evakuasi-tiang-yg-tertabrak-di-jln-transyogi', 'Evakuasi tiang yg tertabrak di jln transyogi', '<h2>Evakuasi tiang yg tertabrak di jln transyogi</h2>\r\n', 'images/439877ec9578a70da0c75307e41162e2.jpg', '2020-11-10 23:17:00', 4455, 0, 0, 'transyogi, evakuasi, tiang', 'published', 'index', NULL, NULL, '2020-11-10 23:17:00', '2020-11-10 23:17:00', NULL),
('f02d54c1-d12a-4d3c-80b0-7b242a413887', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'kunjungan kerja dprd kota dumai konsultasi tentang perlindungan pengusaha lokal dan pengembangan Ker', 'kunjungan-kerja-dprd-kota-dumai-konsultasi-tentang-perlindungan-pengusaha-lokal-dan-pengembangan-kerakyatan-dan-tentang-penyelesaian-sistem-drainase.', 'kunjungan kerja dprd kota dumai konsultasi tentang perlindungan pengusaha lokal dan pengembangan Ker', '', 'images/655256a78b64181ab576d0b4df927bdf.jpeg', '2021-09-03 09:09:00', 3600, 0, 1, 'pengembangan, perlindungan, konsultasi', 'published', 'index', NULL, NULL, '2021-09-03 09:09:00', '2021-09-03 09:09:00', NULL),
('f1afa976-d87c-433d-8216-d274a0626f69', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemeliharaan Taman Median Jalan Rawa Tembaga IV Kecamatan Bekasi', 'pemeliharaan-taman-median-jalan-rawa-tembaga-iv-kecamatan-bekasi', 'Pemeliharaan Taman Median Jalan Rawa Tembaga IV Kecamatan Bekasi', '', 'images/e0fcef981efe46b2b8ce55aa0d0d20b5.jpeg', '2022-04-21 06:27:00', 4531, 1, 1, 'pemeliharaan, taman, kecamatan', 'published', 'index', NULL, NULL, '2022-04-21 06:27:00', '2022-04-21 06:27:00', NULL),
('f1d0ff2d-76e9-4526-aeee-bb3cf38297e4', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'giat tim pematusan penanganan sumbatan saluran air jalan bintara raya kel.bintara kec.bekasi barat', 'giat-tim-pematusan-penanganan-sumbatan-saluran-air-jalan-bintara-raya-kel.bintara-kec.bekasi-barat', 'giat tim pematusan penanganan sumbatan saluran air jalan bintara raya kel.bintara kec.bekasi barat', '', 'images/493b58bafe9a50697ad7f897bf3a0fca.jpeg', '2021-11-18 08:29:00', 4604, 0, 0, 'bekasi barat, bintara, penanganan', 'published', 'index', NULL, NULL, '2021-11-18 08:29:00', '2021-11-18 08:29:00', NULL),
('f25ac1f2-d87d-4673-a472-6b330d0c3862', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Hari ini Tim UPTD Alat Berat dan Perbengkelan melaksanakan giat Normalisasi kali menuju crossing tol', 'hari-ini-tim-uptd-alat-berat-dan-perbengkelan-melaksanakan-giat-normalisasi-kali-menuju-crossing-tol-rw-08-jatibening-baru', 'Hari ini Tim UPTD Alat Berat dan Perbengkelan melaksanakan giat Normalisasi kali menuju crossing tol', '', 'images/7f3ed4fde10cda00c7a925dae7fb5455.jpeg', '2023-11-22 07:59:00', 3767, 0, 1, 'melaksanakan, perbengkelan, normalisasi', 'published', 'index', NULL, NULL, '2023-11-22 07:59:00', '2023-11-22 07:59:00', NULL),
('f373e130-bc52-423c-bccd-b83baf08f78c', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat URC Bina Marga pengaspalan jalan Bintara Raya ex.Jembatan tol', 'giat-urc-bina-marga-pengaspalan-jalan-bintara-raya-ex.jembatan-tol', 'Giat URC Bina Marga pengaspalan jalan Bintara Raya ex.Jembatan tol', '', 'images/1df561e6fdd6d014d407fb7ff30c2371.jpeg', '2021-11-24 03:43:00', 775, 0, 0, 'pengaspalan, jembatan, bintara', 'published', 'index', NULL, NULL, '2021-11-24 03:43:00', '2021-11-24 03:43:00', NULL),
('f3a29abc-c447-4350-b4c4-ac626a9117f3', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemeliharaan Tali Air', 'pemeliharaan-tali-air', 'Tim URC Bidang Bina Marga melaksanakan giat Pemeliharaan tali air di Jalan Ahmad Yani Kecamatan Bekasi Selatan.', '<p>Tim URC Bidang Bina Marga melaksanakan giat Pemeliharaan tali air di Jalan Ahmad Yani Kecamatan Bekasi Selatan.</p>\r\n', 'images/6ad72782141370fbd25ed141c2a49270.jpg', '2023-09-13 08:40:00', 3516, 0, 0, 'bekasi selatan, pemeliharaan, melaksanakan', 'published', 'index', NULL, NULL, '2023-09-13 08:40:00', '2023-09-13 08:40:00', NULL),
('f3e49c33-d9cd-464f-9462-46c2f41b7e8a', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'perbaikan Jalan Nakula 1. Perum Pemda Kel. Jatiasih - Kec. Jatiasih', 'perbaikan-jalan-nakula-1.-perum-pemda-kel.-jatiasih---kec.-jatiasih', 'perbaikan Jalan Nakula 1. Perum Pemda Kel. Jatiasih - Kec. Jatiasih', '', 'images/4b959b83040227e771ffda9544beb721.jpg', '2024-01-17 10:20:00', 2473, 0, 0, 'perbaikan, jatiasih, nakula', 'published', 'index', NULL, NULL, '2024-01-17 10:20:00', '2024-01-17 10:20:00', NULL),
('f5ae3a45-08f3-4dfe-b4cf-22d773731b71', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', ' pembersihan Kali Alam Harapan jaya,Kec.Bekasi Utara', 'pembersihan-kali-alam-harapan-jaya,kec.bekasi-utara', 'pembersihan Kali Alam Harapan jaya,Kec.Bekasi Utara', '', 'images/bbe4dc88523590f2f52c8207ad6627a7.jpeg', '2025-07-16 08:55:00', 2664, 0, 0, 'bekasi utara, pembersihan, harapan', 'published', 'index', NULL, NULL, '2025-07-16 08:55:00', '2025-07-16 08:55:00', NULL),
('f6e2567f-c926-4e8c-aca8-77a16a4e5165', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Rapat persiapan lahan jl. Pangkalan 2 dan FO bulakapal.', 'rapat-persiapan-lahan-jl.-pangkalan-2-dan-fo-bulakapal.', 'Rapat persiapan lahan jl. Pangkalan 2 dan FO bulakapal.', '', 'images/9f0443996a5a8cb259a16ad7bcfc4f06.jpeg', '2022-07-19 09:34:00', 1713, 0, 0, 'bulakapal, pangkalan, persiapan', 'published', 'index', NULL, NULL, '2022-07-19 09:34:00', '2022-07-19 09:34:00', NULL),
('f87ac7ed-6e82-493e-9c26-5392d3207856', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemeliharaan lampu PJU di jalan pangeran jayakarta', 'pemeliharaan-lampu-pju-di-jalan-pangeran-jayakarta', 'Pemeliharaan lampu PJU di jalan pangeran jayakarta', '', 'images/9dac241a9dc465aff8afbb51e629e9ec.jpeg', '2022-03-25 09:26:00', 569, 0, 1, 'pemeliharaan, lampu, jayakarta', 'published', 'index', NULL, NULL, '2022-03-25 09:26:00', '2022-03-25 09:26:00', NULL),
('f88064fb-cc5e-409b-b5d1-eb5068bbdff0', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Giat TIM URC BINA MARGA Pengaspalan Jl. GATOT KACA II Kec. Jatiasih', 'giat-tim-urc-bina-marga-pengaspalan-jl.-gatot-kaca-ii-kec.-jatiasih', 'Giat TIM URC BINA MARGA Pengaspalan Jl. GATOT KACA II Kec. Jatiasih', '', 'images/a12218e3544746c33992857ed4585c84.jpeg', '2021-08-25 08:49:00', 4703, 0, 0, 'pengaspalan, jatiasih, gatot', 'published', 'index', NULL, NULL, '2021-08-25 08:49:00', '2021-08-25 08:49:00', NULL),
('f8a134a9-8aa5-49d2-b81e-da316997c9d7', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Rapat koordinasi persiapan pembangunan Jalan Sisi Barat Perjuangan Bekasi Utara', 'rapat-koordinasi-persiapan-pembangunan-jalan-sisi-barat-perjuangan-bekasi-utara', 'Rapat koordinasi persiapan pembangunan Jalan Sisi Barat Perjuangan, yang menghubungkan Duta Harapan s.d Wisma Asri. Dilanjutkan dengan join survei bersama Kepala Bidang...', '<p>Rapat koordinasi persiapan pembangunan Jalan Sisi Barat Perjuangan, yang menghubungkan Duta Harapan s.d Wisma Asri.<br />\r\n<br />\r\nDilanjutkan dengan join survei bersama Kepala Bidang Pemeliharaan dan Pembangunan Dinas Bina Marga dan Penataan Ruang Prov Jawa Barat, Kepala UPTD Wilayah 1 Cianjur Dinas Bina Marga dan Penataan Ruang Prov Jawa Barat, Dinas Tata Ruang, Kelurahan Teluk Pucung dan Tim survei.<br />\r\n<br />\r\nDiharapkan pembangunan jalan yang menghubungkan Duta Harapan dengan Wisma Asri di Jalan Sisi Barat Perjuangan dapat meningkatkan kapasitas Jalan Perjuangan untuk mendukung konektifitas wilayah Bekasi Utara menuju TOD Stasiun Bekasi.(dms)</p>\r\n', 'images/c63be03f55f28f74f4a930470b116d56.jpg', '2025-09-10 08:07:00', 4856, 0, 0, 'bekasi utara, pemeliharaan, barat', 'published', 'index', NULL, NULL, '2025-09-10 08:07:00', '2025-09-10 08:07:00', NULL),
('fb3a98ff-7ded-4e38-a8f2-c1c21d13a3fb', '9c513953-32d1-4415-a921-8a6baf246d44', '2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Pemerintah Kota Bekasi melalui Dinas Bina Marga dan Sumber Daya Air (DBMSDA) Kota Bekasi terus melak', 'pemerintah-kota-bekasi-melalui-dinas-bina-marga-dan-sumber-daya-air-(dbmsda)-kota-bekasi-terus-melakukan-upaya-pengendalian-daerah-aliran-sungai-(das)-rawa-tembaga-mulai-dari-hulu-hingga-hilir-guna-me', 'Pemerintah Kota Bekasi melalui Dinas Bina Marga dan Sumber Daya Air (DBMSDA) Kota Bekasi terus melakukan upaya pengendalian Daerah Aliran Sungai (DAS) Rawa Tembaga mulai dari...', '<p>Pemerintah Kota Bekasi melalui Dinas Bina Marga dan Sumber Daya Air (DBMSDA) Kota Bekasi terus melakukan upaya pengendalian Daerah Aliran Sungai (DAS) Rawa Tembaga mulai dari hulu hingga hilir guna meminimalisasi banjir di wilayah Kelurahan Pekayon Jaya dan Kayuringin Jaya, Kecamatan Bekasi Selatan.&nbsp;</p>\r\n\r\n<p>DAS Rawa Tembaga sejauh 5.872 kilometer dimulai dari&nbsp; hulunya di Pulau Sirih Utama hingga hulu di Kali Bekasi. Adapun wilayah penanganan DAS Rawa Tembaga melewati Perumahan Vila Jakasetia, Perumahan Green View, Perumahan Pondok Timur Mas, Perumahan Galaxy, Perumahan Pulo Permatasari, Perumahan Taman Cikas, Grand Kamala Lagoon, Perumahan Arjuna, sebagian saluran Pondok Pekayon, Perumahan BSK, Perumnas 1, dan Kompleks Kejaksaan.&nbsp;</p>\r\n\r\n<p>Pengendalian DAS Rawa Tembaga meliputi tindakan penanganan jangka pendek dan jangka panjang. Penanganan jangka pendek dilakukan dengan melakukan pengerukan dan pematusan saluran, penyediaan tiga buah pompa pengendali banjir, dan pemeliharaan pintu air.&nbsp;</p>\r\n\r\n<p>Sedangkan program jangka panjang, Pemerintah Kota Bekasi telah mempersiapkan master plan Pengendalian DAS Rawa Tembaga kemudian mengajukan permohonan bantuan kepada Pemerintah Provinsi Jawa Barat dan Balai Besar Wilayah Sungai Ciliwung Cisadane (BBWSCC) Kementerian Pekerjaan Umum dan Perumahan Rakyat (PUPR).&nbsp;</p>\r\n\r\n<p>Permohonan bantuan kepada Provinsi Jawa Barat disampaikan melalui Surat Nomor: 614/8025/DBMSDA, tanggal 29 Oktober 2021. Pemkot Bekasi mengajukan permohonan bantuan untuk pembangunan tanggul, pelebaran saluran, dan pembangunan long storage.</p>\r\n\r\n<p>Sementara kepada BBWSCC melalui Surat Nomor: 614/8026/DBMSDA, tanggal 29 Oktober 2021, Pemkot Bekasi mengajukan permohonan bantuan pelaksanaan kegiatan di tahun anggaran 2022. Usulan Pemerintah Kota Bekasi antara lain pembangunan tanggul, pelebaran saluran, pembangunan long storage, pemindahan pintu air Rawa Tembaga ke bagian hilir mendekati Kali Bekasi, dan pembangunan polder di hulu, tengah dan hilir DAS Rawa Tembaga. Selain itu, Pemkot Bekasi juga mengusulkan pembangunan saluran dari hilir crossing Tol Jakarta - Cikampek KM 12+100 sejajar dengan sisi selatan Jalan Kalimalang menuju Kali Bekasi, permohonan bantuan alat berat untuk pengerukan sedimentasi, dan permohonan bantuan pompa mobile yang akan ditempatkan di pintu Bendung Prisdo.</p>\r\n\r\n<p>Program penanganan DAS Rawa Tembaga telah dimulai sejak tahun 2003-2021 dan berlanjut pada rencana kegiatan tahun 2022.&nbsp;</p>\r\n\r\n<p>Realisasi kegiatan DAS Rawa Tembaga pada 2003 adalah pembangunan Polder Cikas, 2004 pembangunan kolam retensi sisi jalan tol, 2005 pembangunan Polde Jakasetia, 2010 pembangunan rumah pompa Rawa Tembaga, 2015-2016 pembangunan Polder Green View, 2017 pembangunan Polder PPS, 2018 pembangunan Polder PTM, 2018 pembangunan Polder BSK, dan 2021 pembangunan kolam retensi sisi jalan tol.&nbsp;</p>\r\n\r\n<p>Pemerintah Kota Bekasi juga mempersiapkan master plan DAS Rawa Tembaga dengan menerapkan lima kriteria penanganan yakni pembangunan polder/kolam retensi, duplikasi crossing saluran, normalisasi saluran berupa pelebaran dan peninggian tanggul, relokasi pintu bendung Rawa Tembaga, dan pembangunan saluran long storage.&nbsp;</p>\r\n\r\n<p>Identifikasi masalah telah dipetakan pada Penanganan DAS Rawa Tembaga di Segmen 6 mulai dari titik DAS Rawa Tembaga STA 2+750 di Outlet Kalimalang hingga titik STA 3+124 di pintu air Rawa Tembaga.</p>\r\n\r\n<p>Segmen 6 dimulai dari Outlet Kalimalang dengan elevasi 19,84 mdpl, kompleks BSK elevasi 16,10 mdpl dengan upaya peninggian tanggul 3-4 meter, Kantor kelurahan Kayuringin Jaya elevasi 17,60 mdpl dengan peninggian tanggul 2-2,5 meter, kompleks Kejaksaan elevasi 16,75 mdpl dengan peninggian tanggul 3-3,5 meter dan pintu air Rawa Tembaga elevasi 18,81 mdpl dengan peninggian tanggul 1 meter. (goeng/DNN)</p>\r\n', 'images/62b52a341904565e350bc28bee4fdf32.jpg', '2021-11-11 15:53:00', 1571, 0, 1, 'bekasi selatan, kota bekasi, jakasetia', 'published', 'index', NULL, NULL, '2021-11-11 15:53:00', '2021-11-11 15:53:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `article_images`
--

CREATE TABLE `article_images` (
  `uuid` char(36) NOT NULL,
  `article_uuid` char(36) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
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
(408, '787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', 'super@admin.com', 'updated', 'App\\Models\\User', '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin DBMSDA', '{\"name\":\"ESPRO Property\",\"email\":\"esproproperty.bekasi@gmail.com\",\"email_verified_at\":\"2026-09-19T02:27:18.000000Z\"}', '{\"name\":\"Admin DBMSDA\",\"email\":\"dbmsdakotabekasi2018@gmail.com\",\"email_verified_at\":\"2026-09-20 18:21:48\"}', 'http://localhost:8000/backend/user/9c513953-32d1-4415-a921-8a6baf246d44', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 11:21:48', '2026-09-20 11:21:48'),
(409, NULL, NULL, NULL, 'created', 'App\\Models\\LoginLockout', '35', 'LoginLockout #35', NULL, '{\"type\":\"ip\",\"value\":\"127.0.0.1\",\"attempts\":1,\"last_attempt_at\":\"2026-09-20 18:22:10\",\"updated_at\":\"2026-09-20 18:22:10\",\"created_at\":\"2026-09-20 18:22:10\",\"id\":35}', 'http://localhost:8000/auth/login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 11:22:10', '2026-09-20 11:22:10'),
(410, NULL, NULL, NULL, 'created', 'App\\Models\\LoginLockout', '36', 'LoginLockout #36', NULL, '{\"type\":\"email\",\"value\":\"dbmsdakotabekasi2018@gmail.com\",\"attempts\":1,\"last_attempt_at\":\"2026-09-20 18:22:10\",\"updated_at\":\"2026-09-20 18:22:10\",\"created_at\":\"2026-09-20 18:22:10\",\"id\":36}', 'http://localhost:8000/auth/login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 11:22:10', '2026-09-20 11:22:10'),
(411, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin DBMSDA', 'dbmsdakotabekasi2018@gmail.com', 'deleted', 'App\\Models\\Article', 'a4ce109d-88de-423a-bb26-d11087f68a29', 'judul berita', '{\"uuid\":\"a4ce109d-88de-423a-bb26-d11087f68a29\",\"user_uuid\":\"787b72ea-59d0-4d54-848b-c200bddafdd2\",\"category_uuid\":\"2162d145-9ef3-4e2f-8c55-81971a015bc5\",\"title\":\"judul berita\",\"slug\":\"judul-berita\",\"excerpt\":\"ringkasan\",\"content\":\"<p>isi berita<\\/p>\",\"featured_image\":\"images\\/4vWMjOtHfGlFugvZ84preK7RAnVcqHFGWUIjJaeD.png\",\"views\":0,\"is_featured\":false,\"is_popular\":false,\"tagging\":\"kota bekasi, walikota bekasi\",\"status\":\"published\",\"search_engine\":\"index\",\"link\":null,\"video\":null}', NULL, 'http://localhost:8000/backend/articles/a4ce109d-88de-423a-bb26-d11087f68a29', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 12:08:17', '2026-09-20 12:08:17'),
(412, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin DBMSDA', 'dbmsdakotabekasi2018@gmail.com', 'created', 'App\\Models\\Article', '2fa27e87-b4b5-4224-900d-26e44764d1e4', 'judul berita 2', NULL, '{\"user_uuid\":\"9c513953-32d1-4415-a921-8a6baf246d44\",\"category_uuid\":\"2162d145-9ef3-4e2f-8c55-81971a015bc5\",\"title\":\"judul berita 2\",\"slug\":\"judul-berita-2\",\"excerpt\":\"ringkasan\",\"content\":\"<p>isi berita<\\/p>\",\"scheduled_at\":\"2026-09-01 00:00:00\",\"tagging\":\"kota bekasi, walikota bekasi\",\"video\":null,\"status\":\"published\",\"search_engine\":\"index\",\"is_featured\":true,\"is_popular\":false,\"uuid\":\"2fa27e87-b4b5-4224-900d-26e44764d1e4\",\"updated_at\":\"2026-09-20 19:09:25\",\"created_at\":\"2026-09-20 19:09:25\"}', 'http://localhost:8000/backend/articles', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 12:09:25', '2026-09-20 12:09:25'),
(413, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin DBMSDA', 'dbmsdakotabekasi2018@gmail.com', 'updated', 'App\\Models\\Article', '2fa27e87-b4b5-4224-900d-26e44764d1e4', 'judul berita 2', '{\"featured_image\":null}', '{\"featured_image\":\"images\\/j6y3qSWN6dYvXjXiE41yWMTz0Z53cyxzaJD6YQWm.png\"}', 'http://localhost:8000/backend/articles/2fa27e87-b4b5-4224-900d-26e44764d1e4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 12:10:17', '2026-09-20 12:10:17'),
(414, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin DBMSDA', 'dbmsdakotabekasi2018@gmail.com', 'created', 'App\\Models\\DocumentCategory', 'a6d14f40-5032-40dc-9ef2-349d4300636f', 'IKM', NULL, '{\"uuid\":\"a6d14f40-5032-40dc-9ef2-349d4300636f\",\"name\":\"IKM\",\"slug\":\"ikm\",\"description\":\"Indeks Kepuasan Masyarakat\",\"status\":\"active\",\"updated_at\":\"2026-09-20 20:02:23\",\"created_at\":\"2026-09-20 20:02:23\"}', 'http://localhost:8000/backend/document-categories', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 13:02:23', '2026-09-20 13:02:23'),
(415, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin DBMSDA', 'dbmsdakotabekasi2018@gmail.com', 'created', 'App\\Models\\Document', '01a0beea-4a72-723e-a71b-5f20668c45b1', 'Indeks Kepuasan Masyarakat', NULL, '{\"category_uuid\":\"a6d14f40-5032-40dc-9ef2-349d4300636f\",\"title\":\"Indeks Kepuasan Masyarakat\",\"slug\":\"indeks-kepuasan-masyarakat\",\"excerpt\":\"Indeks Kepuasan Masyarakat\",\"description\":\"Indeks Kepuasan Masyarakat Tahun 2021\",\"published_at\":\"2021-09-21 00:00:00\",\"file\":\"documents\\/files\\/F7zMS5DOuHBcyaZIUiT5k4h5OFG69vxj3JT8Vhvh.pdf\",\"thumbnail\":null,\"status\":\"active\",\"uuid\":\"01a0beea-4a72-723e-a71b-5f20668c45b1\",\"updated_at\":\"2026-09-20 20:03:40\",\"created_at\":\"2026-09-20 20:03:40\"}', 'http://localhost:8000/backend/documents', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 13:03:40', '2026-09-20 13:03:40');

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

--
-- Dumping data for table `banner`
--

INSERT INTO `banner` (`uuid`, `nama`, `deskripsi`, `link`, `gambar`, `posisi`, `tipe`, `video_url`, `status`, `created_at`, `updated_at`) VALUES
('06c5d7af-ea7a-490a-8908-5aac3b6e20c1', 'kunjungan kerja Pansus VI DPRD Kota Banjarbaru', 'kunjungan kerja Pansus VI DPRD Kota Banjarbaru', NULL, 'banners/K9kbIQDeNG02yCQ78pB5ipqbjuFJuMiZ6C9j0f6n.jpg', 'galeri', 'foto', NULL, 'active', '2026-09-11 00:06:22', '2026-09-18 00:01:16'),
('47618df4-1983-4686-b9fd-f67aa7fae89f', 'Penghargaan Peringkat X Evaluasi Akuntabilitas Kinerja tahun', 'Penghargaan Peringkat X Evaluasi Akuntabilitas Kinerja tahun', NULL, 'banners/LYTwX1r9jIUlU0hAEUiW0ioEL9Qedq7aWKg3XEV4.jpg', 'galeri', 'foto', NULL, 'active', '2026-09-11 00:06:39', '2026-09-18 00:00:38'),
('8da02e21-bc7f-4816-ac56-1d762d11a546', 'Sosialisasi Rencana Pelaksanaan CASN dan Himbauan Netralitas', 'Sosialisasi Rencana Pelaksanaan CASN dan Himbauan Netralitas', NULL, 'banners/wV5Acw9bGraRZlfprQDjzlPNW40xLn4uPcVNuzIH.jpg', 'galeri', 'foto', NULL, 'active', '2026-09-11 00:06:01', '2026-09-18 00:01:46'),
('9c1f2fe3-0075-42bd-91dd-ff3b778be1d1', 'Kunjungan Kerja dalam rangka koordinasi dan konsultasi menca', 'Kunjungan Kerja dalam rangka koordinasi dan konsultasi menca', NULL, 'banners/TV1O2hyrUIE9J5NDSHMoPwI3ecHvnm0gqhkQWEAT.jpg', 'galeri', 'foto', NULL, 'active', '2026-09-18 00:03:24', '2026-09-18 00:03:24'),
('c72bd89f-0849-40a1-927c-b9774e84bd2b', 'Rapat persiapan dan sinkronisasi', 'Rapat persiapan dan sinkronisasi', NULL, 'banners/KdNt0w5McAu941Cf4qGF6n48HiBIRRlMBDCPtLGm.jpg', 'galeri', 'foto', NULL, 'active', '2026-09-11 00:05:33', '2026-09-18 00:02:18'),
('f7bd2370-bdad-42dc-909b-1239c040d0d3', 'Sosialisasi pengendalian gratifikasi', 'Sosialisasi pengendalian gratifikasi', NULL, 'banners/OrXZyrmNIp2hXdxa5WXkeWArSDrgnTZ2EzSfumja.jpg', 'galeri', 'foto', NULL, 'active', '2026-08-27 07:30:55', '2026-09-18 00:02:50');

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
('captcha_00175972bdae0fe300b2fe3c506031c3', 'a:6:{i:0;s:1:\"e\";i:1;s:1:\"9\";i:2;s:1:\"y\";i:3;s:1:\"g\";i:4;s:1:\"i\";i:5;s:1:\"5\";}', 1789903058),
('captcha_09616320bd2e909693407b2d9607a8ea', 'a:6:{i:0;s:1:\"t\";i:1;s:1:\"m\";i:2;s:1:\"j\";i:3;s:1:\"f\";i:4;s:1:\"h\";i:5;s:1:\"d\";}', 1789895432),
('captcha_32b6f2caf13edd02782d4ab9493d4ea7', 'a:6:{i:0;s:1:\"j\";i:1;s:1:\"t\";i:2;s:1:\"l\";i:3;s:1:\"w\";i:4;s:1:\"1\";i:5;s:1:\"3\";}', 1789903093),
('captcha_53158d7f5ca02ac3c23e3206087cfb4f', 'a:6:{i:0;s:1:\"i\";i:1;s:1:\"5\";i:2;s:1:\"s\";i:3;s:1:\"c\";i:4;s:1:\"9\";i:5;s:1:\"p\";}', 1789903084),
('captcha_7652ca47e7908813ef4e1e70771bba01', 'a:6:{i:0;s:1:\"p\";i:1;s:1:\"d\";i:2;s:1:\"y\";i:3;s:1:\"n\";i:4;s:1:\"l\";i:5;s:1:\"s\";}', 1789903054),
('captcha_8b6cb13e66eaf185b70a8d4067a32f34', 'a:6:{i:0;s:1:\"u\";i:1;s:1:\"s\";i:2;s:1:\"l\";i:3;s:1:\"7\";i:4;s:1:\"v\";i:5;s:1:\"x\";}', 1789882636),
('captcha_a3003a640bbf38211a7976bb432af0d9', 'a:6:{i:0;s:1:\"e\";i:1;s:1:\"l\";i:2;s:1:\"n\";i:3;s:1:\"m\";i:4;s:1:\"h\";i:5;s:1:\"o\";}', 1789903051),
('captcha_c3223217635aa3f81b556733cf85a0bc', 'a:6:{i:0;s:1:\"2\";i:1;s:1:\"b\";i:2;s:1:\"w\";i:3;s:1:\"q\";i:4;s:1:\"r\";i:5;s:1:\"c\";}', 1789908111),
('captcha_ceea0a71f0d7ef82e2371ecc5e3e2a66', 'a:6:{i:0;s:1:\"h\";i:1;s:1:\"d\";i:2;s:1:\"u\";i:3;s:1:\"z\";i:4;s:1:\"4\";i:5;s:1:\"k\";}', 1789903392),
('captcha_f5700151dbdd9532ac9cdc2e5e1259d9', 'a:6:{i:0;s:1:\"j\";i:1;s:1:\"i\";i:2;s:1:\"i\";i:3;s:1:\"d\";i:4;s:1:\"l\";i:5;s:1:\"k\";}', 1789903036),
('captcha_fc0e5efde94efe58f62987d59d793681', 'a:6:{i:0;s:1:\"o\";i:1;s:1:\"7\";i:2;s:1:\"x\";i:3;s:1:\"2\";i:4;s:1:\"i\";i:5;s:1:\"k\";}', 1789903393),
('dashboard_20260821_20260920_visitor', 'a:4:{s:12:\"total_visits\";i:21;s:15:\"unique_visitors\";i:15;s:5:\"daily\";a:3:{s:6:\"labels\";a:32:{i:0;s:6:\"21 Aug\";i:1;s:6:\"22 Aug\";i:2;s:6:\"23 Aug\";i:3;s:6:\"24 Aug\";i:4;s:6:\"25 Aug\";i:5;s:6:\"26 Aug\";i:6;s:6:\"27 Aug\";i:7;s:6:\"28 Aug\";i:8;s:6:\"29 Aug\";i:9;s:6:\"30 Aug\";i:10;s:6:\"31 Aug\";i:11;s:6:\"01 Sep\";i:12;s:6:\"02 Sep\";i:13;s:6:\"03 Sep\";i:14;s:6:\"04 Sep\";i:15;s:6:\"05 Sep\";i:16;s:6:\"06 Sep\";i:17;s:6:\"07 Sep\";i:18;s:6:\"08 Sep\";i:19;s:6:\"09 Sep\";i:20;s:6:\"10 Sep\";i:21;s:6:\"11 Sep\";i:22;s:6:\"12 Sep\";i:23;s:6:\"13 Sep\";i:24;s:6:\"14 Sep\";i:25;s:6:\"15 Sep\";i:26;s:6:\"16 Sep\";i:27;s:6:\"17 Sep\";i:28;s:6:\"18 Sep\";i:29;s:6:\"19 Sep\";i:30;s:6:\"20 Sep\";i:31;s:6:\"21 Sep\";}s:5:\"total\";a:32:{i:0;i:0;i:1;i:0;i:2;i:0;i:3;i:0;i:4;i:0;i:5;i:0;i:6;i:0;i:7;i:0;i:8;i:0;i:9;i:0;i:10;i:0;i:11;i:0;i:12;i:0;i:13;i:0;i:14;i:0;i:15;i:0;i:16;i:0;i:17;i:0;i:18;i:0;i:19;i:0;i:20;i:0;i:21;i:0;i:22;i:0;i:23;i:0;i:24;i:0;i:25;i:0;i:26;i:0;i:27;i:0;i:28;i:0;i:29;i:0;i:30;i:0;i:31;i:0;}s:6:\"unique\";a:32:{i:0;i:0;i:1;i:0;i:2;i:0;i:3;i:0;i:4;i:0;i:5;i:0;i:6;i:0;i:7;i:0;i:8;i:0;i:9;i:0;i:10;i:0;i:11;i:0;i:12;i:0;i:13;i:0;i:14;i:0;i:15;i:0;i:16;i:0;i:17;i:0;i:18;i:0;i:19;i:0;i:20;i:0;i:21;i:0;i:22;i:0;i:23;i:0;i:24;i:0;i:25;i:0;i:26;i:0;i:27;i:0;i:28;i:0;i:29;i:0;i:30;i:0;i:31;i:0;}}s:7:\"monthly\";a:3:{s:6:\"labels\";a:2:{i:0;s:8:\"Aug 2026\";i:1;s:8:\"Sep 2026\";}s:5:\"total\";a:2:{i:0;i:8;i:1;i:13;}s:6:\"unique\";a:2:{i:0;i:5;i:1;i:10;}}}', 1789911673),
('dashboard_aduan_total_selesai', 'i:0;', 1789911973),
('dashboard_aduan_total_total', 'i:0;', 1789911973),
('dashboard_stats_20260821_20260920', 'a:8:{s:13:\"totalArticles\";i:0;s:17:\"publishedArticles\";i:0;s:13:\"totalMessages\";i:0;s:14:\"unreadMessages\";i:0;s:8:\"totalFaq\";i:6;s:10:\"totalPages\";i:2;s:14:\"totalDocuments\";i:45;s:11:\"totalEvents\";i:0;}', 1789911433);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('sidebar_menus_787b72ea-59d0-4d54-848b-c200bddafdd2_super-admin', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:12:{i:0;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:12;s:4:\"name\";s:14:\"Profil Website\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"layanan.kontak\";s:4:\"icon\";s:10:\"bx-package\";s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2025-09-14 19:05:35\";s:10:\"updated_at\";s:19:\"2026-09-18 11:10:11\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:12;s:4:\"name\";s:14:\"Profil Website\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"layanan.kontak\";s:4:\"icon\";s:10:\"bx-package\";s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2025-09-14 19:05:35\";s:10:\"updated_at\";s:19:\"2026-09-18 11:10:11\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:22;s:4:\"name\";s:14:\"Layanan Publik\";s:6:\"status\";i:1;s:15:\"permission_name\";s:21:\"class-schedules.index\";s:4:\"icon\";s:7:\"bx-book\";s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-02 22:16:09\";s:10:\"updated_at\";s:19:\"2026-09-17 12:01:27\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:22;s:4:\"name\";s:14:\"Layanan Publik\";s:6:\"status\";i:1;s:15:\"permission_name\";s:21:\"class-schedules.index\";s:4:\"icon\";s:7:\"bx-book\";s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-02 22:16:09\";s:10:\"updated_at\";s:19:\"2026-09-17 12:01:27\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:2:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:46;s:4:\"name\";s:10:\"Class List\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"classes.index\";s:13:\"menu_group_id\";i:22;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-02 22:18:03\";s:10:\"updated_at\";s:19:\"2026-09-02 22:18:03\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:46;s:4:\"name\";s:10:\"Class List\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"classes.index\";s:13:\"menu_group_id\";i:22;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-02 22:18:03\";s:10:\"updated_at\";s:19:\"2026-09-02 22:18:03\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:47;s:4:\"name\";s:8:\"Schedule\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"classes.index\";s:13:\"menu_group_id\";i:22;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-06 10:39:53\";s:10:\"updated_at\";s:19:\"2026-09-06 10:39:53\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:47;s:4:\"name\";s:8:\"Schedule\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"classes.index\";s:13:\"menu_group_id\";i:22;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-06 10:39:53\";s:10:\"updated_at\";s:19:\"2026-09-06 10:39:53\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:4;s:4:\"name\";s:7:\"Dokumen\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:4:\"icon\";s:10:\"bx-receipt\";s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:35:30\";s:10:\"updated_at\";s:19:\"2026-09-16 05:51:58\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:4;s:4:\"name\";s:7:\"Dokumen\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:4:\"icon\";s:10:\"bx-receipt\";s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:35:30\";s:10:\"updated_at\";s:19:\"2026-09-16 05:51:58\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:54;s:4:\"name\";s:13:\"Semua Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:15:\"documents.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"documents.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-13 21:23:49\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:42\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:54;s:4:\"name\";s:13:\"Semua Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:15:\"documents.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"documents.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-13 21:23:49\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:42\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:55;s:4:\"name\";s:17:\"Kategori  Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:25:\"document-categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-13 21:27:33\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:54\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:55;s:4:\"name\";s:17:\"Kategori  Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:25:\"document-categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-13 21:27:33\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:56;s:4:\"name\";s:14:\"Tambah Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:16:\"documents.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"documents.create\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-16 07:39:08\";s:10:\"updated_at\";s:19:\"2026-09-16 07:39:08\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:56;s:4:\"name\";s:14:\"Tambah Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:16:\"documents.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"documents.create\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-16 07:39:08\";s:10:\"updated_at\";s:19:\"2026-09-16 07:39:08\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:11;s:4:\"name\";s:6:\"Agenda\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"agenda.index\";s:4:\"icon\";s:12:\"bxs-calendar\";s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2025-07-25 23:53:44\";s:10:\"updated_at\";s:19:\"2026-09-16 04:51:58\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:11;s:4:\"name\";s:6:\"Agenda\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"agenda.index\";s:4:\"icon\";s:12:\"bxs-calendar\";s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2025-07-25 23:53:44\";s:10:\"updated_at\";s:19:\"2026-09-16 04:51:58\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:14;s:4:\"name\";s:15:\"Agenda Kegiatan\";s:4:\"icon\";N;s:5:\"route\";s:12:\"agenda.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"agenda.index\";s:13:\"menu_group_id\";i:11;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2025-07-25 23:55:36\";s:10:\"updated_at\";s:19:\"2026-09-16 04:52:17\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:14;s:4:\"name\";s:15:\"Agenda Kegiatan\";s:4:\"icon\";N;s:5:\"route\";s:12:\"agenda.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"agenda.index\";s:13:\"menu_group_id\";i:11;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2025-07-25 23:55:36\";s:10:\"updated_at\";s:19:\"2026-09-16 04:52:17\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:10;s:4:\"name\";s:14:\"Profil Pejabat\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"instruktur.index\";s:4:\"icon\";s:7:\"bx-user\";s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2025-07-24 05:38:22\";s:10:\"updated_at\";s:19:\"2026-09-17 11:49:29\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:10;s:4:\"name\";s:14:\"Profil Pejabat\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"instruktur.index\";s:4:\"icon\";s:7:\"bx-user\";s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2025-07-24 05:38:22\";s:10:\"updated_at\";s:19:\"2026-09-17 11:49:29\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:2:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:13;s:4:\"name\";s:7:\"Jabatan\";s:4:\"icon\";N;s:5:\"route\";s:17:\"departments.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:17:\"departments.index\";s:13:\"menu_group_id\";i:10;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2025-07-24 06:12:46\";s:10:\"updated_at\";s:19:\"2026-09-19 03:52:02\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:13;s:4:\"name\";s:7:\"Jabatan\";s:4:\"icon\";N;s:5:\"route\";s:17:\"departments.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:17:\"departments.index\";s:13:\"menu_group_id\";i:10;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2025-07-24 06:12:46\";s:10:\"updated_at\";s:19:\"2026-09-19 03:52:02\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:41;s:4:\"name\";s:15:\"All Instructors\";s:4:\"icon\";N;s:5:\"route\";s:16:\"instruktur.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"program.index\";s:13:\"menu_group_id\";i:10;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2025-11-12 11:02:59\";s:10:\"updated_at\";s:19:\"2026-09-04 00:40:35\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:41;s:4:\"name\";s:15:\"All Instructors\";s:4:\"icon\";N;s:5:\"route\";s:16:\"instruktur.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"program.index\";s:13:\"menu_group_id\";i:10;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2025-11-12 11:02:59\";s:10:\"updated_at\";s:19:\"2026-09-04 00:40:35\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:7;s:4:\"name\";s:9:\"Publikasi\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"articles.index\";s:4:\"icon\";s:8:\"bxs-file\";s:8:\"position\";i:7;s:10:\"created_at\";s:19:\"2024-09-29 19:37:06\";s:10:\"updated_at\";s:19:\"2026-09-17 12:01:01\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:7;s:4:\"name\";s:9:\"Publikasi\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"articles.index\";s:4:\"icon\";s:8:\"bxs-file\";s:8:\"position\";i:7;s:10:\"created_at\";s:19:\"2024-09-29 19:37:06\";s:10:\"updated_at\";s:19:\"2026-09-17 12:01:01\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:9;s:4:\"name\";s:6:\"Berita\";s:4:\"icon\";N;s:5:\"route\";s:14:\"articles.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"articles.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-30 19:08:38\";s:10:\"updated_at\";s:19:\"2026-09-17 08:51:37\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:9;s:4:\"name\";s:6:\"Berita\";s:4:\"icon\";N;s:5:\"route\";s:14:\"articles.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"articles.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-30 19:08:38\";s:10:\"updated_at\";s:19:\"2026-09-17 08:51:37\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:12;s:4:\"name\";s:13:\"Tambah Berita\";s:4:\"icon\";N;s:5:\"route\";s:15:\"articles.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"articles.create\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2025-07-22 19:59:27\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:32\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:12;s:4:\"name\";s:13:\"Tambah Berita\";s:4:\"icon\";N;s:5:\"route\";s:15:\"articles.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"articles.create\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2025-07-22 19:59:27\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:32\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:8;s:4:\"name\";s:8:\"Kategori\";s:4:\"icon\";N;s:5:\"route\";s:16:\"categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"categories.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-29 19:39:24\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:41\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:8;s:4:\"name\";s:8:\"Kategori\";s:4:\"icon\";N;s:5:\"route\";s:16:\"categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"categories.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-29 19:39:24\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:41\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:6;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:8;s:4:\"name\";s:13:\"Pustaka Media\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:4:\"icon\";s:9:\"bx-camera\";s:8:\"position\";i:8;s:10:\"created_at\";s:19:\"2024-10-14 05:33:06\";s:10:\"updated_at\";s:19:\"2026-09-17 12:23:10\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:8;s:4:\"name\";s:13:\"Pustaka Media\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:4:\"icon\";s:9:\"bx-camera\";s:8:\"position\";i:8;s:10:\"created_at\";s:19:\"2024-10-14 05:33:06\";s:10:\"updated_at\";s:19:\"2026-09-17 12:23:10\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:10;s:4:\"name\";s:11:\"Semua Media\";s:4:\"icon\";N;s:5:\"route\";s:12:\"banner.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:13:\"menu_group_id\";i:8;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-10-14 05:38:24\";s:10:\"updated_at\";s:19:\"2026-09-17 12:23:32\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:10;s:4:\"name\";s:11:\"Semua Media\";s:4:\"icon\";N;s:5:\"route\";s:12:\"banner.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:13:\"menu_group_id\";i:8;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-10-14 05:38:24\";s:10:\"updated_at\";s:19:\"2026-09-17 12:23:32\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:7;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:26;s:4:\"name\";s:9:\"Pengaduan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:4:\"icon\";s:8:\"bx-phone\";s:8:\"position\";i:9;s:10:\"created_at\";s:19:\"2026-09-19 09:03:39\";s:10:\"updated_at\";s:19:\"2026-09-19 09:03:39\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:26;s:4:\"name\";s:9:\"Pengaduan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:4:\"icon\";s:8:\"bx-phone\";s:8:\"position\";i:9;s:10:\"created_at\";s:19:\"2026-09-19 09:03:39\";s:10:\"updated_at\";s:19:\"2026-09-19 09:03:39\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:63;s:4:\"name\";s:13:\"Riwayat Aduan\";s:4:\"icon\";N;s:5:\"route\";s:12:\"aduans.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:13:\"menu_group_id\";i:26;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-19 09:04:40\";s:10:\"updated_at\";s:19:\"2026-09-19 09:04:40\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:63;s:4:\"name\";s:13:\"Riwayat Aduan\";s:4:\"icon\";N;s:5:\"route\";s:12:\"aduans.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:13:\"menu_group_id\";i:26;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-19 09:04:40\";s:10:\"updated_at\";s:19:\"2026-09-19 09:04:40\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:8;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:9;s:4:\"name\";s:11:\"Master Data\";s:6:\"status\";i:1;s:15:\"permission_name\";s:17:\"testimonial.index\";s:4:\"icon\";s:14:\"bx-folder-open\";s:8:\"position\";i:11;s:10:\"created_at\";s:19:\"2025-07-22 00:56:19\";s:10:\"updated_at\";s:19:\"2026-08-31 02:07:27\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:9;s:4:\"name\";s:11:\"Master Data\";s:6:\"status\";i:1;s:15:\"permission_name\";s:17:\"testimonial.index\";s:4:\"icon\";s:14:\"bx-folder-open\";s:8:\"position\";i:11;s:10:\"created_at\";s:19:\"2025-07-22 00:56:19\";s:10:\"updated_at\";s:19:\"2026-08-31 02:07:27\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:40;s:4:\"name\";s:14:\"Halaman Statis\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"pages.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2025-10-21 10:46:02\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:02\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:40;s:4:\"name\";s:14:\"Halaman Statis\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"pages.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2025-10-21 10:46:02\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:02\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:50;s:4:\"name\";s:7:\"Polling\";s:4:\"icon\";N;s:5:\"route\";s:10:\"poll.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"poll.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-08 06:00:45\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:23\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:50;s:4:\"name\";s:7:\"Polling\";s:4:\"icon\";N;s:5:\"route\";s:10:\"poll.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"poll.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-08 06:00:45\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:23\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:51;s:4:\"name\";s:12:\"Faq & Answer\";s:4:\"icon\";N;s:5:\"route\";s:9:\"faq.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:9:\"faq.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-08 06:04:55\";s:10:\"updated_at\";s:19:\"2026-09-08 06:04:55\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:51;s:4:\"name\";s:12:\"Faq & Answer\";s:4:\"icon\";N;s:5:\"route\";s:9:\"faq.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:9:\"faq.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-08 06:04:55\";s:10:\"updated_at\";s:19:\"2026-09-08 06:04:55\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:9;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:2;s:4:\"name\";s:14:\"Role dan Akses\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"menu.role-permission\";s:4:\"icon\";s:17:\"bx-shield-quarter\";s:8:\"position\";i:12;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:56:50\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:2;s:4:\"name\";s:14:\"Role dan Akses\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"menu.role-permission\";s:4:\"icon\";s:17:\"bx-shield-quarter\";s:8:\"position\";i:12;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:56:50\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:2:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:2;s:4:\"name\";s:11:\"Module Role\";s:4:\"icon\";N;s:5:\"route\";s:16:\"permission.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"permission.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:37\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:2;s:4:\"name\";s:11:\"Module Role\";s:4:\"icon\";N;s:5:\"route\";s:16:\"permission.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"permission.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:37\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:3;s:4:\"name\";s:11:\"Master Role\";s:4:\"icon\";N;s:5:\"route\";s:10:\"role.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"role.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:15\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:3;s:4:\"name\";s:11:\"Master Role\";s:4:\"icon\";N;s:5:\"route\";s:10:\"role.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"role.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:15\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:10;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:3;s:4:\"name\";s:10:\"Pengaturan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"menu-item.index\";s:4:\"icon\";s:6:\"bx-cog\";s:8:\"position\";i:13;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2026-09-17 10:28:38\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:3;s:4:\"name\";s:10:\"Pengaturan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"menu-item.index\";s:4:\"icon\";s:6:\"bx-cog\";s:8:\"position\";i:13;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2026-09-17 10:28:38\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:6:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Daftar Pengguna\";s:4:\"icon\";N;s:5:\"route\";s:10:\"user.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"user.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:39:25\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Daftar Pengguna\";s:4:\"icon\";N;s:5:\"route\";s:10:\"user.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"user.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:39:25\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:5;s:4:\"name\";s:15:\"Module Aplikasi\";s:4:\"icon\";N;s:5:\"route\";s:11:\"route.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"route.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:54\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:5;s:4:\"name\";s:15:\"Module Aplikasi\";s:4:\"icon\";N;s:5:\"route\";s:11:\"route.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"route.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:6;s:4:\"name\";s:12:\"Menu Manager\";s:4:\"icon\";N;s:5:\"route\";s:10:\"menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"menu-group.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:09\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:6;s:4:\"name\";s:12:\"Menu Manager\";s:4:\"icon\";N;s:5:\"route\";s:10:\"menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"menu-group.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:09\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:48;s:4:\"name\";s:11:\"Pesan Masuk\";s:4:\"icon\";N;s:5:\"route\";s:14:\"layanan.kontak\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"layanan.kontak\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-07 02:44:23\";s:10:\"updated_at\";s:19:\"2026-09-17 21:13:26\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:48;s:4:\"name\";s:11:\"Pesan Masuk\";s:4:\"icon\";N;s:5:\"route\";s:14:\"layanan.kontak\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"layanan.kontak\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-07 02:44:23\";s:10:\"updated_at\";s:19:\"2026-09-17 21:13:26\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:49;s:4:\"name\";s:12:\"Menu Website\";s:4:\"icon\";N;s:5:\"route\";s:18:\"website-menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"articles.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-07 03:40:53\";s:10:\"updated_at\";s:19:\"2026-09-17 20:56:47\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:49;s:4:\"name\";s:12:\"Menu Website\";s:4:\"icon\";N;s:5:\"route\";s:18:\"website-menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"articles.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-07 03:40:53\";s:10:\"updated_at\";s:19:\"2026-09-17 20:56:47\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:62;s:4:\"name\";s:19:\"Konfigurasi Website\";s:4:\"icon\";N;s:5:\"route\";s:21:\"website-identity.edit\";s:6:\"status\";i:1;s:15:\"permission_name\";s:21:\"website-identity.edit\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2026-09-18 10:00:37\";s:10:\"updated_at\";s:19:\"2026-09-18 10:00:37\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:62;s:4:\"name\";s:19:\"Konfigurasi Website\";s:4:\"icon\";N;s:5:\"route\";s:21:\"website-identity.edit\";s:6:\"status\";i:1;s:15:\"permission_name\";s:21:\"website-identity.edit\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2026-09-18 10:00:37\";s:10:\"updated_at\";s:19:\"2026-09-18 10:00:37\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:11;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:24;s:4:\"name\";s:8:\"Keamanan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"menu.keamanan\";s:4:\"icon\";s:15:\"bx-shield-alt-2\";s:8:\"position\";i:14;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:24;s:4:\"name\";s:8:\"Keamanan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"menu.keamanan\";s:4:\"icon\";s:15:\"bx-shield-alt-2\";s:8:\"position\";i:14;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:4:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:57;s:4:\"name\";s:14:\"Login Activity\";s:4:\"icon\";N;s:5:\"route\";s:29:\"security.login-activity.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"login-activity.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:57;s:4:\"name\";s:14:\"Login Activity\";s:4:\"icon\";N;s:5:\"route\";s:29:\"security.login-activity.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"login-activity.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:58;s:4:\"name\";s:9:\"Audit Log\";s:4:\"icon\";N;s:5:\"route\";s:24:\"security.audit-log.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"audit-log.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:58;s:4:\"name\";s:9:\"Audit Log\";s:4:\"icon\";N;s:5:\"route\";s:24:\"security.audit-log.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"audit-log.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:59;s:4:\"name\";s:12:\"Failed Login\";s:4:\"icon\";N;s:5:\"route\";s:27:\"security.failed-login.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:18:\"failed-login.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:59;s:4:\"name\";s:12:\"Failed Login\";s:4:\"icon\";N;s:5:\"route\";s:27:\"security.failed-login.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:18:\"failed-login.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:60;s:4:\"name\";s:12:\"Blokir Login\";s:4:\"icon\";N;s:5:\"route\";s:28:\"security.login-lockout.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:19:\"login-lockout.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-17 10:25:22\";s:10:\"updated_at\";s:19:\"2026-09-17 10:25:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:60;s:4:\"name\";s:12:\"Blokir Login\";s:4:\"icon\";N;s:5:\"route\";s:28:\"security.login-lockout.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:19:\"login-lockout.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-17 10:25:22\";s:10:\"updated_at\";s:19:\"2026-09-17 10:25:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 1789903382);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('sidebar_menus_9c513953-32d1-4415-a921-8a6baf246d44_admin', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:12:{i:0;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:12;s:4:\"name\";s:14:\"Profil Website\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"layanan.kontak\";s:4:\"icon\";s:10:\"bx-package\";s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2025-09-14 19:05:35\";s:10:\"updated_at\";s:19:\"2026-09-18 11:10:11\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:12;s:4:\"name\";s:14:\"Profil Website\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"layanan.kontak\";s:4:\"icon\";s:10:\"bx-package\";s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2025-09-14 19:05:35\";s:10:\"updated_at\";s:19:\"2026-09-18 11:10:11\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:22;s:4:\"name\";s:14:\"Layanan Publik\";s:6:\"status\";i:1;s:15:\"permission_name\";s:21:\"class-schedules.index\";s:4:\"icon\";s:7:\"bx-book\";s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-02 22:16:09\";s:10:\"updated_at\";s:19:\"2026-09-17 12:01:27\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:22;s:4:\"name\";s:14:\"Layanan Publik\";s:6:\"status\";i:1;s:15:\"permission_name\";s:21:\"class-schedules.index\";s:4:\"icon\";s:7:\"bx-book\";s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-02 22:16:09\";s:10:\"updated_at\";s:19:\"2026-09-17 12:01:27\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:2:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:46;s:4:\"name\";s:10:\"Class List\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"classes.index\";s:13:\"menu_group_id\";i:22;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-02 22:18:03\";s:10:\"updated_at\";s:19:\"2026-09-02 22:18:03\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:46;s:4:\"name\";s:10:\"Class List\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"classes.index\";s:13:\"menu_group_id\";i:22;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-02 22:18:03\";s:10:\"updated_at\";s:19:\"2026-09-02 22:18:03\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:47;s:4:\"name\";s:8:\"Schedule\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"classes.index\";s:13:\"menu_group_id\";i:22;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-06 10:39:53\";s:10:\"updated_at\";s:19:\"2026-09-06 10:39:53\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:47;s:4:\"name\";s:8:\"Schedule\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"classes.index\";s:13:\"menu_group_id\";i:22;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-06 10:39:53\";s:10:\"updated_at\";s:19:\"2026-09-06 10:39:53\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:4;s:4:\"name\";s:7:\"Dokumen\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:4:\"icon\";s:10:\"bx-receipt\";s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:35:30\";s:10:\"updated_at\";s:19:\"2026-09-16 05:51:58\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:4;s:4:\"name\";s:7:\"Dokumen\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:4:\"icon\";s:10:\"bx-receipt\";s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:35:30\";s:10:\"updated_at\";s:19:\"2026-09-16 05:51:58\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:54;s:4:\"name\";s:13:\"Semua Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:15:\"documents.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"documents.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-13 21:23:49\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:42\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:54;s:4:\"name\";s:13:\"Semua Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:15:\"documents.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"documents.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-13 21:23:49\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:42\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:55;s:4:\"name\";s:17:\"Kategori  Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:25:\"document-categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-13 21:27:33\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:54\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:55;s:4:\"name\";s:17:\"Kategori  Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:25:\"document-categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:25:\"document-categories.index\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-13 21:27:33\";s:10:\"updated_at\";s:19:\"2026-09-17 21:18:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:56;s:4:\"name\";s:14:\"Tambah Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:16:\"documents.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"documents.create\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-16 07:39:08\";s:10:\"updated_at\";s:19:\"2026-09-16 07:39:08\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:56;s:4:\"name\";s:14:\"Tambah Dokumen\";s:4:\"icon\";N;s:5:\"route\";s:16:\"documents.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"documents.create\";s:13:\"menu_group_id\";i:4;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-16 07:39:08\";s:10:\"updated_at\";s:19:\"2026-09-16 07:39:08\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:11;s:4:\"name\";s:6:\"Agenda\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"agenda.index\";s:4:\"icon\";s:12:\"bxs-calendar\";s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2025-07-25 23:53:44\";s:10:\"updated_at\";s:19:\"2026-09-16 04:51:58\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:11;s:4:\"name\";s:6:\"Agenda\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"agenda.index\";s:4:\"icon\";s:12:\"bxs-calendar\";s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2025-07-25 23:53:44\";s:10:\"updated_at\";s:19:\"2026-09-16 04:51:58\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:14;s:4:\"name\";s:15:\"Agenda Kegiatan\";s:4:\"icon\";N;s:5:\"route\";s:12:\"agenda.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"agenda.index\";s:13:\"menu_group_id\";i:11;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2025-07-25 23:55:36\";s:10:\"updated_at\";s:19:\"2026-09-16 04:52:17\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:14;s:4:\"name\";s:15:\"Agenda Kegiatan\";s:4:\"icon\";N;s:5:\"route\";s:12:\"agenda.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"agenda.index\";s:13:\"menu_group_id\";i:11;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2025-07-25 23:55:36\";s:10:\"updated_at\";s:19:\"2026-09-16 04:52:17\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:10;s:4:\"name\";s:14:\"Profil Pejabat\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"instruktur.index\";s:4:\"icon\";s:7:\"bx-user\";s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2025-07-24 05:38:22\";s:10:\"updated_at\";s:19:\"2026-09-17 11:49:29\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:10;s:4:\"name\";s:14:\"Profil Pejabat\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"instruktur.index\";s:4:\"icon\";s:7:\"bx-user\";s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2025-07-24 05:38:22\";s:10:\"updated_at\";s:19:\"2026-09-17 11:49:29\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:2:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:13;s:4:\"name\";s:7:\"Jabatan\";s:4:\"icon\";N;s:5:\"route\";s:17:\"departments.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:17:\"departments.index\";s:13:\"menu_group_id\";i:10;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2025-07-24 06:12:46\";s:10:\"updated_at\";s:19:\"2026-09-19 03:52:02\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:13;s:4:\"name\";s:7:\"Jabatan\";s:4:\"icon\";N;s:5:\"route\";s:17:\"departments.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:17:\"departments.index\";s:13:\"menu_group_id\";i:10;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2025-07-24 06:12:46\";s:10:\"updated_at\";s:19:\"2026-09-19 03:52:02\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:41;s:4:\"name\";s:15:\"All Instructors\";s:4:\"icon\";N;s:5:\"route\";s:16:\"instruktur.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"program.index\";s:13:\"menu_group_id\";i:10;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2025-11-12 11:02:59\";s:10:\"updated_at\";s:19:\"2026-09-04 00:40:35\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:41;s:4:\"name\";s:15:\"All Instructors\";s:4:\"icon\";N;s:5:\"route\";s:16:\"instruktur.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"program.index\";s:13:\"menu_group_id\";i:10;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2025-11-12 11:02:59\";s:10:\"updated_at\";s:19:\"2026-09-04 00:40:35\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:7;s:4:\"name\";s:9:\"Publikasi\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"articles.index\";s:4:\"icon\";s:8:\"bxs-file\";s:8:\"position\";i:7;s:10:\"created_at\";s:19:\"2024-09-29 19:37:06\";s:10:\"updated_at\";s:19:\"2026-09-17 12:01:01\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:7;s:4:\"name\";s:9:\"Publikasi\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"articles.index\";s:4:\"icon\";s:8:\"bxs-file\";s:8:\"position\";i:7;s:10:\"created_at\";s:19:\"2024-09-29 19:37:06\";s:10:\"updated_at\";s:19:\"2026-09-17 12:01:01\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:9;s:4:\"name\";s:6:\"Berita\";s:4:\"icon\";N;s:5:\"route\";s:14:\"articles.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"articles.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-30 19:08:38\";s:10:\"updated_at\";s:19:\"2026-09-17 08:51:37\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:9;s:4:\"name\";s:6:\"Berita\";s:4:\"icon\";N;s:5:\"route\";s:14:\"articles.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"articles.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-30 19:08:38\";s:10:\"updated_at\";s:19:\"2026-09-17 08:51:37\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:12;s:4:\"name\";s:13:\"Tambah Berita\";s:4:\"icon\";N;s:5:\"route\";s:15:\"articles.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"articles.create\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2025-07-22 19:59:27\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:32\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:12;s:4:\"name\";s:13:\"Tambah Berita\";s:4:\"icon\";N;s:5:\"route\";s:15:\"articles.create\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"articles.create\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2025-07-22 19:59:27\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:32\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:8;s:4:\"name\";s:8:\"Kategori\";s:4:\"icon\";N;s:5:\"route\";s:16:\"categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"categories.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-29 19:39:24\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:41\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:8;s:4:\"name\";s:8:\"Kategori\";s:4:\"icon\";N;s:5:\"route\";s:16:\"categories.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"categories.index\";s:13:\"menu_group_id\";i:7;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-29 19:39:24\";s:10:\"updated_at\";s:19:\"2026-09-17 09:21:41\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:6;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:8;s:4:\"name\";s:13:\"Pustaka Media\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:4:\"icon\";s:9:\"bx-camera\";s:8:\"position\";i:8;s:10:\"created_at\";s:19:\"2024-10-14 05:33:06\";s:10:\"updated_at\";s:19:\"2026-09-17 12:23:10\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:8;s:4:\"name\";s:13:\"Pustaka Media\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:4:\"icon\";s:9:\"bx-camera\";s:8:\"position\";i:8;s:10:\"created_at\";s:19:\"2024-10-14 05:33:06\";s:10:\"updated_at\";s:19:\"2026-09-17 12:23:10\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:10;s:4:\"name\";s:11:\"Semua Media\";s:4:\"icon\";N;s:5:\"route\";s:12:\"banner.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:13:\"menu_group_id\";i:8;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-10-14 05:38:24\";s:10:\"updated_at\";s:19:\"2026-09-17 12:23:32\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:10;s:4:\"name\";s:11:\"Semua Media\";s:4:\"icon\";N;s:5:\"route\";s:12:\"banner.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"banner.index\";s:13:\"menu_group_id\";i:8;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-10-14 05:38:24\";s:10:\"updated_at\";s:19:\"2026-09-17 12:23:32\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:7;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:26;s:4:\"name\";s:9:\"Pengaduan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:4:\"icon\";s:8:\"bx-phone\";s:8:\"position\";i:9;s:10:\"created_at\";s:19:\"2026-09-19 09:03:39\";s:10:\"updated_at\";s:19:\"2026-09-19 09:03:39\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:26;s:4:\"name\";s:9:\"Pengaduan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:4:\"icon\";s:8:\"bx-phone\";s:8:\"position\";i:9;s:10:\"created_at\";s:19:\"2026-09-19 09:03:39\";s:10:\"updated_at\";s:19:\"2026-09-19 09:03:39\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:63;s:4:\"name\";s:13:\"Riwayat Aduan\";s:4:\"icon\";N;s:5:\"route\";s:12:\"aduans.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:13:\"menu_group_id\";i:26;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-19 09:04:40\";s:10:\"updated_at\";s:19:\"2026-09-19 09:04:40\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:63;s:4:\"name\";s:13:\"Riwayat Aduan\";s:4:\"icon\";N;s:5:\"route\";s:12:\"aduans.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:12:\"aduans.index\";s:13:\"menu_group_id\";i:26;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-19 09:04:40\";s:10:\"updated_at\";s:19:\"2026-09-19 09:04:40\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:8;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:9;s:4:\"name\";s:11:\"Master Data\";s:6:\"status\";i:1;s:15:\"permission_name\";s:17:\"testimonial.index\";s:4:\"icon\";s:14:\"bx-folder-open\";s:8:\"position\";i:11;s:10:\"created_at\";s:19:\"2025-07-22 00:56:19\";s:10:\"updated_at\";s:19:\"2026-08-31 02:07:27\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:9;s:4:\"name\";s:11:\"Master Data\";s:6:\"status\";i:1;s:15:\"permission_name\";s:17:\"testimonial.index\";s:4:\"icon\";s:14:\"bx-folder-open\";s:8:\"position\";i:11;s:10:\"created_at\";s:19:\"2025-07-22 00:56:19\";s:10:\"updated_at\";s:19:\"2026-08-31 02:07:27\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:40;s:4:\"name\";s:14:\"Halaman Statis\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"pages.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2025-10-21 10:46:02\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:02\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:40;s:4:\"name\";s:14:\"Halaman Statis\";s:4:\"icon\";N;s:5:\"route\";s:11:\"pages.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"pages.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2025-10-21 10:46:02\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:02\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:50;s:4:\"name\";s:7:\"Polling\";s:4:\"icon\";N;s:5:\"route\";s:10:\"poll.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"poll.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-08 06:00:45\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:23\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:50;s:4:\"name\";s:7:\"Polling\";s:4:\"icon\";N;s:5:\"route\";s:10:\"poll.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"poll.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-08 06:00:45\";s:10:\"updated_at\";s:19:\"2026-09-17 10:30:23\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:51;s:4:\"name\";s:12:\"Faq & Answer\";s:4:\"icon\";N;s:5:\"route\";s:9:\"faq.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:9:\"faq.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-08 06:04:55\";s:10:\"updated_at\";s:19:\"2026-09-08 06:04:55\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:51;s:4:\"name\";s:12:\"Faq & Answer\";s:4:\"icon\";N;s:5:\"route\";s:9:\"faq.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:9:\"faq.index\";s:13:\"menu_group_id\";i:9;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-08 06:04:55\";s:10:\"updated_at\";s:19:\"2026-09-08 06:04:55\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:9;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:2;s:4:\"name\";s:14:\"Role dan Akses\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"menu.role-permission\";s:4:\"icon\";s:17:\"bx-shield-quarter\";s:8:\"position\";i:12;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:56:50\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:2;s:4:\"name\";s:14:\"Role dan Akses\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"menu.role-permission\";s:4:\"icon\";s:17:\"bx-shield-quarter\";s:8:\"position\";i:12;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:56:50\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:2:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:2;s:4:\"name\";s:11:\"Module Role\";s:4:\"icon\";N;s:5:\"route\";s:16:\"permission.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"permission.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:37\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:2;s:4:\"name\";s:11:\"Module Role\";s:4:\"icon\";N;s:5:\"route\";s:16:\"permission.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"permission.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:37\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:3;s:4:\"name\";s:11:\"Master Role\";s:4:\"icon\";N;s:5:\"route\";s:10:\"role.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"role.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:15\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:3;s:4:\"name\";s:11:\"Master Role\";s:4:\"icon\";N;s:5:\"route\";s:10:\"role.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"role.index\";s:13:\"menu_group_id\";i:2;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:58:15\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:10;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:3;s:4:\"name\";s:10:\"Pengaturan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"menu-item.index\";s:4:\"icon\";s:6:\"bx-cog\";s:8:\"position\";i:13;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2026-09-17 10:28:38\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:3;s:4:\"name\";s:10:\"Pengaturan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"menu-item.index\";s:4:\"icon\";s:6:\"bx-cog\";s:8:\"position\";i:13;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2026-09-17 10:28:38\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:6:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Daftar Pengguna\";s:4:\"icon\";N;s:5:\"route\";s:10:\"user.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"user.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:39:25\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Daftar Pengguna\";s:4:\"icon\";N;s:5:\"route\";s:10:\"user.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:10:\"user.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:39:25\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:5;s:4:\"name\";s:15:\"Module Aplikasi\";s:4:\"icon\";N;s:5:\"route\";s:11:\"route.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"route.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:54\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:5;s:4:\"name\";s:15:\"Module Aplikasi\";s:4:\"icon\";N;s:5:\"route\";s:11:\"route.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:11:\"route.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:6;s:4:\"name\";s:12:\"Menu Manager\";s:4:\"icon\";N;s:5:\"route\";s:10:\"menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"menu-group.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:09\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:6;s:4:\"name\";s:12:\"Menu Manager\";s:4:\"icon\";N;s:5:\"route\";s:10:\"menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:16:\"menu-group.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2024-09-27 06:27:05\";s:10:\"updated_at\";s:19:\"2024-09-27 06:44:09\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:48;s:4:\"name\";s:11:\"Pesan Masuk\";s:4:\"icon\";N;s:5:\"route\";s:14:\"layanan.kontak\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"layanan.kontak\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-07 02:44:23\";s:10:\"updated_at\";s:19:\"2026-09-17 21:13:26\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:48;s:4:\"name\";s:11:\"Pesan Masuk\";s:4:\"icon\";N;s:5:\"route\";s:14:\"layanan.kontak\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"layanan.kontak\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-07 02:44:23\";s:10:\"updated_at\";s:19:\"2026-09-17 21:13:26\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:49;s:4:\"name\";s:12:\"Menu Website\";s:4:\"icon\";N;s:5:\"route\";s:18:\"website-menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"articles.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-07 03:40:53\";s:10:\"updated_at\";s:19:\"2026-09-17 20:56:47\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:49;s:4:\"name\";s:12:\"Menu Website\";s:4:\"icon\";N;s:5:\"route\";s:18:\"website-menu.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:14:\"articles.index\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:5;s:10:\"created_at\";s:19:\"2026-09-07 03:40:53\";s:10:\"updated_at\";s:19:\"2026-09-17 20:56:47\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:62;s:4:\"name\";s:19:\"Konfigurasi Website\";s:4:\"icon\";N;s:5:\"route\";s:21:\"website-identity.edit\";s:6:\"status\";i:1;s:15:\"permission_name\";s:21:\"website-identity.edit\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2026-09-18 10:00:37\";s:10:\"updated_at\";s:19:\"2026-09-18 10:00:37\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:62;s:4:\"name\";s:19:\"Konfigurasi Website\";s:4:\"icon\";N;s:5:\"route\";s:21:\"website-identity.edit\";s:6:\"status\";i:1;s:15:\"permission_name\";s:21:\"website-identity.edit\";s:13:\"menu_group_id\";i:3;s:8:\"position\";i:6;s:10:\"created_at\";s:19:\"2026-09-18 10:00:37\";s:10:\"updated_at\";s:19:\"2026-09-18 10:00:37\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:11;O:37:\"App\\Models\\ManagementAccess\\MenuGroup\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:11:\"menu_groups\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:8:{s:2:\"id\";i:24;s:4:\"name\";s:8:\"Keamanan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"menu.keamanan\";s:4:\"icon\";s:15:\"bx-shield-alt-2\";s:8:\"position\";i:14;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:8:{s:2:\"id\";i:24;s:4:\"name\";s:8:\"Keamanan\";s:6:\"status\";i:1;s:15:\"permission_name\";s:13:\"menu.keamanan\";s:4:\"icon\";s:15:\"bx-shield-alt-2\";s:8:\"position\";i:14;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:5:\"items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:4:{i:0;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:57;s:4:\"name\";s:14:\"Login Activity\";s:4:\"icon\";N;s:5:\"route\";s:29:\"security.login-activity.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"login-activity.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:57;s:4:\"name\";s:14:\"Login Activity\";s:4:\"icon\";N;s:5:\"route\";s:29:\"security.login-activity.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:20:\"login-activity.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:1;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:58;s:4:\"name\";s:9:\"Audit Log\";s:4:\"icon\";N;s:5:\"route\";s:24:\"security.audit-log.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"audit-log.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:58;s:4:\"name\";s:9:\"Audit Log\";s:4:\"icon\";N;s:5:\"route\";s:24:\"security.audit-log.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:15:\"audit-log.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:2;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:59;s:4:\"name\";s:12:\"Failed Login\";s:4:\"icon\";N;s:5:\"route\";s:27:\"security.failed-login.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:18:\"failed-login.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:59;s:4:\"name\";s:12:\"Failed Login\";s:4:\"icon\";N;s:5:\"route\";s:27:\"security.failed-login.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:18:\"failed-login.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:3;s:10:\"created_at\";s:19:\"2026-09-17 09:49:22\";s:10:\"updated_at\";s:19:\"2026-09-17 09:49:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:36:\"App\\Models\\ManagementAccess\\MenuItem\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"menu_items\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:60;s:4:\"name\";s:12:\"Blokir Login\";s:4:\"icon\";N;s:5:\"route\";s:28:\"security.login-lockout.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:19:\"login-lockout.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-17 10:25:22\";s:10:\"updated_at\";s:19:\"2026-09-17 10:25:22\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:60;s:4:\"name\";s:12:\"Blokir Login\";s:4:\"icon\";N;s:5:\"route\";s:28:\"security.login-lockout.index\";s:6:\"status\";i:1;s:15:\"permission_name\";s:19:\"login-lockout.index\";s:13:\"menu_group_id\";i:24;s:8:\"position\";i:4;s:10:\"created_at\";s:19:\"2026-09-17 10:25:22\";s:10:\"updated_at\";s:19:\"2026-09-17 10:25:22\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:4:\"name\";i:1;s:4:\"icon\";i:2;s:5:\"route\";i:3;s:6:\"status\";i:4;s:15:\"permission_name\";i:5;s:13:\"menu_group_id\";i:6;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:15:\"permission_name\";i:3;s:4:\"icon\";i:4;s:8:\"position\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 1789911975);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('spatie.permission.cache', 'a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:128:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:14:\"menu.main-menu\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:20:\"menu.role-permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:22:\"menu.access-management\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:15:\"dashboard.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:10:\"user.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:10:\"user.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:11:\"user.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:12:\"user.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:8;a:4:{s:1:\"a\";i:9;s:1:\"b\";s:16:\"menu-group.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:16:\"menu-group.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:17:\"menu-group.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:18:\"menu-group.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:15:\"menu-item.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:15:\"menu-item.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:16:\"menu-item.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:17:\"menu-item.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:11:\"route.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:11:\"route.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:12:\"route.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:13:\"route.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:10:\"role.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:10:\"role.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:11:\"role.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:12:\"role.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:16:\"permission.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:16:\"permission.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:17:\"permission.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:18:\"permission.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:11:\"faq.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:29;a:4:{s:1:\"a\";i:30;s:1:\"b\";s:9:\"faq.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:9:\"faq.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:31;a:4:{s:1:\"a\";i:32;s:1:\"b\";s:10:\"faq.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:32;a:4:{s:1:\"a\";i:33;s:1:\"b\";s:20:\"menu.main-portofolio\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:33;a:4:{s:1:\"a\";i:35;s:1:\"b\";s:13:\"company.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:34;a:4:{s:1:\"a\";i:36;s:1:\"b\";s:13:\"company.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:35;a:4:{s:1:\"a\";i:37;s:1:\"b\";s:14:\"company.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:36;a:4:{s:1:\"a\";i:38;s:1:\"b\";s:18:\"categories.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:37;a:4:{s:1:\"a\";i:39;s:1:\"b\";s:16:\"categories.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:38;a:4:{s:1:\"a\";i:40;s:1:\"b\";s:16:\"categories.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:39;a:4:{s:1:\"a\";i:41;s:1:\"b\";s:17:\"categories.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:40;a:4:{s:1:\"a\";i:46;s:1:\"b\";s:14:\"banner.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:41;a:4:{s:1:\"a\";i:47;s:1:\"b\";s:12:\"banner.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:42;a:4:{s:1:\"a\";i:48;s:1:\"b\";s:12:\"banner.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:43;a:4:{s:1:\"a\";i:49;s:1:\"b\";s:13:\"banner.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:44;a:4:{s:1:\"a\";i:50;s:1:\"b\";s:16:\"articles.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:45;a:4:{s:1:\"a\";i:51;s:1:\"b\";s:15:\"articles.create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:46;a:4:{s:1:\"a\";i:52;s:1:\"b\";s:14:\"articles.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:47;a:4:{s:1:\"a\";i:53;s:1:\"b\";s:14:\"articles.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:48;a:4:{s:1:\"a\";i:54;s:1:\"b\";s:15:\"articles.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:49;a:4:{s:1:\"a\";i:55;s:1:\"b\";s:14:\"dashboard.form\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:50;a:4:{s:1:\"a\";i:60;s:1:\"b\";s:12:\"poll.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:51;a:4:{s:1:\"a\";i:65;s:1:\"b\";s:10:\"poll.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:52;a:4:{s:1:\"a\";i:70;s:1:\"b\";s:10:\"poll.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:53;a:4:{s:1:\"a\";i:75;s:1:\"b\";s:11:\"poll.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:54;a:4:{s:1:\"a\";i:85;s:1:\"b\";s:13:\"account.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:55;a:4:{s:1:\"a\";i:90;s:1:\"b\";s:14:\"account.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:56;a:4:{s:1:\"a\";i:125;s:1:\"b\";s:27:\"document-categories.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:57;a:4:{s:1:\"a\";i:130;s:1:\"b\";s:25:\"document-categories.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:58;a:4:{s:1:\"a\";i:135;s:1:\"b\";s:25:\"document-categories.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:59;a:4:{s:1:\"a\";i:140;s:1:\"b\";s:26:\"document-categories.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:60;a:4:{s:1:\"a\";i:145;s:1:\"b\";s:14:\"layanan.kontak\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:61;a:4:{s:1:\"a\";i:146;s:1:\"b\";s:16:\"instruktur.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:62;a:4:{s:1:\"a\";i:147;s:1:\"b\";s:12:\"pages.create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:63;a:4:{s:1:\"a\";i:148;s:1:\"b\";s:13:\"pages.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:64;a:4:{s:1:\"a\";i:149;s:1:\"b\";s:11:\"pages.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:65;a:4:{s:1:\"a\";i:150;s:1:\"b\";s:11:\"pages.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:66;a:4:{s:1:\"a\";i:151;s:1:\"b\";s:12:\"pages.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:67;a:4:{s:1:\"a\";i:152;s:1:\"b\";s:18:\"instruktur.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:68;a:4:{s:1:\"a\";i:153;s:1:\"b\";s:16:\"instruktur.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:69;a:4:{s:1:\"a\";i:154;s:1:\"b\";s:17:\"instruktur.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:70;a:4:{s:1:\"a\";i:155;s:1:\"b\";s:19:\"testimonial.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:71;a:4:{s:1:\"a\";i:156;s:1:\"b\";s:17:\"testimonial.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:72;a:4:{s:1:\"a\";i:157;s:1:\"b\";s:18:\"testimonial.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:73;a:4:{s:1:\"a\";i:158;s:1:\"b\";s:17:\"testimonial.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:74;a:4:{s:1:\"a\";i:159;s:1:\"b\";s:12:\"agenda.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:75;a:4:{s:1:\"a\";i:160;s:1:\"b\";s:14:\"agenda.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:76;a:4:{s:1:\"a\";i:161;s:1:\"b\";s:12:\"agenda.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:77;a:4:{s:1:\"a\";i:162;s:1:\"b\";s:13:\"agenda.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:78;a:4:{s:1:\"a\";i:163;s:1:\"b\";s:21:\"specializations.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:79;a:4:{s:1:\"a\";i:164;s:1:\"b\";s:23:\"specializations.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:80;a:4:{s:1:\"a\";i:165;s:1:\"b\";s:22:\"specializations.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:81;a:4:{s:1:\"a\";i:166;s:1:\"b\";s:21:\"specializations.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:82;a:4:{s:1:\"a\";i:172;s:1:\"b\";s:15:\"classes.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:83;a:4:{s:1:\"a\";i:173;s:1:\"b\";s:13:\"classes.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:84;a:4:{s:1:\"a\";i:174;s:1:\"b\";s:13:\"classes.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:85;a:4:{s:1:\"a\";i:175;s:1:\"b\";s:14:\"classes.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:86;a:4:{s:1:\"a\";i:176;s:1:\"b\";s:22:\"dashboard.submitSumber\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:2;}}i:87;a:4:{s:1:\"a\";i:177;s:1:\"b\";s:14:\"classes.create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:88;a:4:{s:1:\"a\";i:178;s:1:\"b\";s:12:\"classes.edit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:89;a:4:{s:1:\"a\";i:180;s:1:\"b\";s:19:\"departments.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:90;a:4:{s:1:\"a\";i:181;s:1:\"b\";s:17:\"departments.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:91;a:4:{s:1:\"a\";i:182;s:1:\"b\";s:17:\"departments.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:92;a:4:{s:1:\"a\";i:183;s:1:\"b\";s:18:\"departments.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:93;a:4:{s:1:\"a\";i:185;s:1:\"b\";s:14:\"pengguna.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:94;a:4:{s:1:\"a\";i:186;s:1:\"b\";s:15:\"pengguna.export\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:95;a:4:{s:1:\"a\";i:187;s:1:\"b\";s:15:\"documents.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:96;a:4:{s:1:\"a\";i:188;s:1:\"b\";s:17:\"documents.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:97;a:4:{s:1:\"a\";i:189;s:1:\"b\";s:16:\"documents.create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:98;a:4:{s:1:\"a\";i:190;s:1:\"b\";s:15:\"documents.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:99;a:4:{s:1:\"a\";i:191;s:1:\"b\";s:16:\"documents.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:100;a:4:{s:1:\"a\";i:192;s:1:\"b\";s:17:\"instruktur.mobile\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:101;a:4:{s:1:\"a\";i:197;s:1:\"b\";s:13:\"menu.keamanan\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:102;a:4:{s:1:\"a\";i:198;s:1:\"b\";s:20:\"login-activity.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:103;a:4:{s:1:\"a\";i:199;s:1:\"b\";s:22:\"login-activity.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:104;a:4:{s:1:\"a\";i:200;s:1:\"b\";s:15:\"audit-log.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:105;a:4:{s:1:\"a\";i:201;s:1:\"b\";s:17:\"audit-log.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:106;a:4:{s:1:\"a\";i:202;s:1:\"b\";s:18:\"failed-login.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:107;a:4:{s:1:\"a\";i:203;s:1:\"b\";s:20:\"failed-login.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:108;a:4:{s:1:\"a\";i:204;s:1:\"b\";s:19:\"login-lockout.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:109;a:4:{s:1:\"a\";i:205;s:1:\"b\";s:21:\"login-lockout.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:110;a:4:{s:1:\"a\";i:206;s:1:\"b\";s:21:\"website-identity.edit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:111;a:4:{s:1:\"a\";i:207;s:1:\"b\";s:23:\"website-identity.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:112;a:4:{s:1:\"a\";i:208;s:1:\"b\";s:19:\"menu.website-config\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:113;a:4:{s:1:\"a\";i:209;s:1:\"b\";s:12:\"aduans.index\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:114;a:4:{s:1:\"a\";i:210;s:1:\"b\";s:12:\"aduans.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:115;a:4:{s:1:\"a\";i:211;s:1:\"b\";s:11:\"aduans.show\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:116;a:4:{s:1:\"a\";i:212;s:1:\"b\";s:13:\"aduans.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:117;a:4:{s:1:\"a\";i:213;s:1:\"b\";s:14:\"aduans.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:118;a:4:{s:1:\"a\";i:214;s:1:\"b\";s:13:\"aduans.create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:5;}}i:119;a:4:{s:1:\"a\";i:215;s:1:\"b\";s:11:\"aduans.edit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:120;a:4:{s:1:\"a\";i:216;s:1:\"b\";s:14:\"aduans.restore\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:121;a:4:{s:1:\"a\";i:217;s:1:\"b\";s:18:\"aduans.forceDelete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:122;a:4:{s:1:\"a\";i:218;s:1:\"b\";s:25:\"aduans.tindaklanjut.store\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:123;a:4:{s:1:\"a\";i:219;s:1:\"b\";s:27:\"aduans.tindaklanjut.destroy\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}i:124;a:4:{s:1:\"a\";i:220;s:1:\"b\";s:13:\"aduans.export\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:125;a:4:{s:1:\"a\";i:221;s:1:\"b\";s:12:\"aduans.arsip\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:126;a:4:{s:1:\"a\";i:222;s:1:\"b\";s:17:\"aduans.batalArsip\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:127;a:4:{s:1:\"a\";i:223;s:1:\"b\";s:11:\"health.page\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:5;}}}s:5:\"roles\";a:4:{i:0;a:3:{s:1:\"a\";i:1;s:1:\"b\";s:11:\"super-admin\";s:1:\"c\";s:3:\"web\";}i:1;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:5:\"admin\";s:1:\"c\";s:3:\"web\";}i:2;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:4:\"user\";s:1:\"c\";s:3:\"web\";}i:3;a:3:{s:1:\"a\";i:5;s:1:\"b\";s:4:\"uptd\";s:1:\"c\";s:3:\"web\";}}}', 1789956935),
('visitor_buffer_2026-09-20 10:35', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:21:\"http://localhost:8000\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"10:35:26\";}}', 1789875926),
('visitor_buffer_2026-09-20 10:35_count', 'i:1;', 1789875926),
('visitor_buffer_2026-09-20 12:36', 'a:2:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:131:\"Mozilla/5.0 (iPhone; CPU iPhone OS 27 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/27 Mobile/15E148 Safari/604.1\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:6:\"mobile\";s:2:\"br\";s:6:\"Safari\";s:2:\"os\";s:5:\"macOS\";s:4:\"time\";s:8:\"12:36:16\";}i:1;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:131:\"Mozilla/5.0 (iPhone; CPU iPhone OS 27 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/27 Mobile/15E148 Safari/604.1\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:6:\"mobile\";s:2:\"br\";s:6:\"Safari\";s:2:\"os\";s:5:\"macOS\";s:4:\"time\";s:8:\"12:36:17\";}}', 1789883177),
('visitor_buffer_2026-09-20 12:36_count', 'i:2;', 1789883177),
('visitor_buffer_2026-09-20 13:03', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:29:\"http://localhost:8000/profile\";s:3:\"ref\";s:39:\"http://localhost:8000/backend/dashboard\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"13:03:36\";}}', 1789884816),
('visitor_buffer_2026-09-20 13:03_count', 'i:1;', 1789884816),
('visitor_buffer_2026-09-20 13:19', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:29:\"http://localhost:8000/profile\";s:3:\"ref\";s:39:\"http://localhost:8000/backend/dashboard\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"13:19:24\";}}', 1789885764),
('visitor_buffer_2026-09-20 13:19_count', 'i:1;', 1789885764),
('visitor_buffer_2026-09-20 13:20', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:29:\"http://localhost:8000/profile\";s:3:\"ref\";s:39:\"http://localhost:8000/backend/dashboard\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"13:20:03\";}}', 1789885803),
('visitor_buffer_2026-09-20 13:20_count', 'i:1;', 1789885803),
('visitor_buffer_2026-09-20 13:21', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:29:\"http://localhost:8000/profile\";s:3:\"ref\";s:39:\"http://localhost:8000/backend/dashboard\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"13:21:51\";}}', 1789885911),
('visitor_buffer_2026-09-20 13:21_count', 'i:1;', 1789885911),
('visitor_buffer_2026-09-20 13:22', 'a:3:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:29:\"http://localhost:8000/profile\";s:3:\"ref\";s:39:\"http://localhost:8000/backend/dashboard\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"13:22:03\";}i:1;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:29:\"http://localhost:8000/profile\";s:3:\"ref\";s:39:\"http://localhost:8000/backend/dashboard\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"13:22:19\";}i:2;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:29:\"http://localhost:8000/profile\";s:3:\"ref\";s:39:\"http://localhost:8000/backend/dashboard\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"13:22:48\";}}', 1789885968),
('visitor_buffer_2026-09-20 13:22_count', 'i:3;', 1789885968),
('visitor_buffer_2026-09-20 13:23', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:29:\"http://localhost:8000/profile\";s:3:\"ref\";s:39:\"http://localhost:8000/backend/dashboard\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"13:23:27\";}}', 1789886007),
('visitor_buffer_2026-09-20 13:23_count', 'i:1;', 1789886007),
('visitor_buffer_2026-09-20 16:09', 'a:4:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"16:09:21\";}i:1;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"16:09:32\";}i:2;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:72:\"http://localhost:8000/captcha-file/flat?17898953720240.6912385539598936=\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"16:09:33\";}i:3;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:29:\"http://localhost:8000/profile\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"16:09:39\";}}', 1789895979),
('visitor_buffer_2026-09-20 16:09_count', 'i:4;', 1789895979),
('visitor_buffer_2026-09-20 18:16', 'a:4:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"18:16:16\";}i:1;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"18:16:31\";}i:2;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"18:16:34\";}i:3;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"18:16:38\";}}', 1789903598),
('visitor_buffer_2026-09-20 18:16_count', 'i:4;', 1789903598),
('visitor_buffer_2026-09-20 18:17', 'a:4:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"18:17:04\";}i:1;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:29:\"http://localhost:8000/lang/id\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"18:17:12\";}i:2;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"18:17:13\";}i:3;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:72:\"http://localhost:8000/captcha-file/flat?17899030742160.7972452145391303=\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"18:17:55\";}}', 1789903675),
('visitor_buffer_2026-09-20 18:17_count', 'i:4;', 1789903675),
('visitor_buffer_2026-09-20 18:22', 'a:3:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"18:22:02\";}i:1;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"18:22:12\";}i:2;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:72:\"http://localhost:8000/captcha-file/flat?17899033312060.5689910623781067=\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"18:22:13\";}}', 1789903933),
('visitor_buffer_2026-09-20 18:22_count', 'i:3;', 1789903933),
('visitor_buffer_2026-09-20 19:07', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"19:07:11\";}}', 1789906631),
('visitor_buffer_2026-09-20 19:07_count', 'i:1;', 1789906631),
('visitor_buffer_2026-09-20 19:40', 'a:3:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"19:40:43\";}i:1;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"19:40:51\";}i:2;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:74:\"http://localhost:8000/captcha-file/flat?17899080513370.023487434080426084=\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"19:40:51\";}}', 1789908651),
('visitor_buffer_2026-09-20 19:40_count', 'i:3;', 1789908651),
('visitor_buffer_2026-09-20 20:36', 'a:1:{i:0;a:8:{s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:111:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36\";s:3:\"url\";s:39:\"http://localhost:8000/captcha-file/flat\";s:3:\"ref\";s:32:\"http://localhost:8000/auth/login\";s:2:\"dt\";s:7:\"desktop\";s:2:\"br\";s:6:\"Chrome\";s:2:\"os\";s:13:\"Windows 10/11\";s:4:\"time\";s:8:\"20:36:04\";}}', 1789911964),
('visitor_buffer_2026-09-20 20:36_count', 'i:1;', 1789911964);

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
('2162d145-9ef3-4e2f-8c55-81971a015bc5', 'Berita', 'berita', 'Informasi terkini seputar program, kebijakan, dan perkembangan BMSDA.', 'fa-newspaper', '2025-09-16 01:03:22', '2026-09-19 05:49:54'),
('34103609-8116-4baf-bd17-557fc6989e8e', 'Pemeliharaan', 'pemeliharaan', 'Perbaikan dan pemeliharaan infrastruktur.', 'fa-screwdriver-wrenc', '2025-09-16 01:03:16', '2026-09-19 05:51:07'),
('72561291-cdcb-484b-a556-0400fbd53c3d', 'Pembangunan', 'pembangunan', 'Perkembangan pembangunan infrastruktur daerah.', 'fa-road', '2025-10-31 03:07:08', '2026-09-19 05:50:48'),
('a58f5ebc-c8ec-48da-b6f9-a80b05ca40a0', 'Kegiatan', 'kegiatan', 'Informasi event, workshop, retreat, dan berbagai kegiatan YogaRoots.', 'fa-calendar-days', '2026-06-20 12:47:44', '2026-08-27 04:18:24');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `uuid` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`uuid`, `name`, `slug`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
('0086e252-bbd0-4336-ae7d-f567c333b912', 'Kepala Dinas', 'kepala-dinas', 'Membantu Wali Kota dalam memimpin, mengendalikan, dan mengkoordinasikan perumusan kebijakan teknis dan pelaksanaan fungsi urusan Pemerintahan yang menjadi kewenangan Dinas', 'active', '2026-09-18 21:06:24', '2026-09-18 21:11:40'),
('1b923b59-9521-4f53-b420-6eb2acc6eaf7', 'Sekretaris Dinas', 'sekretaris-dinas', 'Membantu Kepala Dinas dalam mengoordinasikan administrasi, perencanaan, kepegawaian, keuangan, umum, serta pelaporan dan ketatausahaan dinas.', 'active', '2026-09-18 21:06:44', '2026-09-18 21:06:44'),
('2275378a-6fb0-4ce9-89a4-9eedcb6ed3a9', 'Kepala Bidang Bina Marga', 'kepala-bidang-bina-marga', 'Memimpin dan mengoordinasikan pelaksanaan program serta kegiatan yang berkaitan dengan pembangunan, pemeliharaan, dan pengelolaan jaringan jalan serta infrastruktur pendukungnya.', 'active', '2026-09-18 21:07:00', '2026-09-18 21:07:00'),
('32d70d3b-86dd-40b3-8806-31a7b8e7aea4', 'Kepala Bidang Sumber Daya Air', 'kepala-bidang-sumber-daya-air', 'Memimpin dan mengoordinasikan pengelolaan sumber daya air, termasuk perencanaan, pembangunan, pemeliharaan, dan pengawasan infrastruktur sumber daya air.', 'active', '2026-09-18 21:07:20', '2026-09-18 21:07:20'),
('5cf14a8c-93b8-420a-9047-581e9e711485', 'Kepala Bidang Perencanaan dan Jasa Konstruks', 'kepala-bidang-perencanaan-dan-jasa-konstruks', 'Mengkoordinasikan perencanaan pembangunan serta pembinaan dan pengelolaan jasa konstruksi untuk mendukung pelaksanaan pembangunan infrastruktur yang efektif dan sesuai ketentuan.', 'active', '2026-09-18 21:07:42', '2026-09-18 21:07:42'),
('d787e904-1ca1-494e-a8e2-e6bfd90c0b71', 'Kepala Bidang Prasarana Jalan', 'kepala-bidang-prasarana-jalan', 'Memimpin dan mengoordinasikan perencanaan, pembangunan, pemeliharaan, serta pengelolaan prasarana jalan untuk mendukung kelancaran dan keselamatan transportasi.', 'active', '2026-09-18 21:08:01', '2026-09-18 21:08:01');

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

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`uuid`, `category_uuid`, `title`, `slug`, `excerpt`, `description`, `published_at`, `file`, `thumbnail`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
('01a0beea-4a72-723e-a71b-5f20668c45b1', 'a6d14f40-5032-40dc-9ef2-349d4300636f', 'Indeks Kepuasan Masyarakat', 'indeks-kepuasan-masyarakat', 'Indeks Kepuasan Masyarakat', 'Indeks Kepuasan Masyarakat', '2021-09-21', 'documents/files/F7zMS5DOuHBcyaZIUiT5k4h5OFG69vxj3JT8Vhvh.pdf', NULL, 'active', '2026-09-20 13:03:00', '2026-09-20 13:03:00', NULL),
('08345d10-9bf6-4571-8f0e-14fd75fccb84', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'SK Tim LKIP DBMSDA 2023', 'sk-tim-lkip-dbmsda-2023', 'SK Tim LKIP DBMSDA 2023', 'SK Tim LKIP DBMSDA 2023', '2024-06-06', 'documents/files/8d2a258198847947486c3e2959d01e51.pdf', NULL, 'active', '2024-06-06 08:30:00', '2024-06-06 08:30:00', NULL),
('09aff4d5-6fc5-4e1f-b22a-292eab42107a', 'b72c0399-3cb1-468c-97f7-0080aff97343', 'IKU 2021', 'iku-2021', 'IKU 2021', 'IKU 2021', '2021-09-20', 'documents/files/9566dd1182b6062ddacd80003225915e.pdf9566dd1182b6062ddacd80003225915e.pdf', NULL, 'active', '2021-09-19 17:04:00', '2021-09-19 17:04:00', NULL),
('27ac0c40-437b-4e59-908f-fcb4bd90699f', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'RKA-SKPD TA 2022', 'rka-skpd-ta-2022', 'RKA-SKPD TA 2022', 'RKA-SKPD TA 2022', '2024-06-04', 'documents/files/a2be3383de4f86bbd1d36474247376e9.pdf', NULL, 'active', '2024-06-04 05:01:00', '2024-06-04 05:01:00', NULL),
('301fde9a-7d05-45b6-9163-4341f6158a45', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'PERWAL Kota Bekasi Ttg Daftar Informasi Publik di Lingkungan Pemkot Bekasi', 'perwal-kota-bekasi-ttg-daftar-informasi-publik-di-lingkungan-pemkot-bekasi', 'PERWAL Kota Bekasi Ttg Daftar Informasi Publik di Lingkungan Pemkot Bekasi', 'PERWAL Kota Bekasi Ttg Daftar Informasi Publik di Lingkungan Pemkot Bekasi', '2024-06-20', 'documents/files/e40c5184ef8cbdf6fc9ce45ed10e45ad.pdf', NULL, 'active', '2024-06-20 06:21:00', '2024-06-20 06:21:00', NULL),
('4be897a4-2f34-4ceb-914a-e6f5c8e4fb8d', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'SIRUP KEGIATAN - Pembangunan Polder Griya Bintara Indah', 'sirup-kegiatan-pembangunan-polder-griya-bintara-indah', 'SIRUP KEGIATAN - Pembangunan Polder Griya Bintara Indah', 'SIRUP KEGIATAN - Pembangunan Polder Griya Bintara Indah', '2025-09-09', 'documents/files/34d7e8e30fca5a44f441678e1437bcb1.pdf', NULL, 'active', '2025-09-09 03:53:00', '2025-09-09 03:53:00', NULL),
('4c7cee01-9169-4a4a-af6f-e67ae5c34a03', 'b271e039-1a0e-4bc7-b0b0-810d3e61b402', 'LKIP DBMSDA 2020', 'lkip-dbmsda-2020', 'LKIP DBMSDA 2020', 'LKIP DBMSDA 2020', '2021-09-19', 'documents/files/9867ce1ae9230203fbe5d242f7432b2d.pdf', NULL, 'active', '2021-09-19 01:19:00', '2021-09-19 01:19:00', NULL),
('524f4750-fdd5-4380-a44e-7bbb11c7605c', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'dasd', 'dasd-2', 'dasd', 'dasd', '2024-06-04', 'documents/files/ec277f2e5f72da1f516265340469fe38.pdf', NULL, 'active', '2024-06-04 05:45:00', '2024-06-04 05:45:00', NULL),
('538cdbe6-b4de-4d6f-a33c-d0114bbd322c', 'b72c0399-3cb1-468c-97f7-0080aff97343', 'IKU 2025', 'iku-2025', 'IKU 2025', 'IKU 2025', '2025-07-01', 'documents/files/a7f89a620988a60e5121eac4de244ab5.pdf', NULL, 'active', '2025-07-01 05:06:00', '2025-07-01 05:06:00', NULL),
('574539f1-784a-4288-b80b-ce6d7c4e871c', 'b271e039-1a0e-4bc7-b0b0-810d3e61b402', 'LKIP 2022', 'lkip-2022', 'LKIP 2022', 'LKIP 2022', '2023-08-18', 'documents/files/af0108f5cc454610dfc086a51dba0e8d.pdf', NULL, 'active', '2023-08-18 07:00:00', '2023-08-18 07:00:00', NULL),
('60eda24c-27be-4cf0-a4f0-d59b43383e73', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'PENERBITAN REKOMENDASI TEKNIS PEIL BANJIR', 'penerbitan-rekomendasi-teknis-peil-banjir', 'PENERBITAN REKOMENDASI TEKNIS PEIL BANJIR', 'PENERBITAN REKOMENDASI TEKNIS PEIL BANJIR', '2026-09-15', 'documents/files/7b21df61cf1a86ac01816b17abce1a14.pdf', NULL, 'active', '2026-09-14 19:56:00', '2026-09-14 19:56:00', NULL),
('663c8317-f1d7-42fc-82c7-4ff7142cb786', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'DPA 2025', 'dpa-2025', 'DPA 2025', 'DPA 2025', '2025-10-13', 'documents/files/e6f1d6056651e1f90cf7c054e820fe75.pdf', NULL, 'active', '2025-10-13 08:41:00', '2025-10-13 08:41:00', NULL),
('8179c22d-fc2b-4667-adfd-23c8826a0c00', 'b72c0399-3cb1-468c-97f7-0080aff97343', 'IKU 2024', 'iku-2024', 'IKU 2024', 'IKU 2024', '2024-05-28', 'documents/files/edb13c2976db276df0b64be017d599e3.pdf', NULL, 'active', '2024-05-28 09:44:00', '2024-05-28 09:44:00', NULL),
('8ca25113-37d4-45e7-9f74-0980ee2bb641', 'b72c0399-3cb1-468c-97f7-0080aff97343', 'IKU 2026', 'iku-2026', 'IKU 2026', 'IKU 2026', '2026-06-25', 'documents/files/c94bca26ee6ead9be838e62a42694664.pdf', NULL, 'active', '2026-06-25 08:37:00', '2026-06-25 08:37:00', NULL),
('8cafe7c8-fbfe-425c-a1fb-fb492d0b0ea2', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'DAFTAR KEGIATAN STRATEGIS DAERAH  TAHUN ANGGARAN 2025', 'daftar-kegiatan-strategis-daerah-tahun-anggaran-2025', 'DAFTAR KEGIATAN STRATEGIS DAERAH  TAHUN ANGGARAN 2025', 'DAFTAR KEGIATAN STRATEGIS DAERAH  TAHUN ANGGARAN 2025', '2025-10-13', 'documents/files/f9644d928285a77b922bf648193d751c.pdf', NULL, 'active', '2025-10-13 10:02:00', '2025-10-13 10:02:00', NULL),
('988a97b5-27aa-4754-b0c4-f0cdf2d1005c', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'LHKPN  Kepala Bidang Prasarana Ruang  Jalan dan Taman Tahun 2025', 'lhkpn-kepala-bidang-prasarana-ruang-jalan-dan-taman-tahun-2025', 'LHKPN  Kepala Bidang Prasarana Ruang  Jalan dan Taman Tahun 2025', 'LHKPN  Kepala Bidang Prasarana Ruang  Jalan dan Taman Tahun 2025', '2025-10-13', 'documents/files/1c76ca0d0f83098b56b4bacb8999ffd7.pdf', NULL, 'active', '2025-10-13 08:31:00', '2025-10-13 08:31:00', NULL),
('aa14857d-07f7-4316-aa7f-401c98caa5b3', 'b698befd-73c3-490c-be44-bf7a0f4b9a35', 'PERJANJIAN KINERJA 2022', 'perjanjian-kinerja-2022', 'PERJANJIAN KINERJA 2022', 'PERJANJIAN KINERJA 2022', '2022-09-07', 'documents/files/b49160eeece1e1e9245c6a3cc5fb4398.pdf', NULL, 'active', '2022-09-07 04:58:00', '2022-09-07 04:58:00', NULL),
('ac7647ff-300a-40dc-8940-d187eef3108b', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'PERWAL Kota Bekasi No.53 Tahun 2023 Tentang Sistem Dan Prosedur Pengelolaan Keuangan Daerah', 'perwal-kota-bekasi-no53-tahun-2023-tentang-sistem-dan-prosedur-pengelolaan-keuangan-daerah', 'PERWAL Kota Bekasi No.53 Tahun 2023 Tentang Sistem Dan Prosedur Pengelolaan Keuangan Daerah', 'PERWAL Kota Bekasi No.53 Tahun 2023 Tentang Sistem Dan Prosedur Pengelolaan Keuangan Daerah', '2024-06-20', 'documents/files/a10930af5fa80c534f864b9a9701e62e.pdf', NULL, 'active', '2024-06-20 05:50:00', '2024-06-20 05:50:00', NULL),
('acd4b1d0-d455-455f-8a11-fc932a9b7c7a', 'b698befd-73c3-490c-be44-bf7a0f4b9a35', 'PERKIN 2025', 'perkin-2025', 'PERKIN 2025', 'PERKIN 2025', '2025-07-01', 'documents/files/47e32615a4e8dab35e39397fa64b57f0.pdf', NULL, 'active', '2025-07-01 05:13:00', '2025-07-01 05:13:00', NULL),
('b3df8443-75a0-4155-97dd-f5c306786fff', '26dcc275-4817-4a5a-bdba-9f14cac83c5e', 'renstra 2025 - 2029', 'renstra-2025-2029', 'renstra 2025 - 2029', 'renstra 2025 - 2029', '2026-06-25', 'documents/files/8fdcdb1d80173183f9600f250bf64705.pdf', NULL, 'active', '2026-06-25 08:42:00', '2026-06-25 08:42:00', NULL),
('b527d42b-56c0-428f-9ad5-da83f2a56d1a', 'b271e039-1a0e-4bc7-b0b0-810d3e61b402', 'LKIP 2024', 'lkip-2024', 'LKIP 2024', 'LKIP 2024', '2025-07-01', 'documents/files/b0bbaa749734bc9af4ad0819f4ec2899.pdf', NULL, 'active', '2025-07-01 05:15:00', '2025-07-01 05:15:00', NULL),
('bda05e70-6bef-47bc-908b-f8fd582dd8a7', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'PERWAL SOTK DBMSDA', 'perwal-sotk-dbmsda', 'PERWAL SOTK DBMSDA', 'PERWAL SOTK DBMSDA', '2025-09-19', 'documents/files/9a4c60a4a6ea12a6043c665028c6c12f.pdf', NULL, 'active', '2025-09-19 06:23:00', '2025-09-19 06:23:00', NULL),
('be06a494-1b7e-47c5-aaf4-00f65adc5023', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'Standar pelayanan Dinas Bina Marga dan Sumber Daya Air', 'standar-pelayanan-dinas-bina-marga-dan-sumber-daya-air', 'Standar pelayanan Dinas Bina Marga dan Sumber Daya Air', 'Standar pelayanan Dinas Bina Marga dan Sumber Daya Air', '2024-06-10', 'documents/files/732f22644a53d343853946544cfe438f.pdf', NULL, 'active', '2024-06-10 08:38:00', '2024-06-10 08:38:00', NULL),
('be613cba-1e01-4c8f-8735-58fcf22c3869', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'dasd', 'dasd', 'dasd', 'dasd', '2024-06-04', 'documents/files/4c698420fdfe874e655951ff7f894dd5.pdf', NULL, 'active', '2024-06-04 05:44:00', '2024-06-04 05:44:00', NULL),
('bfda0dd2-c33d-4391-b8de-6e5d9a4163fb', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'SIRUP KEGIATAN - Pembangunan Jembatan Sisi Selatan Pangeran Jayakarta', 'sirup-kegiatan-pembangunan-jembatan-sisi-selatan-pangeran-jayakarta', 'SIRUP KEGIATAN - Pembangunan Jembatan Sisi Selatan Pangeran Jayakarta', 'SIRUP KEGIATAN - Pembangunan Jembatan Sisi Selatan Pangeran Jayakarta', '2025-09-09', 'documents/files/55d62475963f56610329b7a038c1b980.pdf', NULL, 'active', '2025-09-09 03:44:00', '2025-09-09 03:44:00', NULL),
('c63d02df-dd90-4f34-8310-4fa97caa67db', 'b271e039-1a0e-4bc7-b0b0-810d3e61b402', 'LKIP 2025', 'lkip-2025', 'LKIP 2025', 'LKIP 2025', '2026-06-25', 'documents/files/1489801cf63cd28b894f32cbca524bcd.pdf', NULL, 'active', '2026-06-25 08:39:00', '2026-06-25 08:39:00', NULL),
('c6b2243d-1725-4715-82bb-d4f341ddbea8', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'RKA-SKPD', 'rka-skpd', 'RKA-SKPD', 'RKA-SKPD', '2024-06-04', 'documents/files/11ce5cda5f8360c6b31813059d75db07.pdf', NULL, 'active', '2024-06-04 04:59:00', '2024-06-04 04:59:00', NULL),
('c6f3e96c-ae95-4ec6-a2d9-2f2c8e3ab8e4', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'RKAP SKPD 2018', 'rkap-skpd-2018', 'RKAP SKPD 2018', 'RKAP SKPD 2018', '2024-06-04', 'documents/files/b7305b4b53388056786b9c300f4ba247.pdf', NULL, 'active', '2024-06-04 05:43:00', '2024-06-04 05:43:00', NULL),
('c7c40d7a-d2b8-4a77-9bad-695a3d629f77', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'LHKPN  Kepala Bidang Perencanaan Jasa Kontruksi  Tahun 2025', 'lhkpn-kepala-bidang-perencanaan-jasa-kontruksi-tahun-2025', 'LHKPN  Kepala Bidang Perencanaan Jasa Kontruksi  Tahun 2025', 'LHKPN  Kepala Bidang Perencanaan Jasa Kontruksi  Tahun 2025', '2025-10-13', 'documents/files/a38da092a6fd33caf7da53233cdc75fd.pdf', NULL, 'active', '2025-10-13 08:33:00', '2025-10-13 08:33:00', NULL),
('c7e9ab6f-691e-43b0-8c30-2dab55ede04c', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'Informasi yang dikecualikan', 'informasi-yang-dikecualikan', 'Informasi yang dikecualikan', 'Informasi yang dikecualikan', '2026-09-04', 'documents/files/354165aa3b95a41b32e39e5e12ccf2f3.pdf', NULL, 'active', '2026-09-03 23:59:00', '2026-09-03 23:59:00', NULL),
('cb29baf3-560a-4be9-bfc6-b2292820462f', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'PERATURAN WALI KOTA BEKASI NOMOR 122 TAHUN 2021  - SOTK DBMSDA', 'peraturan-wali-kota-bekasi-nomor-122-tahun-2021-sotk-dbmsda', 'PERATURAN WALI KOTA BEKASI NOMOR 122 TAHUN 2021  - SOTK DBMSDA', 'PERATURAN WALI KOTA BEKASI NOMOR 122 TAHUN 2021  - SOTK DBMSDA', '2024-06-28', 'documents/files/a6393f47e3d5b73ab618612b995c889f.pdf', NULL, 'active', '2024-06-28 08:10:00', '2024-06-28 08:10:00', NULL),
('cc37ba07-838f-4ca2-8382-b9ee12749546', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'LHKPN Plt.Kepala Dinas BMSDA 2025', 'lhkpn-pltkepala-dinas-bmsda-2025', 'LHKPN Plt.Kepala Dinas BMSDA 2025', 'LHKPN Plt.Kepala Dinas BMSDA 2025', '2025-10-09', 'documents/files/045136a33ad826633d77b9f2fb3eac8b.pdf', NULL, 'active', '2025-10-09 07:08:00', '2025-10-09 07:08:00', NULL),
('cdc9c367-f92c-4144-bb1a-77ad79ee5dbf', '26dcc275-4817-4a5a-bdba-9f14cac83c5e', 'renstra 2024 - 2026', 'renstra-2024-2026', 'renstra 2024 - 2026', 'renstra 2024 - 2026', '2024-05-28', 'documents/files/f5bbd36db8eab2155b04289b3b98d7f5.pdf', NULL, 'active', '2024-05-28 09:42:00', '2024-05-28 09:42:00', NULL),
('d631770d-4f33-432f-a293-93bb0703b74f', 'b72c0399-3cb1-468c-97f7-0080aff97343', 'IKU 2023', 'iku-2023', 'IKU 2023', 'IKU 2023', '2023-08-18', 'documents/files/f9eafe9f2c6d3ac765b10b9d27683b7e.pdf', NULL, 'active', '2023-08-18 09:27:00', '2023-08-18 09:27:00', NULL),
('d68c52fc-8843-42a1-990d-a18c748ec21b', '26dcc275-4817-4a5a-bdba-9f14cac83c5e', 'RENSTRA TA 2018-2023', 'renstra-ta-2018-2023', 'RENSTRA TA 2018-2023', 'RENSTRA TA 2018-2023', '2021-09-20', 'documents/files/0f67ed9ff05e59c818c63aa35fdbc2f2.pdf', NULL, 'active', '2021-09-19 17:08:00', '2021-09-19 17:08:00', NULL),
('d92e0570-443d-4ecd-873c-bf823716a20d', 'b698befd-73c3-490c-be44-bf7a0f4b9a35', 'PERKIN 2024', 'perkin-2024', 'PERKIN 2024', 'PERKIN 2024', '2024-05-28', 'documents/files/ec7dd340a3f4186ba64024e416f26659.pdf', NULL, 'active', '2024-05-28 09:45:00', '2024-05-28 09:45:00', NULL),
('dd98bea9-9afa-4e7b-a98c-f14ea183043e', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'Instruksi Walikota Ttg Program Pengendalian Gratifikasi Di Lingkungan Pemerintah Kota Bekasi Th. 2024', 'instruksi-walikota-ttg-program-pengendalian-gratifikasi-di-lingkungan-pemerintah-kota-bekasi-th-2024', 'Instruksi Walikota Ttg Program Pengendalian Gratifikasi Di Lingkungan Pemerintah Kota Bekasi Th. 2024', 'Instruksi Walikota Ttg Program Pengendalian Gratifikasi Di Lingkungan Pemerintah Kota Bekasi Th. 2024', '2024-06-10', 'documents/files/fc487dad072d1cc34e20f6c8941ba10e.pdf', NULL, 'active', '2024-06-10 05:14:00', '2024-06-10 05:14:00', NULL),
('e150373c-49b2-4b93-927f-32355c229e15', 'b271e039-1a0e-4bc7-b0b0-810d3e61b402', 'LKIP 2023', 'lkip-2023', 'LKIP 2023', 'LKIP 2023', '2024-05-28', 'documents/files/c07df7b148384571c345b0f2c1eca3c0.pdf', NULL, 'active', '2024-05-28 09:49:00', '2024-05-28 09:49:00', NULL),
('e357fc2e-6a51-4503-a6fe-6214a7dad7fd', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'Laporan Pelayanan Informasi Publik Ta 2023', 'laporan-pelayanan-informasi-publik-ta-2023', 'Laporan Pelayanan Informasi Publik Ta 2023', 'Laporan Pelayanan Informasi Publik Ta 2023', '2024-06-06', 'documents/files/b15662ce3309c2cb2742410b2d655225.pdf', NULL, 'active', '2024-06-06 08:19:00', '2024-06-06 08:19:00', NULL),
('e3b8abdb-51f5-458f-abc8-bdf821a5ab39', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'LHKPN  Kepala Bidang Bina Marga Tahun 2025', 'lhkpn-kepala-bidang-bina-marga-tahun-2025', 'LHKPN  Kepala Bidang Bina Marga Tahun 2025', 'LHKPN  Kepala Bidang Bina Marga Tahun 2025', '2025-10-13', 'documents/files/f2e3442ef1302f1853b8aaf0f25a4a9d.pdf', NULL, 'active', '2025-10-13 08:34:00', '2025-10-13 08:34:00', NULL),
('e4c2eec5-6d0b-4893-9fd9-67f9a8214f2e', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'RKA SKPD', 'rka-skpd-2', 'RKA SKPD', 'RKA SKPD', '2024-06-04', 'documents/files/364a37518809a0d86a7bb04d7ca6039f.pdf', NULL, 'active', '2024-06-04 05:47:00', '2024-06-04 05:47:00', NULL),
('e95ddb90-e737-4ee2-8922-2abe050b9d39', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'KEPUTUSAN WALIKOTA BEKASI NOMOR : 488/KEP. 353.HUM/VIII/2023', 'keputusan-walikota-bekasi-nomor-488kep-353humviii2023', 'KEPUTUSAN WALIKOTA BEKASI NOMOR : 488/KEP. 353.HUM/VIII/2023', 'KEPUTUSAN WALIKOTA BEKASI NOMOR : 488/KEP. 353.HUM/VIII/2023', '2024-05-31', 'documents/files/3cd78cbee28006662ed9b2871c64261d.pdf', NULL, 'active', '2024-05-31 03:44:00', '2024-05-31 03:44:00', NULL),
('ee287a24-5d17-4923-8d85-b27028add682', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'PENERBITAN REKOMENDASI TEKNIS PEMANFAATAN RUANG JALAN', 'penerbitan-rekomendasi-teknis-pemanfaatan-ruang-jalan', 'PENERBITAN REKOMENDASI TEKNIS PEMANFAATAN RUANG JALAN', 'PENERBITAN REKOMENDASI TEKNIS PEMANFAATAN RUANG JALAN', '2026-09-15', 'documents/files/6c090c25ab293b7617e76c513a880e3c.pdf', NULL, 'active', '2026-09-14 19:56:00', '2026-09-14 19:56:00', NULL),
('f3c968c6-3e75-447f-98e4-f0c11d2ffbd7', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'SK Renja DBMSDA Tahun 2023', 'sk-renja-dbmsda-tahun-2023', 'SK Renja DBMSDA Tahun 2023', 'SK Renja DBMSDA Tahun 2023', '2024-06-06', 'documents/files/9e8145a6613161085eb615b7bc97e4ee.pdf', NULL, 'active', '2024-06-06 08:25:00', '2024-06-06 08:25:00', NULL),
('fa7289ac-0e8d-4b2a-a5d8-4f332d8d70d9', '01a9274f-003b-4ebc-b62a-b22f1091afd5', 'SK Renstra DBMSDA 2024 - 2025', 'sk-renstra-dbmsda-2024-2025', 'SK Renstra DBMSDA 2024 - 2025', 'SK Renstra DBMSDA 2024 - 2025', '2024-06-06', 'documents/files/82764b72d7e61f6267dea54698813083.pdf', NULL, 'active', '2024-06-06 08:29:00', '2024-06-06 08:29:00', NULL);

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
('01a9274f-003b-4ebc-b62a-b22f1091afd5', 'Dokumen Lainnya', 'dokumen-lainnya', 'Dokumen pendukung lainnya yang berkaitan dengan tugas dan fungsi organisasi.', 'active', '2026-09-15 16:14:43', '2026-09-15 16:14:43'),
('26dcc275-4817-4a5a-bdba-9f14cac83c5e', 'Renstra', 'renstra', 'Dokumen perencanaan strategis organisasi untuk periode tertentu.', 'active', '2026-09-15 16:09:17', '2026-09-15 16:12:33'),
('8a16898c-5241-43e3-9ae1-e9f266c3218d', 'Renja', 'renja', 'Dokumen rencana kerja organisasi untuk satu tahun.', 'active', '2026-09-15 16:12:44', '2026-09-15 16:12:44'),
('8ca91919-83d6-44d1-bf95-a10fb30ba0ff', 'Rencana Aksi', 'rencana-aksi', 'Dokumen rencana kegiatan untuk mencapai target kinerja.', 'active', '2026-09-15 16:13:32', '2026-09-15 16:13:32'),
('9c0c6f74-224c-4af9-b1cf-dd9d46a8c685', 'Pelayanan Publik', 'pelayanan-publik', 'Dokumen terkait penyelenggaraan dan peningkatan kualitas pelayanan publik.', 'active', '2026-09-15 16:14:05', '2026-09-15 16:14:05'),
('a6d14f40-5032-40dc-9ef2-349d4300636f', 'IKM', 'ikm', 'Indeks Kepuasan Masyarakat', 'active', '2026-09-20 13:02:23', '2026-09-20 13:02:23'),
('a84fba50-51ca-4130-83d9-46cee3f242d6', 'Evaluasi Kinerja', 'evaluasi-kinerja', 'Dokumen hasil evaluasi terhadap pencapaian kinerja organisasi.', 'active', '2026-09-15 16:13:44', '2026-09-15 16:13:44'),
('b271e039-1a0e-4bc7-b0b0-810d3e61b402', 'LKIP', 'lkip', 'Dokumen laporan pencapaian dan pertanggungjawaban kinerja organisasi.', 'active', '2026-09-15 16:13:22', '2026-09-15 16:13:22'),
('b698befd-73c3-490c-be44-bf7a0f4b9a35', 'Perjanjian Kinerja', 'perjanjian-kinerja', 'Dokumen komitmen pencapaian target kinerja organisasi.', 'active', '2026-09-15 16:13:09', '2026-09-15 16:13:09'),
('b72c0399-3cb1-468c-97f7-0080aff97343', 'IKU', 'iku', 'Dokumen indikator utama untuk mengukur pencapaian kinerja organisasi.', 'active', '2026-09-15 16:12:56', '2026-09-15 16:12:56'),
('b8d57474-3500-4caa-8d20-a3f1141c47e6', 'SAKIP', 'sakip', 'Dokumen terkait sistem akuntabilitas dan pengelolaan kinerja organisasi.', 'active', '2026-09-15 16:13:55', '2026-09-15 16:13:55'),
('d5394429-10b1-4222-86b4-68c6da8dfe0d', 'SPBE', 'spbe', 'Dokumen terkait penyelenggaraan pemerintahan berbasis elektronik.', 'active', '2026-09-15 16:14:28', '2026-09-15 16:14:28');

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
(45, 'dbmsdakotabekasi2018@gmail.com', '9c513953-32d1-4415-a921-8a6baf246d44', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'credentials', '2026-09-20 11:22:10', '2026-09-20 11:22:10', '2026-09-20 11:22:10');

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `uuid` char(36) NOT NULL,
  `pertanyaan` varchar(255) NOT NULL,
  `jawaban` text NOT NULL,
  `urutan` int(11) NOT NULL DEFAULT 0,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`uuid`, `pertanyaan`, `jawaban`, `urutan`, `status`, `created_at`, `updated_at`) VALUES
('4b9411a3-ccc5-44fd-bc24-e8dc7065773c', 'What should I bring to class?', 'Wear comfortable clothes that allow you to move freely. Bring a water bottle and your own yoga mat if needed.', 2, 'active', '2025-09-17 20:19:23', '2026-09-10 17:00:55'),
('6bb623f8-916a-436b-85b3-a57035fe5ac5', 'How often should I practice yoga?', 'It depends on your goals and routine. For most people, practicing 2–3 times a week is a great way to build consistency while giving your body enough time to rest.', 4, 'active', '2025-09-17 20:20:44', '2026-09-10 17:01:41'),
('95b200f1-69c7-4f1b-a76b-172bcf5fcc55', 'How long is each class?', 'Most Yoga Roots classes run for 60–90 minutes, depending on the type of class. Each session gives you time to move, breathe, and slow down.', 5, 'active', '2025-09-17 20:21:00', '2026-09-10 17:02:03'),
('9f25d34e-2a60-42cf-8379-ed069dc50ac0', 'How can I join Yoga Roots?', 'Choose the class that feels right for you, select your preferred schedule, and register through our website. We’ll be happy to have you join us.', 6, 'active', '2026-09-10 17:02:30', '2026-09-10 17:02:30'),
('fa2b17f9-f0d4-4849-8373-8d787b80113e', 'Is Yoga Roots suitable for beginners?', 'Absolutely. Yoga Roots welcomes everyone, whether you’re completely new to yoga or have been practicing for years. Our classes are designed to help you feel comfortable and progress at your own pace.', 1, 'active', '2025-09-17 20:13:33', '2026-09-10 17:00:36'),
('fd90f57c-53aa-4b5d-8e11-faea4808686d', 'Do I need to be flexible to practice yoga?', 'Not at all. You don’t need to be flexible to start yoga. With regular practice, you’ll gradually build flexibility, strength, balance, and a better connection with your body.', 3, 'active', '2025-09-17 20:20:22', '2026-09-10 17:01:17');

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
(8, 'default', '{\"uuid\":\"0ab8cfeb-beab-4953-a84b-0dbfcf5ed6e0\",\"displayName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":true,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\",\"command\":\"O:33:\\\"Laravel\\\\Scout\\\\Jobs\\\\MakeSearchable\\\":2:{s:6:\\\"models\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Document\\\";s:2:\\\"id\\\";a:1:{i:0;s:36:\\\"01a0beea-4a72-723e-a71b-5f20668c45b1\\\";}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:10:\\\"connection\\\";s:8:\\\"database\\\";}\",\"batchId\":null},\"createdAt\":1789909420,\"delay\":null}', 0, NULL, 1789909420, 1789909420);

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
(64, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin DBMSDA', 'dbmsdakotabekasi2018@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-20 12:07:38', '2026-09-20 12:07:38', '2026-09-20 12:07:38'),
(65, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin DBMSDA', 'dbmsdakotabekasi2018@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-20 12:40:58', '2026-09-20 12:40:58', '2026-09-20 12:40:58'),
(66, '9c513953-32d1-4415-a921-8a6baf246d44', 'Admin DBMSDA', 'dbmsdakotabekasi2018@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'web', '2026-09-20 13:36:13', '2026-09-20 13:36:13', '2026-09-20 13:36:13');

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
(2, 'Role dan Akses', 1, 'menu.role-permission', 'bx-shield-quarter', 12, '2024-09-26 23:27:05', '2024-09-26 23:56:50'),
(3, 'Pengaturan', 1, 'menu-item.index', 'bx-cog', 13, '2024-09-26 23:27:05', '2026-09-17 03:28:38'),
(4, 'Dokumen', 1, 'document-categories.index', 'bx-receipt', 3, '2024-09-26 23:35:30', '2026-09-15 22:51:58'),
(7, 'Publikasi', 1, 'articles.index', 'bxs-file', 7, '2024-09-29 12:37:06', '2026-09-17 05:01:01'),
(8, 'Pustaka Media', 1, 'banner.index', 'bx-camera', 8, '2024-10-13 22:33:06', '2026-09-17 05:23:10'),
(9, 'Master Data', 1, 'testimonial.index', 'bx-folder-open', 11, '2025-07-21 17:56:19', '2026-08-30 19:07:27'),
(10, 'Profil Pejabat', 1, 'instruktur.index', 'bx-user', 6, '2025-07-23 22:38:22', '2026-09-17 04:49:29'),
(11, 'Agenda', 1, 'agenda.index', 'bxs-calendar', 4, '2025-07-25 16:53:44', '2026-09-15 21:51:58'),
(12, 'Profil Website', 1, 'layanan.kontak', 'bx-package', 1, '2025-09-14 12:05:35', '2026-09-18 04:10:11'),
(22, 'Layanan Publik', 1, 'class-schedules.index', 'bx-book', 2, '2026-09-02 15:16:09', '2026-09-17 05:01:27'),
(24, 'Keamanan', 1, 'menu.keamanan', 'bx-shield-alt-2', 14, '2026-09-17 02:49:22', '2026-09-17 02:49:22'),
(26, 'Pengaduan', 1, 'aduans.index', 'bx-phone', 9, '2026-09-19 02:03:39', '2026-09-19 02:03:39');

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
(1, 'Informasi Umum', NULL, 'company.index', 1, 'company.index', 1, 1, '2024-09-26 23:27:05', '2024-09-27 01:56:11'),
(2, 'Module Role', NULL, 'permission.index', 1, 'permission.index', 2, 1, '2024-09-26 23:27:05', '2024-09-26 23:58:37'),
(3, 'Master Role', NULL, 'role.index', 1, 'role.index', 2, 2, '2024-09-26 23:27:05', '2024-09-26 23:58:15'),
(4, 'Daftar Pengguna', NULL, 'user.index', 1, 'user.index', 3, 1, '2024-09-26 23:27:05', '2024-09-26 23:39:25'),
(5, 'Module Aplikasi', NULL, 'route.index', 1, 'route.index', 3, 2, '2024-09-26 23:27:05', '2024-09-26 23:44:54'),
(6, 'Menu Manager', NULL, 'menu.index', 1, 'menu-group.index', 3, 3, '2024-09-26 23:27:05', '2024-09-26 23:44:09'),
(8, 'Kategori', NULL, 'categories.index', 1, 'categories.index', 7, 3, '2024-09-29 12:39:24', '2026-09-17 02:21:41'),
(9, 'Berita', NULL, 'articles.index', 1, 'articles.index', 7, 1, '2024-09-30 12:08:38', '2026-09-17 01:51:37'),
(10, 'Semua Media', NULL, 'banner.index', 1, 'banner.index', 8, 1, '2024-10-13 22:38:24', '2026-09-17 05:23:32'),
(12, 'Tambah Berita', NULL, 'articles.create', 1, 'articles.create', 7, 2, '2025-07-22 12:59:27', '2026-09-17 02:21:32'),
(13, 'Jabatan', NULL, 'departments.index', 1, 'departments.index', 10, 1, '2025-07-23 23:12:46', '2026-09-18 20:52:02'),
(14, 'Agenda Kegiatan', NULL, 'agenda.index', 1, 'agenda.index', 11, 1, '2025-07-25 16:55:36', '2026-09-15 21:52:17'),
(40, 'Halaman Statis', NULL, 'pages.index', 1, 'pages.index', 9, 3, '2025-10-21 03:46:02', '2026-09-17 03:30:02'),
(41, 'All Instructors', NULL, 'instruktur.index', 1, 'program.index', 10, 2, '2025-11-12 04:02:59', '2026-09-03 17:40:35'),
(46, 'Class List', NULL, 'pages.index', 1, 'classes.index', 22, 1, '2026-09-02 15:18:03', '2026-09-02 15:18:03'),
(47, 'Schedule', NULL, 'pages.index', 1, 'classes.index', 22, 2, '2026-09-06 03:39:53', '2026-09-06 03:39:53'),
(48, 'Pesan Masuk', NULL, 'layanan.kontak', 1, 'layanan.kontak', 3, 4, '2026-09-06 19:44:23', '2026-09-17 14:13:26'),
(49, 'Menu Website', NULL, 'website-menu.index', 1, 'articles.index', 3, 5, '2026-09-06 20:40:53', '2026-09-17 13:56:47'),
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
(28, '2025_09_16_061553_create_testimonials_table', 1),
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
(40, '2026_08_31_120827_create_events_table', 11),
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
(75, '2026_09_18_125112_create_departments_table', 34),
(76, '2026_09_18_125113_create_user_department_table', 34),
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
(89, '2026_09_20_000003_rename_events_to_agendas', 44);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
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
(2, 'App\\Models\\User', '58cbfa68-69aa-4cd1-95cc-9520046d9ceb'),
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
(5, 'App\\Models\\User', '0ba0b18a-64e7-44ce-8042-8b282ab9c5b3'),
(5, 'App\\Models\\User', '1c3ea59a-f83a-4bdf-aa70-f38ff66f49a2'),
(5, 'App\\Models\\User', '2f040883-ec48-424e-872d-3691d7c1a714'),
(5, 'App\\Models\\User', '33b681e2-efc3-4017-9415-e5d5d197f2fe'),
(5, 'App\\Models\\User', '4a85c36a-caa6-4cc9-9ab6-47f77c0a9a67'),
(5, 'App\\Models\\User', '4c0ff420-34e5-4ecd-bb07-358862f9906a'),
(5, 'App\\Models\\User', '514d04e5-f79b-403a-95f4-2254784db0f0'),
(5, 'App\\Models\\User', '537f352e-a1e3-4daa-86b2-fc6b3366881c'),
(5, 'App\\Models\\User', '56f0bbe7-c52e-4d97-833f-17fba920421f'),
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
(35, 'company.index', 'web', '2024-09-27 01:42:51', '2024-09-27 01:52:59'),
(36, 'company.store', 'web', '2024-09-27 01:43:04', '2024-09-27 01:53:19'),
(37, 'company.update', 'web', '2024-09-27 01:43:16', '2024-09-27 01:53:10'),
(38, 'categories.destroy', 'web', '2024-09-29 12:28:15', '2024-10-15 13:50:56'),
(39, 'categories.index', 'web', '2024-09-29 12:28:26', '2024-10-15 13:51:03'),
(40, 'categories.store', 'web', '2024-09-29 12:28:42', '2024-10-15 13:51:13'),
(41, 'categories.update', 'web', '2024-09-29 12:28:54', '2024-10-15 13:51:20'),
(46, 'banner.destroy', 'web', '2024-09-30 12:05:12', '2024-10-13 22:29:29'),
(47, 'banner.index', 'web', '2024-09-30 12:05:28', '2024-10-13 22:29:37'),
(48, 'banner.store', 'web', '2024-09-30 12:05:41', '2024-10-13 22:29:45'),
(49, 'banner.update', 'web', '2024-09-30 12:05:59', '2024-10-13 22:29:53'),
(50, 'articles.destroy', 'web', '2024-10-15 14:19:19', '2024-10-15 14:19:19'),
(51, 'articles.create', 'web', '2024-10-15 14:19:37', '2024-10-15 14:20:03'),
(52, 'articles.index', 'web', '2024-10-15 14:20:16', '2024-10-15 14:20:16'),
(53, 'articles.store', 'web', '2024-10-15 14:20:34', '2024-10-15 14:20:34'),
(54, 'articles.update', 'web', '2024-10-15 14:20:52', '2024-10-15 14:20:52'),
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
(146, 'instruktur.index', 'web', '2025-09-14 12:04:29', '2026-09-01 14:30:03'),
(147, 'pages.create', 'web', '2025-09-17 23:27:58', '2025-09-17 23:27:58'),
(148, 'pages.destroy', 'web', '2025-09-17 23:28:08', '2025-09-17 23:28:08'),
(149, 'pages.index', 'web', '2025-09-17 23:28:19', '2025-09-17 23:28:19'),
(150, 'pages.store', 'web', '2025-09-17 23:28:28', '2025-09-17 23:28:28'),
(151, 'pages.update', 'web', '2025-09-17 23:28:36', '2025-09-17 23:28:36'),
(152, 'instruktur.destroy', 'web', '2025-09-18 01:25:31', '2026-09-01 14:29:43'),
(153, 'instruktur.store', 'web', '2025-09-18 01:25:43', '2026-09-01 14:30:14'),
(154, 'instruktur.update', 'web', '2025-09-18 01:29:03', '2026-09-01 14:30:28'),
(155, 'testimonial.destroy', 'web', '2025-09-21 21:43:09', '2025-09-21 21:43:09'),
(156, 'testimonial.index', 'web', '2025-09-21 21:43:15', '2025-09-21 21:43:15'),
(157, 'testimonial.update', 'web', '2025-09-21 21:43:32', '2025-09-21 21:43:32'),
(158, 'testimonial.store', 'web', '2025-09-21 21:43:59', '2025-09-21 21:43:59'),
(159, 'agenda.index', 'web', '2025-10-20 08:44:13', '2026-08-30 19:30:03'),
(160, 'agenda.destroy', 'web', '2025-10-20 08:46:31', '2026-08-30 19:29:50'),
(161, 'agenda.store', 'web', '2025-10-20 08:47:29', '2026-08-30 19:30:13'),
(162, 'agenda.update', 'web', '2025-10-20 08:48:18', '2026-08-30 19:30:24'),
(163, 'specializations.index', 'web', '2025-11-11 03:38:59', '2026-08-27 17:28:55'),
(164, 'specializations.destroy', 'web', '2025-11-11 03:39:23', '2026-08-27 17:28:42'),
(165, 'specializations.update', 'web', '2025-11-11 03:39:36', '2026-08-27 17:29:13'),
(166, 'specializations.store', 'web', '2025-11-11 03:39:47', '2026-08-27 17:29:05'),
(172, 'classes.destroy', 'web', '2026-09-02 14:45:03', '2026-09-02 14:45:03'),
(173, 'classes.index', 'web', '2026-09-02 14:45:18', '2026-09-02 14:45:18'),
(174, 'classes.store', 'web', '2026-09-02 14:45:44', '2026-09-02 14:45:44'),
(175, 'classes.update', 'web', '2026-09-02 14:45:59', '2026-09-02 14:45:59'),
(176, 'dashboard.submitSumber', 'web', '2026-09-04 07:15:06', '2026-09-04 07:15:06'),
(177, 'classes.create', 'web', '2026-09-05 23:52:57', '2026-09-05 23:52:57'),
(178, 'classes.edit', 'web', '2026-09-05 23:53:12', '2026-09-05 23:53:12'),
(180, 'departments.destroy', 'web', '2026-09-06 03:36:48', '2026-09-18 20:48:10'),
(181, 'departments.index', 'web', '2026-09-06 03:37:03', '2026-09-18 20:48:37'),
(182, 'departments.store', 'web', '2026-09-06 03:37:18', '2026-09-18 20:48:51'),
(183, 'departments.update', 'web', '2026-09-06 03:37:32', '2026-09-18 20:49:05'),
(185, 'pengguna.index', 'web', '2026-09-06 20:38:51', '2026-09-06 20:38:51'),
(186, 'pengguna.export', 'web', '2026-09-06 20:39:08', '2026-09-06 20:39:08'),
(187, 'documents.index', 'web', '2026-09-08 06:29:57', '2026-09-16 00:37:55'),
(188, 'documents.destroy', 'web', '2026-09-08 06:30:24', '2026-09-16 00:37:43'),
(189, 'documents.create', 'web', '2026-09-08 06:30:57', '2026-09-16 00:37:29'),
(190, 'documents.store', 'web', '2026-09-08 06:31:17', '2026-09-16 00:38:04'),
(191, 'documents.update', 'web', '2026-09-08 06:31:34', '2026-09-16 00:38:15'),
(192, 'instruktur.mobile', 'web', '2026-09-12 06:49:00', '2026-09-12 06:49:00'),
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
(223, 'health.page', 'web', '2026-09-20 00:15:45', '2026-09-20 00:15:45');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
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
(5, 'uptd', 'web', '2025-07-21 13:29:16', '2026-09-18 04:41:32');

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
(35, 1),
(36, 1),
(37, 1),
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
(146, 1),
(146, 3),
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
(152, 1),
(152, 3),
(153, 1),
(153, 3),
(154, 1),
(154, 3),
(155, 1),
(155, 3),
(156, 1),
(156, 3),
(157, 1),
(157, 3),
(158, 1),
(158, 3),
(159, 1),
(159, 3),
(160, 1),
(160, 3),
(161, 1),
(161, 3),
(162, 1),
(162, 3),
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
(180, 1),
(180, 3),
(181, 1),
(181, 3),
(182, 1),
(182, 3),
(183, 1),
(183, 3),
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
(192, 1),
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
(223, 5);

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
(30, 'company.index', 'company.index', 1, NULL, '2024-09-27 01:53:58', '2024-09-27 01:53:58'),
(32, 'company.update', 'company.update', 1, NULL, '2024-09-27 01:55:03', '2024-09-27 01:55:09'),
(33, 'company.store', 'company.store', 1, NULL, '2024-09-27 01:55:29', '2024-09-27 01:55:29'),
(34, 'categories.destroy', 'categories.destroy', 1, NULL, '2024-09-29 12:31:56', '2024-10-15 13:51:53'),
(35, 'categories.index', 'categories.index', 1, NULL, '2024-09-29 12:32:17', '2024-10-15 13:52:11'),
(36, 'categories.store', 'categories.store', 1, NULL, '2024-09-29 12:32:37', '2024-10-15 13:52:26'),
(37, 'categories.update', 'categories.update', 1, NULL, '2024-09-29 12:32:56', '2024-10-15 13:52:45'),
(42, 'banner.destroy', 'banner.destroy', 1, NULL, '2024-09-30 12:06:31', '2024-10-13 22:36:22'),
(43, 'banner.index', 'banner.index', 1, NULL, '2024-09-30 12:06:55', '2024-10-13 22:36:39'),
(44, 'banner.store', 'banner.store', 1, NULL, '2024-09-30 12:07:34', '2024-10-13 22:37:03'),
(45, 'banner.update', 'banner.update', 1, NULL, '2024-09-30 12:07:57', '2024-10-13 22:37:24'),
(46, 'articles.create', 'articles.create', 1, NULL, '2024-10-15 14:22:17', '2024-10-15 14:22:17'),
(47, 'articles.destroy', 'articles.destroy', 1, NULL, '2024-10-15 14:22:51', '2024-10-15 14:22:51'),
(48, 'articles.index', 'articles.index', 1, NULL, '2024-10-15 14:23:15', '2024-10-15 14:23:15'),
(49, 'articles.store', 'articles.store', 1, NULL, '2024-10-15 14:23:49', '2024-10-15 14:23:49'),
(50, 'articles.update', 'articles.update', 1, NULL, '2024-10-15 14:24:09', '2024-10-15 14:24:09'),
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
(146, 'instruktur.destroy', 'instruktur.destroy', 1, NULL, '2025-09-14 12:04:52', '2026-09-01 14:31:34'),
(147, 'pages.create', 'pages.create', 1, NULL, '2025-09-17 23:29:27', '2025-09-17 23:29:27'),
(148, 'pages.index', 'pages.index', 1, NULL, '2025-09-17 23:29:41', '2025-09-17 23:29:41'),
(149, 'pages.store', 'pages.store', 1, NULL, '2025-09-17 23:29:59', '2025-09-17 23:29:59'),
(150, 'pages.destroy', 'pages.destroy', 1, NULL, '2025-09-17 23:30:31', '2025-09-17 23:30:31'),
(151, 'pages.update', 'pages.update', 1, NULL, '2025-09-17 23:30:45', '2025-09-17 23:30:45'),
(152, 'instruktur.index', 'instruktur.index', 1, NULL, '2025-09-18 01:27:46', '2026-09-01 14:32:00'),
(153, 'instruktur.store', 'instruktur.store', 1, NULL, '2025-09-18 01:27:59', '2026-09-01 14:32:18'),
(154, 'instruktur.update', 'instruktur.update', 1, NULL, '2025-09-18 01:31:29', '2026-09-01 14:32:46'),
(155, 'testimonial.destroy', 'testimonial.destroy', 1, NULL, '2025-09-21 21:44:13', '2025-09-21 21:44:13'),
(156, 'testimonial.index', 'testimonial.index', 1, NULL, '2025-09-21 21:44:25', '2025-09-21 21:44:25'),
(157, 'testimonial.store', 'testimonial.store', 1, NULL, '2025-09-21 21:44:40', '2025-09-21 21:44:40'),
(158, 'testimonial.update', 'testimonial.update', 1, NULL, '2025-09-21 21:44:53', '2025-09-21 21:44:53'),
(159, 'agenda.destroy', 'agenda.destroy', 1, NULL, '2025-10-21 02:47:54', '2026-08-30 19:52:08'),
(160, 'agenda.index', 'agenda.index', 1, NULL, '2025-10-21 03:15:35', '2026-08-30 19:52:34'),
(161, 'agenda.store', 'agenda.store', 1, NULL, '2025-10-21 03:15:47', '2026-08-30 19:52:53'),
(162, 'agenda.update', 'agenda.update', 1, NULL, '2025-10-21 03:15:58', '2026-08-30 19:53:11'),
(163, 'specializations.destroy', 'specializations.destroy', 1, NULL, '2025-11-11 03:40:24', '2026-08-27 17:32:06'),
(164, 'specializations.index', 'specializations.index', 1, NULL, '2025-11-11 03:40:41', '2026-08-27 17:32:27'),
(165, 'specializations.store', 'specializations.store', 1, NULL, '2025-11-11 03:40:58', '2026-08-27 17:32:51'),
(166, 'specializations.update', 'specializations.update', 1, NULL, '2025-11-11 03:42:13', '2026-08-27 17:33:20'),
(172, 'departments.destroy', 'departments.destroy', 1, NULL, '2026-09-02 15:12:54', '2026-09-18 20:50:14'),
(173, 'departments.index', 'departments.index', 1, NULL, '2026-09-02 15:13:08', '2026-09-18 20:50:45'),
(174, 'departments.update', 'departments.update', 1, NULL, '2026-09-02 15:13:24', '2026-09-18 20:51:27'),
(175, 'departments.store', 'departments.store', 1, NULL, '2026-09-02 15:13:40', '2026-09-18 20:51:06'),
(176, 'dashboard.submitSumber', 'dashboard.submitSumber', 1, NULL, '2026-09-04 07:15:41', '2026-09-04 07:15:41'),
(185, 'pengguna.index', 'pengguna.index', 1, NULL, '2026-09-06 20:39:23', '2026-09-06 20:39:23'),
(186, 'pengguna.export', 'pengguna.export', 1, NULL, '2026-09-06 20:39:35', '2026-09-06 20:39:35'),
(187, 'documents.create', 'documents.create', 1, NULL, '2026-09-08 06:32:44', '2026-09-16 00:54:07'),
(188, 'documents.index', 'documents.index', 1, NULL, '2026-09-08 06:32:59', '2026-09-16 00:54:20'),
(189, 'documents.destroy', 'documents.destroy', 1, NULL, '2026-09-08 06:33:15', '2026-09-16 00:53:57'),
(190, 'documents.update', 'documents.update', 1, NULL, '2026-09-08 06:33:33', '2026-09-16 00:55:02'),
(191, 'documents.store', 'documents.store', 1, NULL, '2026-09-08 06:33:55', '2026-09-16 00:54:38'),
(192, 'instruktur.mobile', 'instruktur.mobile', 1, NULL, '2026-09-12 06:49:32', '2026-09-12 06:49:32'),
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
(223, 'aduans.rate', 'aduans.update', 1, NULL, '2026-09-19 05:26:07', '2026-09-19 05:26:07');

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
(77, 'ringkasan', 'judul berita 2', 'images/j6y3qSWN6dYvXjXiE41yWMTz0Z53cyxzaJD6YQWm.png', 'Admin DBMSDA', 'index', 'http://localhost:8000/backend/articles/judul-berita-2', '2026-09-20 12:09:25', '2026-09-20 12:10:17', 'App\\Models\\Article', '2fa27e87-b4b5-4224-900d-26e44764d1e4'),
(78, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-20 13:02:23', '2026-09-20 13:02:23', 'App\\Models\\DocumentCategory', 'a6d14f40-5032-40dc-9ef2-349d4300636f'),
(79, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-20 13:03:40', '2026-09-20 13:03:40', 'App\\Models\\Document', '01a0beea-4a72-723e-a71b-5f20668c45b1');

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
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `uuid` char(36) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `jabatan` varchar(255) DEFAULT NULL,
  `isi_testimoni` text NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `urutan` int(11) NOT NULL DEFAULT 0,
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `testimonials`
--

INSERT INTO `testimonials` (`uuid`, `nama`, `jabatan`, `isi_testimoni`, `foto`, `urutan`, `is_active`, `created_at`, `updated_at`) VALUES
('267d9987-ea8e-422a-a32d-a26e7e9cea0f', 'Fhadillah Cherly Yunanda', 'Member Since 2024', 'Best yoga place in jkt so far! Very clean, very nice lighting with natural sunlight, and the most important thing - so engaging instructor! Will be back offf course!!!', 'testimoni/ObU2uLK401gA8ZvTKHaLiWZd9Ve4AVloUD1T15PJ.jpg', 2, 'active', '2026-09-11 00:21:17', '2026-09-11 00:21:53'),
('8a7bbb78-eb33-4f1b-941c-cbdcd2b9c5a3', 'Jessica Gloria Mogi', 'Member Since 2024', 'The studio was beautiful, plenty of natural sunlight, it was not stuffy at all. They have a minimalist shower with some skincare products and medium-sized lockers. It\'s a great experience and I\'m coming back tomorrow :)', 'testimoni/6HcmtKnmhk7z2RoV1BkNkQSBo1xrbCbGCC0LBzvx.jpg', 1, 'active', '2026-09-11 00:19:26', '2026-09-11 00:19:44'),
('dcfd5ae2-e3a0-4c4b-a3c4-937af0a086d7', 'Melda Auditia', 'Member Since 2025', 'Amazing experience. Great instructor. Space is quiet, beautiful & clean, with nice shower room for yoga before work. Would definitely come back again👍🏻', 'testimoni/B4JRMECCVIhAeVGY9yo8duoZzS6l4njN4IknQ7Mu.jpg', 3, 'active', '2026-09-11 00:22:56', '2026-09-11 00:23:09');

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
  `nip` varchar(30) DEFAULT NULL,
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
  `is_pejabat` tinyint(4) DEFAULT 1,
  `is_active` date DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `urutan_pejabat` int(11) DEFAULT NULL,
  `unit_kerja` varchar(255) DEFAULT NULL,
  `riwayat` text DEFAULT NULL,
  `sumber_informasi` enum('google','sosmed','teman','komunitas','event','website','lainnya') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uuid`, `name`, `nip`, `no_hp`, `alamat`, `kecamatan_id`, `kelurahan_id`, `avatar`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `google_id`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `agama`, `is_pejabat`, `is_active`, `deleted_at`, `urutan_pejabat`, `unit_kerja`, `riwayat`, `sumber_informasi`) VALUES
('58cbfa68-69aa-4cd1-95cc-9520046d9ceb', 'Wiku Pramesthi Bagaswara', NULL, '085691333321', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIy22SZ7rHRNSArCv4eG6XuX5UvbOoXvsVvIs9Xq7V7QurWiopP=s96-c', 'wikupb@gmail.com', '2026-09-19 00:40:13', '$2y$12$jAEzSFmcf9dR//UIHXEEfel1L44V3FZ31XSYmnSwaRBiz/OzNdX0q', NULL, '2026-09-19 00:40:14', '2026-09-19 05:06:37', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 'event'),
('787b72ea-59d0-4d54-848b-c200bddafdd2', 'super-admin', NULL, NULL, 'Jl. Gandaria', 4, 17, 'avatars/u5KMRU9jG95SYcdq0vhxnksQ0EFatee9WxrPxrtH.jpg', 'super@admin.com', '2025-09-16 00:23:37', '$2y$12$PRZJcd.nlREU6NRq3jvIVemYmlwxVPTb7En4URyNgyQSfKjWUzwDi', 'xjB9veugG2XdafB6eNhKGKvphG76Sf0yrWJ5XhbmmZubAd6dh0l70s09WAL0', '2025-09-16 00:23:37', '2026-09-06 23:43:32', NULL, 'dasda', '2025-09-24', 'P', 'Lainnya', 10, NULL, NULL, NULL, NULL, 'sdsddsad', NULL),
('9c513953-32d1-4415-a921-8a6baf246d44', 'Admin DBMSDA', NULL, '43243277777', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLitzhONjAN_zPOcC2rM16BHekNE3M2zU7C-e0d53-6M47R-PE=s96-c', 'dbmsdakotabekasi2018@gmail.com', '2026-09-20 11:21:48', '$2y$12$PRZJcd.nlREU6NRq3jvIVemYmlwxVPTb7En4URyNgyQSfKjWUzwDi', NULL, '2026-09-19 02:27:18', '2026-09-20 11:21:48', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 'google');

-- --------------------------------------------------------

--
-- Table structure for table `user_department`
--

CREATE TABLE `user_department` (
  `uuid` char(36) NOT NULL,
  `user_uuid` char(36) NOT NULL,
  `department_uuid` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
('4b30c85e-4c00-4b53-897f-841bce4e9bde', 'DBMSDA Kota Bekasi', 'Portal DBMSDA Kota Bekasi', 'Infrastruktur Berkualitas, Sumber Daya Air Berkelanjutan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-18 02:41:39', '2026-09-18 09:16:27');

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
  ADD UNIQUE KEY `events_slug_unique` (`slug`);

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
-- Indexes for table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`uuid`),
  ADD UNIQUE KEY `articles_slug_unique` (`slug`),
  ADD KEY `articles_user_uuid_foreign` (`user_uuid`),
  ADD KEY `articles_category_uuid_foreign` (`category_uuid`);

--
-- Indexes for table `article_images`
--
ALTER TABLE `article_images`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `article_images_article_uuid_index` (`article_uuid`);

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
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`uuid`),
  ADD UNIQUE KEY `departments_name_unique` (`name`),
  ADD UNIQUE KEY `departments_slug_unique` (`slug`);

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
  ADD PRIMARY KEY (`uuid`);

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
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`uuid`);

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
-- Indexes for table `user_department`
--
ALTER TABLE `user_department`
  ADD PRIMARY KEY (`uuid`),
  ADD UNIQUE KEY `user_department_user_uuid_department_uuid_unique` (`user_uuid`,`department_uuid`),
  ADD KEY `user_department_department_uuid_foreign` (`department_uuid`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=416;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=224;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=225;

--
-- AUTO_INCREMENT for table `seo`
--
ALTER TABLE `seo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

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
-- Constraints for table `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `articles_category_uuid_foreign` FOREIGN KEY (`category_uuid`) REFERENCES `categories` (`uuid`) ON DELETE SET NULL,
  ADD CONSTRAINT `articles_user_uuid_foreign` FOREIGN KEY (`user_uuid`) REFERENCES `users` (`uuid`) ON DELETE CASCADE;

--
-- Constraints for table `article_images`
--
ALTER TABLE `article_images`
  ADD CONSTRAINT `article_images_article_uuid_foreign` FOREIGN KEY (`article_uuid`) REFERENCES `articles` (`uuid`) ON DELETE CASCADE;

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_category_uuid_foreign` FOREIGN KEY (`category_uuid`) REFERENCES `document_categories` (`uuid`) ON DELETE CASCADE;

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
-- Constraints for table `user_department`
--
ALTER TABLE `user_department`
  ADD CONSTRAINT `user_department_department_uuid_foreign` FOREIGN KEY (`department_uuid`) REFERENCES `departments` (`uuid`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_department_user_uuid_foreign` FOREIGN KEY (`user_uuid`) REFERENCES `users` (`uuid`) ON DELETE CASCADE;

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
