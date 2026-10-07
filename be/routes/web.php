<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\HomeController;
use Mews\Captcha\CaptchaController;
use App\Http\Controllers\Dashboard\DashboardController;
use App\Http\Controllers\ManagementAccess\RoleController;
use App\Http\Controllers\ManagementAccess\UserController;
use App\Http\Controllers\ManagementAccess\RouteController;
use App\Http\Controllers\ManagementAccess\MenuItemController;
use App\Http\Controllers\ManagementAccess\MenuGroupController;
use App\Http\Controllers\ManagementAccess\PermissionController;

use App\Http\Controllers\Admin\FaqController;
use App\Http\Controllers\FeedController;
use App\Http\Controllers\Admin\BannerController;
use App\Http\Controllers\Admin\AccountController;
use App\Http\Controllers\Admin\AgendaController;
use App\Http\Controllers\Admin\CategoryController;
use App\Http\Controllers\Admin\DocumentController;
use App\Http\Controllers\Admin\DocumentCategoryController;
use App\Http\Controllers\Admin\PagesController;
use App\Http\Controllers\Admin\PollController;
use App\Http\Controllers\Admin\ServiceController;
use App\Http\Controllers\Admin\AduanController;
use App\Http\Controllers\Admin\AduanTindakLanjutController;
use App\Http\Controllers\Admin\SearchController;
use App\Http\Controllers\Admin\PenggunaController;
use App\Http\Controllers\Admin\Security\LoginActivityController;
use App\Http\Controllers\Admin\Security\AuditLogController;
use App\Http\Controllers\Admin\Security\FailedLoginController;
use App\Http\Controllers\Admin\Security\LoginLockoutController;
use App\Http\Controllers\Admin\WebsiteMenuController;
use App\Http\Controllers\Admin\WebsiteMenuItemController;
use App\Http\Controllers\Admin\WebsiteIdentityController;

use App\Http\Controllers\GoogleController;
use App\Http\Controllers\HealthController;
use App\Http\Controllers\SitemapController;
use App\Http\Controllers\WallboardController;
use Illuminate\Support\Facades\Auth;
use App\Http\Middleware\MinifyHtml;

Route::get('/', [HomeController::class, 'index'])->name('home');

// Sitemap dinamis SEO rapih (discoverable via /sitemap.xml & robots.txt)
Route::get('/sitemap.xml', [SitemapController::class, 'index'])->name('sitemap');
Route::get('/robots.txt', function () {
    $sitemap = route('sitemap');
    $content = "User-agent: *\nAllow: /\nSitemap: {$sitemap}\n";
    return response($content, 200)->header('Content-Type', 'text/plain');
})->name('robots');

// Health check sistem (untuk monitoring, boleh publik - json)
Route::get('/health', [HealthController::class, 'index'])->name('health');
// Health page visual - khusus super-admin/admin (jangan publik, bocorkan heartbeat)
Route::get('/health/page', [HealthController::class, 'page'])->middleware(['auth', 'role:super-admin|admin'])->name('health.page');

// Snapshot SEO server-side untuk crawler share (WhatsApp/FB/X/Telegram).
// nginx hanya mem-proxy User-Agent bot pada /agenda/{slug} ke sini;
// manusia tetap ke SPA. Tanpa auth & tanpa session berat.
Route::get('/seo/agenda/{slug}', [\App\Http\Controllers\SeoSnapshotController::class, 'show'])
    ->where('slug', '[^/]+')
    ->name('seo.agenda');

// Wallboard TV pusat pantau (login atau ?token=WALLBOARD_TOKEN)
Route::get('/wallboard', [WallboardController::class, 'index'])->name('wallboard');

// Language switch (khusus login — simpan di session & redirect back)
Route::get('/lang/{locale}', function ($locale) {
    if (in_array($locale, ['id', 'en'], true)) {
        session(['locale' => $locale]);
        app()->setLocale($locale);
    }
    return redirect()->back();
})->name('lang.switch');

