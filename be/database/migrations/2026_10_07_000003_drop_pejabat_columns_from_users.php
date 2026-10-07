<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Hapus kolom kepegawaian/pejabat dari users (modul pegawai dihapus total).
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['nip', 'is_pejabat', 'urutan_pejabat', 'unit_kerja', 'riwayat']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('nip', 30)->nullable()->after('no_hp');
            $table->boolean('is_pejabat')->nullable()->after('agama');
            $table->integer('urutan_pejabat')->nullable()->after('is_pejabat');
            $table->string('unit_kerja')->nullable()->after('urutan_pejabat');
            $table->text('riwayat')->nullable()->after('unit_kerja');
        });
    }
};
