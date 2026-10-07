<?php

namespace App\Providers;

use App\Observers\AuditObserver;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\View;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Str;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Aplikasi di-serve dari subpath /be/ di belakang reverse proxy
        // (nginx: /be/ -> 127.0.0.1:8000/, plus ngrok). Karena proxy
        // men-strip prefix /be/, URL generator wajib dipaksa memakai
        // path /be supaya route('captcha.file') dll.
        // menghasilkan https://host/be/... bukan https://host/...
        // Tanpa ini <img captcha> mengarah ke frontend (404/HTML) dan
        // gambar tidak tampil.
        // PENTING: jangan paksa host dari APP_URL mentah-mentah — .env
        // bisa berisi host ngrok sementara user mengakses via domain
        // produksi (atau sebaliknya), yang menyebabkan redirect login
        // lompat host. Ambil path (/be) dari APP_URL tapi host+scheme
        // dari request aktif (yang sudah dipercaya via TrustProxies).
        if ($root = config('app.url')) {
            try {
                $rootPath = parse_url($root, PHP_URL_PATH) ?: '';
                $rootPath = '/' . trim($rootPath, '/');
                $rootPath = $rootPath === '/' ? '' : $rootPath;

                $req = request();
                $host = $req ? $req->getHttpHost() : parse_url($root, PHP_URL_HOST);                $scheme = $req ? $req->getScheme() : parse_url($root, PHP_URL_SCHEME);
                if ($host) {
                    URL::forceRootUrl($scheme . '://' . $host . $rootPath);
                } else {
                    URL::forceRootUrl($root);
                }
                if ($scheme === 'https') {
                    URL::forceScheme('https');
                }
            } catch (\Throwable $e) {
                URL::forceRootUrl($root);
                if (parse_url($root, PHP_URL_SCHEME) === 'https') {
                    URL::forceScheme('https');
                }
            }
        }

        // Listener auth (RecordLoginActivity untuk event Login,
        // RecordFailedLogin untuk event Failed) didaftarkan OTOMATIS oleh
        // Laravel event discovery (lihat app/Listeners). Jangan daftarkan
        // manual via Event::listen di sini agar tidak tercatat 2x lipat.

        Event::listen('eloquent.*', function (string $eventName, array $data) {
            $model = $data[0] ?? null;

            if (! $model instanceof Model) {
                return;
            }

            $action = Str::between($eventName, 'eloquent.', ':');

            if (! in_array($action, ['created', 'updated', 'deleted', 'restored'], true)) {
                return;
            }

            app(AuditObserver::class)->handle($action, $model);
        });

        // Share website identity globally for frontend & backend
        View::composer('*', function ($view) {
            try {
                $identity = \App\Models\WebsiteIdentity::first();
                $view->with('websiteIdentity', $identity);
            } catch (\Throwable $e) {
                $view->with('websiteIdentity', null);
            }
        });
        
    }
}