// Test route
Route::get('/test-captcha', function () {
    return 'Test captcha route works!';
})->name('test.captcha');

// Socialite Routes GOOGLE
Route::get('/auth/google', [GoogleController::class, 'redirectToGoogle'])->name('googleAuth');
Route::get('/auth/google/callback', [GoogleController::class, 'handleGoogleCallback']);

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    Route::get('/notifications', function (Illuminate\Http\Request $request) {
        $query = auth()->user()->notifications()->latest();

        if ($request->get('filter') === 'unread') {
            $query->whereNull('read_at');
        }

        $notifications = $query->paginate(15)->withQueryString();
        $unreadCount = auth()->user()->unreadNotifications()->count();

        return view('pages.notifications.index', compact('notifications', 'unreadCount'));
    })->name('notifications.index');
    // Keep-alive untuk reset timer idle (dipanggil via JS saat user klik "Tetap Login")
    Route::post('/keep-alive', function (\Illuminate\Http\Request $request) {
        $request->session()->put('last_activity', time());
        return response()->json(['ok' => true]);
    })->name('keep-alive');
});

Route::post('/notifications/{id}/read', function ($id) {
    $notification = auth()->user()->notifications()->findOrFail($id);
    $notification->markAsRead();
    return response()->json(['success' => true]);
})->name('notifications.read');

Route::post('/notifications/read-all', function () {
    auth()->user()->unreadNotifications->markAsRead();
    return response()->json(['success' => true]);
})->name('notifications.readAll');


