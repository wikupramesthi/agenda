<?php

namespace Database\Seeders;

use App\Models\ManagementAccess\MenuGroup;
use App\Models\ManagementAccess\MenuItem;
use App\Models\ManagementAccess\Route;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class ServicePermissionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();

        $perms = [
            'services.index',
            'services.store',
            'services.update',
            'services.destroy',
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

        // Sinkron tabel routes (dipakai RouteMiddleware untuk gate akses).
        $routeMap = [
            'services.index'       => 'services.index',
            'services.create'      => 'services.store',
            'services.store'       => 'services.store',
            'services.edit'        => 'services.update',
            'services.update'      => 'services.update',
            'services.destroy'     => 'services.destroy',
            'services.bulkDestroy' => 'services.destroy',
        ];

        foreach ($routeMap as $route => $permission) {
            Route::firstOrCreate(
                ['route' => $route],
                ['permission_name' => $permission, 'status' => true]
            );
        }

        // Entri menu sidebar (grup Layanan).
        $group = MenuGroup::firstOrCreate(
            ['name' => 'Layanan'],
            [
                'icon' => 'bx-briefcase',
                'permission_name' => 'services.index',
                'position' => (MenuGroup::max('position') ?? 0) + 1,
                'status' => true,
            ]
        );

        MenuItem::firstOrCreate(
            ['route' => 'services.index'],
            [
                'name' => 'Daftar Layanan',
                'permission_name' => 'services.index',
                'menu_group_id' => $group->id,
                'position' => (MenuItem::where('menu_group_id', $group->id)->max('position') ?? 0) + 1,
                'status' => true,
            ]
        );
    }
}
