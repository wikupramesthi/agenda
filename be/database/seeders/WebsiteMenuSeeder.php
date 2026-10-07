<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\WebsiteMenu;
use App\Models\WebsiteMenuItem;

class WebsiteMenuSeeder extends Seeder
{
    public function run(): void
    {
        // Header Menu
        $headerMenu = WebsiteMenu::create([
            'name' => 'Header Utama',
            'slug' => 'header-main',
            'location' => 'header',
            'status' => true,
            'position' => 1,
            'description' => 'Menu navigasi utama di header',
        ]);

        $home = WebsiteMenuItem::create([
            'website_menu_id' => $headerMenu->id,
            'name' => 'Beranda',
            'route' => 'home',
            'icon' => 'bx bx-home',
            'position' => 1,
            'status' => true,
        ]);

        $about = WebsiteMenuItem::create([
            'website_menu_id' => $headerMenu->id,
            'name' => 'Tentang Kami',
            'route' => 'about',
            'icon' => 'bx bx-info-circle',
            'position' => 2,
            'status' => true,
        ]);

        $services = WebsiteMenuItem::create([
            'website_menu_id' => $headerMenu->id,
            'name' => 'Layanan',
            'url' => '#',
            'icon' => 'bx bx-cog',
            'position' => 3,
            'status' => true,
        ]);

        WebsiteMenuItem::create([
            'website_menu_id' => $headerMenu->id,
            'parent_id' => $services->id,
            'name' => 'Layanan 1',
            'route' => 'services.detail',
            'route_params' => ['slug' => 'layanan-1'],
            'position' => 1,
            'status' => true,
        ]);

        WebsiteMenuItem::create([
            'website_menu_id' => $headerMenu->id,
            'parent_id' => $services->id,
            'name' => 'Layanan 2',
            'route' => 'services.detail',
            'route_params' => ['slug' => 'layanan-2'],
            'position' => 2,
            'status' => true,
        ]);

        WebsiteMenuItem::create([
            'website_menu_id' => $headerMenu->id,
            'name' => 'Kontak',
            'route' => 'contact',
            'icon' => 'bx bx-envelope',
            'position' => 4,
            'status' => true,
        ]);

        // Footer Menu
        $footerMenu = WebsiteMenu::create([
            'name' => 'Footer Utama',
            'slug' => 'footer-main',
            'location' => 'footer',
            'status' => true,
            'position' => 1,
            'description' => 'Menu navigasi di footer',
        ]);

        WebsiteMenuItem::create([
            'website_menu_id' => $footerMenu->id,
            'name' => 'Kebijakan Privasi',
            'route' => 'privacy',
            'position' => 1,
            'status' => true,
        ]);

        WebsiteMenuItem::create([
            'website_menu_id' => $footerMenu->id,
            'name' => 'Syarat & Ketentuan',
            'route' => 'terms',
            'position' => 2,
            'status' => true,
        ]);

        WebsiteMenuItem::create([
            'website_menu_id' => $footerMenu->id,
            'name' => 'FAQ',
            'route' => 'faq',
            'position' => 3,
            'status' => true,
        ]);

        // Mobile Menu
        $mobileMenu = WebsiteMenu::create([
            'name' => 'Mobile Menu',
            'slug' => 'mobile-main',
            'location' => 'mobile',
            'status' => true,
            'position' => 1,
            'description' => 'Menu untuk tampilan mobile',
        ]);

        WebsiteMenuItem::create([
            'website_menu_id' => $mobileMenu->id,
            'name' => 'Beranda',
            'route' => 'home',
            'icon' => 'bx bx-home',
            'position' => 1,
            'status' => true,
        ]);

        WebsiteMenuItem::create([
            'website_menu_id' => $mobileMenu->id,
            'name' => 'Profil',
            'route' => 'profile.edit',
            'icon' => 'bx bx-user',
            'position' => 2,
            'status' => true,
        ]);

        WebsiteMenuItem::create([
            'website_menu_id' => $mobileMenu->id,
            'name' => 'Logout',
            'route' => 'logout',
            'icon' => 'bx bx-log-out',
            'position' => 3,
            'status' => true,
        ]);
    }
}