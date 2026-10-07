<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote')->hourly();

// Visitor stats aggregation - runs daily at 1:00 AM
Schedule::command('visitor:aggregate')->dailyAt('01:00')->withoutOverlapping();

// Visitor logs pruning - runs weekly on Sunday at 2:00 AM  
Schedule::command('visitor:prune --days=90')->weeklyOn(0, '02:00')->withoutOverlapping();

// Auto-archive old finished aduan - runs daily at 2:30 AM
Schedule::command('aduan:arsipkan')->dailyAt('02:30')->withoutOverlapping();

// Scheduler heartbeat for /health monitoring - runs every minute
Schedule::command('app:heartbeat')->everyMinute()->withoutOverlapping();
