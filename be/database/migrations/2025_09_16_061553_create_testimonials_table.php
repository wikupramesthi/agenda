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
        Schema::create('testimonials', function (Blueprint $table) {
           $table->uuid('uuid')->primary();
            $table->string('nama');              
            $table->string('jabatan')->nullable(); 
            $table->text('isi_testimoni');       
            $table->string('foto')->nullable(); 
            $table->integer('urutan')->default(0); 
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('testimonials');
    }
};