Route::group(['middleware' => ['web', 'auth', 'verified'], 'prefix' => 'backend'], function () {
    $superAdmin = 'role:super-admin';
    // $user = 'role:user';
    Route::post('/dashboard/sumber-informasi', [DashboardController::class, 'submitSumber'])->name('dashboard.submitSumber');
    Route::get('/dashboard/device-stats', [DashboardController::class, 'deviceStats'])->name('dashboard.device-stats');
    Route::get('/search', [SearchController::class, 'index'])->name('global.search');
    Route::resource('dashboard', DashboardController::class)->only('index');
    Route::resource('user', UserController::class)->middleware($superAdmin)->only('index', 'store', 'update', 'destroy');
    Route::resource('route', RouteController::class)->middleware($superAdmin)->only('index', 'store', 'update', 'destroy');
    Route::resource('permission', PermissionController::class)->middleware($superAdmin)->only('index', 'store', 'update', 'destroy');
    Route::resource('role', RoleController::class)->middleware([$superAdmin])->only('index', 'store', 'update', 'destroy');
    Route::resource('menu', MenuGroupController::class)->middleware($superAdmin)->only('index', 'store', 'update', 'destroy');
    Route::resource('menu.item', MenuItemController::class)->middleware($superAdmin)->only('index', 'store', 'update', 'destroy');
    Route::delete('faq/bulk', [FaqController::class, 'bulkDestroy'])->name('faq.bulkDestroy');
    Route::resource('faq', FaqController::class);
    Route::get('banner/media', [BannerController::class, 'loadMore'])->name('banner.loadMore');
    Route::get('banner/foto-picker', [BannerController::class, 'fotoPicker'])->name('banner.fotoPicker');
    Route::get('banner/album-fotos/{album}', [BannerController::class, 'albumFotos'])->name('banner.albumFotos');
    Route::get('banner/modal/{tipe}/{uuid}', [BannerController::class, 'modal'])->whereIn('tipe', ['foto', 'video', 'album', 'view-album'])->name('banner.modal');
    Route::resource('banner', BannerController::class);
    Route::post('banner/album', [BannerController::class, 'storeAlbum'])->name('banner.storeAlbum');
    Route::put('banner/album/{album}', [BannerController::class, 'updateAlbum'])->name('banner.updateAlbum');
    Route::delete('banner/album/{album}', [BannerController::class, 'destroyAlbum'])->name('banner.destroyAlbum');
    Route::resource('categories', CategoryController::class);
    Route::delete('agendas/bulk', [AgendaController::class, 'bulkDestroy'])->name('agendas.bulkDestroy');
    Route::post('agendas/{agenda}/approve', [AgendaController::class, 'approve'])->name('agendas.approve');
    Route::post('agendas/{agenda}/reject', [AgendaController::class, 'reject'])->name('agendas.reject');
    Route::resource('agendas', AgendaController::class);
    Route::resource('account', AccountController::class);
    Route::get('/get-kelurahan/{kecamatan_id}', [AccountController::class, 'getKelurahan']);
    Route::resource('poll', PollController::class);
    Route::resource('pages', PagesController::class);
    Route::delete('services/bulk', [ServiceController::class, 'bulkDestroy'])->name('services.bulkDestroy');
    Route::resource('services', ServiceController::class)->except(['show']);
    Route::get('aduans/kelurahan/{kecamatan_id}', [AduanController::class, 'getKelurahan'])->name('aduans.kelurahan');
    Route::get('aduans/cek-duplikat', [AduanController::class, 'cekDuplikat'])->name('aduans.cekDuplikat');
    Route::get('aduans/export-pdf', [AduanController::class, 'exportPdf'])->name('aduans.exportPdf');
    Route::post('aduans/{aduan}/restore', [AduanController::class, 'restore'])->name('aduans.restore');
    Route::delete('aduans/{aduan}/force', [AduanController::class, 'forceDestroy'])->name('aduans.forceDestroy');
    Route::post('aduans/{aduan}/rating', [AduanController::class, 'rate'])->name('aduans.rate');
    Route::post('aduans/{aduan}/arsip', [AduanController::class, 'arsip'])->name('aduans.arsip');
    Route::post('aduans/{aduan}/batal-arsip', [AduanController::class, 'batalArsip'])->name('aduans.batalArsip');
    Route::post('aduans/{aduan}/tindak-lanjut', [AduanTindakLanjutController::class, 'store'])->name('aduans.tindak-lanjut.store');
    Route::delete('aduans/tindak-lanjut/{tindakLanjut}', [AduanTindakLanjutController::class, 'destroy'])->name('aduans.tindak-lanjut.destroy');
    Route::get('gis', [AduanController::class, 'gis'])->name('gis.index');
    Route::get('gis/export', [AduanController::class, 'gisExport'])->name('gis.export');
    Route::post('aduans/bulk-destroy', [AduanController::class, 'bulkDestroy'])->name('aduans.bulkDestroy');
    Route::post('aduans/bulk-restore', [AduanController::class, 'bulkRestore'])->name('aduans.bulkRestore');
    Route::resource('aduans', AduanController::class)->only(['index', 'create', 'store', 'show', 'edit', 'update', 'destroy']);
    Route::delete('documents/bulk', [DocumentController::class, 'bulkDestroy'])->name('documents.bulkDestroy');
    Route::resource('documents', DocumentController::class);
    Route::delete('document-categories/bulk', [DocumentCategoryController::class, 'bulkDestroy'])->name('document-categories.bulkDestroy');
    Route::resource('document-categories', DocumentCategoryController::class);
    Route::get('pengguna', [PenggunaController::class, 'index'])->name('pengguna.index');
    Route::get('/pengguna/export', [PenggunaController::class, 'export'])->name('pengguna.export');

    // end payment

    Route::get('kontak', [FaqController::class, 'kontak'])->name('layanan.kontak');
    Route::delete(
        '/kontak/{uuid}',
        [FaqController::class, 'forceDelete']
    )->name('kontak.destroy');
    Route::patch('/pages/{uuid}/sidebar', [PagesController::class, 'updateSidebar'])->name('pages.updateSidebar');

    Route::prefix('security')->name('security.')->group(function () {
        Route::get('login-activity', [LoginActivityController::class, 'index'])->name('login-activity.index');
        Route::delete('login-activity/bulk', [LoginActivityController::class, 'bulkDestroy'])->name('login-activity.bulkDestroy');
        Route::delete('login-activity/clear', [LoginActivityController::class, 'clear'])->name('login-activity.clear');
        Route::delete('login-activity/{loginActivity}', [LoginActivityController::class, 'destroy'])->name('login-activity.destroy');

        Route::get('login-lockout', [LoginLockoutController::class, 'index'])->name('login-lockout.index');
        Route::delete('login-lockout/bulk', [LoginLockoutController::class, 'bulkDestroy'])->name('login-lockout.bulkDestroy');
        Route::delete('login-lockout/{loginLockout}', [LoginLockoutController::class, 'destroy'])->name('login-lockout.destroy');

        Route::get('audit-log', [AuditLogController::class, 'index'])->name('audit-log.index');
        Route::get('audit-log/export-pdf', [AuditLogController::class, 'exportPdf'])->name('audit-log.exportPdf');
        Route::delete('audit-log/bulk', [AuditLogController::class, 'bulkDestroy'])->name('audit-log.bulkDestroy');
        Route::delete('audit-log/clear', [AuditLogController::class, 'clear'])->name('audit-log.clear');
        Route::delete('audit-log/{auditLog}', [AuditLogController::class, 'destroy'])->name('audit-log.destroy');

        Route::get('failed-login', [FailedLoginController::class, 'index'])->name('failed-login.index');
        Route::delete('failed-login/bulk', [FailedLoginController::class, 'bulkDestroy'])->name('failed-login.bulkDestroy');
        Route::delete('failed-login/clear', [FailedLoginController::class, 'clear'])->name('failed-login.clear');
        Route::delete('failed-login/{failedLogin}', [FailedLoginController::class, 'destroy'])->name('failed-login.destroy');
    });

    // Route::get('list-menu', [MenuGroupController::class, 'listMenu'])->name('list-menu');

    Route::resource('website-menu', WebsiteMenuController::class)
        ->middleware('role:admin|super-admin')
        ->parameters(['website-menu' => 'websiteMenu'])
        ->only(['index', 'store', 'update', 'destroy']);

    Route::resource('website-menu.items', WebsiteMenuItemController::class)
        ->middleware('role:admin|super-admin')
        ->parameters(['website-menu' => 'websiteMenu'])
        ->only(['index', 'create', 'store', 'edit', 'update', 'destroy']);

    Route::get('website-identity', [WebsiteIdentityController::class, 'edit'])
        ->middleware('role:admin|super-admin')
        ->name('website-identity.edit');
    Route::put('website-identity', [WebsiteIdentityController::class, 'update'])
        ->middleware('role:admin|super-admin')
        ->name('website-identity.update');
});

