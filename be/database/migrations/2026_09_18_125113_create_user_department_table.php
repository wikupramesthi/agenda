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
        Schema::create('user_department', function (Blueprint $table) {
            $table->uuid('uuid')->primary();
            $table->uuid('user_uuid');
            $table->uuid('department_uuid');
            $table->foreign('user_uuid')->references('uuid')->on('users')->cascadeOnDelete();
            $table->foreign('department_uuid')->references('uuid')->on('departments')->cascadeOnDelete();
            $table->timestamps();
            $table->unique(['user_uuid', 'department_uuid',]);
        });
    }
    /** * Reverse the migrations. */ public function down(): void
    {
        Schema::dropIfExists('user_department');
    }
};
