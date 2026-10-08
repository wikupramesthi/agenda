<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Kategori FAQ baru: Tentang Agenda · Jadwal · Lokasi · Publikasi · Lainnya.
     */
    public function up(): void
    {
        DB::table('faqs')->where('kategori', 'informasi-umum')->update(['kategori' => 'tentang-agenda']);
        DB::table('faqs')->where('kategori', 'program-kegiatan')->update(['kategori' => 'jadwal']);
        DB::table('faqs')->where('kategori', 'infrastruktur-pemeliharaan')->update(['kategori' => 'lokasi']);
        DB::table('faqs')->where('kategori', 'layanan')->update(['kategori' => 'publikasi']);
        DB::table('faqs')->where('kategori', 'pengaduan-permohonan')->update(['kategori' => 'lainnya']);
        DB::table('faqs')->whereNotIn('kategori', ['tentang-agenda', 'jadwal', 'lokasi', 'publikasi', 'lainnya'])->update(['kategori' => 'lainnya']);

        DB::statement("ALTER TABLE faqs MODIFY COLUMN kategori ENUM('tentang-agenda','jadwal','lokasi','publikasi','lainnya') NULL DEFAULT NULL");
    }

    public function down(): void
    {
        DB::table('faqs')->where('kategori', 'tentang-agenda')->update(['kategori' => 'informasi-umum']);
        DB::table('faqs')->where('kategori', 'jadwal')->update(['kategori' => 'program-kegiatan']);
        DB::table('faqs')->where('kategori', 'lokasi')->update(['kategori' => 'infrastruktur-pemeliharaan']);
        DB::table('faqs')->where('kategori', 'publikasi')->update(['kategori' => 'layanan']);

        DB::statement("ALTER TABLE faqs MODIFY COLUMN kategori ENUM('informasi-umum','layanan','infrastruktur-pemeliharaan','pengaduan-permohonan','program-kegiatan') NULL DEFAULT NULL");
    }
};
