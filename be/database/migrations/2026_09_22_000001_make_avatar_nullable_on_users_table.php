<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    /**
     * Kolom avatar dibuat nullable agar registrasi & factory user tidak
     * gagal menyimpan (view sudah punya fallback avatar default).
     */
    public function up(): void
    {
        DB::statement('ALTER TABLE `users` MODIFY `avatar` VARCHAR(255) NULL');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::statement("UPDATE `users` SET `avatar` = '' WHERE `avatar` IS NULL");
        DB::statement('ALTER TABLE `users` MODIFY `avatar` VARCHAR(255) NOT NULL');
    }
};