Route::get('/captcha-file/{config?}', function ($config = 'flat') {
    $captcha = app('captcha');
    if (ob_get_contents()) {
        ob_clean();
    }
    $response = $captcha->create($config);
    // Jangan biarkan request gambar menimpa "previous URL" session.
    // StartSession menyimpan URL GET terakhir sebagai previous, dan browser
    // selalu me-load gambar ini setelah halaman login — tanpa guard ini,
    // redirect()->back() saat login gagal nyasar ke URL gambar (user tidak
    // melihat notifikasi error). Kembalikan ke halaman login bila tertimpa.
    try {
        $prev = session()->get('_previous.url');
        if (is_string($prev) && str_contains($prev, 'captcha')) {
            session()->setPreviousUrl(route('login'));
        }
    } catch (\Throwable $e) {
        // Abaikan: captcha tetap harus terkirim sebagai gambar.
    }
    // Anti-cache header agar captcha selalu fresh & validasi sesuai session
    return $response
        ->header('Cache-Control', 'no-store, no-cache, must-revalidate, max-age=0')
        ->header('Pragma', 'no-cache')
        ->header('Expires', 'Sat, 01 Jan 2000 00:00:00 GMT');
})->name('captcha.file');
Route::get('/captcha/{config?}', [CaptchaController::class, 'getCaptcha'])->name('captcha.image');
Route::get('/captcha-api/{config?}', [CaptchaController::class, 'getCaptchaApi'])->name('captcha.api');

require __DIR__ . '/auth.php';
