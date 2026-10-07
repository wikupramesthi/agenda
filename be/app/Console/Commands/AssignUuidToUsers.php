<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;
use Illuminate\Support\Str;

class AssignUuidToUsers extends Command
{
    protected $signature = 'users:fill-uuids';
    protected $description = 'Generate UUID for users that do not have one';

    public function handle()
    {
        $users = User::whereNull('uuid')->get();

        foreach ($users as $user) {
            $user->uuid = Str::uuid();
            $user->save();
        }

        $this->info("UUIDs successfully added for {$users->count()} users.");
    }
}
