<?php

namespace App\Enums;

enum FaqKategori: string
{
    case INFORMASI_UMUM = 'informasi-umum';
    case LAYANAN = 'layanan';
    case INFRASTRUKTUR_PEMELIHARAAN = 'infrastruktur-pemeliharaan';
    case PENGADUAN_PERMOHONAN = 'pengaduan-permohonan';
    case PROGRAM_KEGIATAN = 'program-kegiatan';

    public function label(): string
    {
        return match ($this) {
            self::INFORMASI_UMUM => 'Informasi Umum',
            self::LAYANAN => 'Layanan',
            self::INFRASTRUKTUR_PEMELIHARAAN => 'Infrastruktur & Pemeliharaan',
            self::PENGADUAN_PERMOHONAN => 'Pengaduan & Permohonan',
            self::PROGRAM_KEGIATAN => 'Program & Kegiatan',
        };
    }

    public static function values(): array
    {
        return array_column(self::cases(), 'value');
    }
}
