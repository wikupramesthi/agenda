<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    private function enumList(): string
    {
        return implode(',', array_map(
            fn ($v) => "'" . str_replace("'", "\\'", $v) . "'",
            \App\Models\Aduan::KATEGORI
        ));
    }

    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Tanpa doctrine/dbal, ubah kolom via SQL mentah (MySQL).
        DB::statement(
            'ALTER TABLE `aduans` MODIFY COLUMN `kategori` ENUM(' . $this->enumList() . ') NOT NULL'
        );
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::statement(
            'ALTER TABLE `aduans` MODIFY COLUMN `kategori` VARCHAR(100) NOT NULL'
        );
    }
};
