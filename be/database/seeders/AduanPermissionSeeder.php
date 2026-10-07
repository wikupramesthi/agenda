<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use App\Models\ManagementAccess\Route;

class AduanPermissionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();

        $perms = [
            'aduans.index',
            'aduans.store',
            'aduans.show',
            'aduans.update',
            'aduans.destroy',
            'aduans.restore',
            'aduans.forceDelete',
            'aduans.tindaklanjut.store',
            'aduans.tindaklanjut.destroy',
            'aduans.export',
            'aduans.arsip',
            'aduans.batalArsip',
        ];

        foreach ($perms as $name) {
            Permission::firstOrCreate(['name' => $name]);
        }

        foreach (['super-admin', 'admin'] as $roleName) {
            $role = Role::where('name', $roleName)->first();
            if ($role) {
                $role->givePermissionTo($perms);
            }
        }

        // Petugas lapangan (UPTD) boleh mengisi tindak lanjut.
        $uptd = Role::where('name', 'uptd')->first();
        if ($uptd) {
            $uptd->givePermissionTo([
                'aduans.index',
                'aduans.show',
                'aduans.tindaklanjut.store',
                'aduans.tindaklanjut.destroy',
            ]);
        }

        // Warga (role user): kelola pengaduan milik sendiri (tanpa hapus permanen).
        $warga = Role::where('name', 'user')->first();
        if ($warga) {
            $warga->givePermissionTo([
                'aduans.index',
                'aduans.store',
                'aduans.show',
                'aduans.update',
                'aduans.destroy',
                'aduans.restore',
            ]);
        }

        // Sinkron tabel routes (dipakai RouteMiddleware untuk gate akses).
        $routeMap = [
            'aduans.index' => 'aduans.index',
            'aduans.create' => 'aduans.store',
            'aduans.store' => 'aduans.store',
            'aduans.show' => 'aduans.show',
            'aduans.edit' => 'aduans.update',
            'aduans.update' => 'aduans.update',
            'aduans.destroy' => 'aduans.destroy',
            'aduans.restore' => 'aduans.restore',
            'aduans.forceDestroy' => 'aduans.forceDelete',
            'aduans.tindak-lanjut.store' => 'aduans.tindaklanjut.store',
            'aduans.tindak-lanjut.destroy' => 'aduans.tindaklanjut.destroy',
            'aduans.exportPdf' => 'aduans.export',
            'aduans.cekDuplikat' => 'aduans.index',
            'aduans.arsip' => 'aduans.arsip',
            'aduans.batalArsip' => 'aduans.batalArsip',
            'aduans.rate' => 'aduans.update',
        ];

        foreach ($routeMap as $route => $permission) {
            Route::firstOrCreate(
                ['route' => $route],
                ['permission_name' => $permission, 'status' => true]
            );
        }
    }
}
