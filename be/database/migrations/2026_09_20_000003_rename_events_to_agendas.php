<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (Schema::hasTable('events') && !Schema::hasTable('agendas')) {
            Schema::rename('events', 'agendas');
        }
    }

    public function down(): void
    {
        if (Schema::hasTable('agendas') && !Schema::hasTable('events')) {
            Schema::rename('agendas', 'events');
        }
    }
};
