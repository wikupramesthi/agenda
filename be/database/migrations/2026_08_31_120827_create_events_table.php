<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('events', function (Blueprint $table) {
            $table->uuid('uuid')->primary();

            $table->string('judul');
            $table->string('slug')->unique();

            $table->text('excerpt')->nullable();
            $table->longText('deskripsi')->nullable();

            $table->string('gambar')->nullable();

            $table->date('tanggal');
            $table->time('waktu_mulai')->nullable();
            $table->time('waktu_selesai')->nullable();

            $table->string('lokasi')->nullable();

            $table->enum('status', [
                'draft',
                'published',
                'cancelled',
                'completed',
            ])->default('draft');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('events');
    }
};
