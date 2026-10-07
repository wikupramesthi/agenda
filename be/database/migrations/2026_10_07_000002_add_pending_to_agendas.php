<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Tambah status 'pending' untuk alur approval:
     * OPD input -> pending -> admin approve (published) / reject (draft).
     */
    public function up(): void
    {
        DB::statement("ALTER TABLE `agendas` MODIFY `status` ENUM('draft','published','scheduled','pending') NOT NULL DEFAULT 'draft'");
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::statement("UPDATE `agendas` SET `status`='draft' WHERE `status`='pending'");
        DB::statement("ALTER TABLE `agendas` MODIFY `status` ENUM('draft','published','scheduled') NOT NULL DEFAULT 'draft'");
    }
};
