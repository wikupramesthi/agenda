<?php

use Illuminate\Http\Request;

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\FaqController;
use App\Http\Controllers\Api\ArticleController;
use App\Http\Controllers\Api\DocumentController;
use App\Http\Controllers\Api\TestimonialController;
use App\Http\Controllers\Api\ContactController;
use App\Http\Controllers\Api\AgendaController;
use App\Http\Controllers\Api\BannerController;
use App\Http\Controllers\Api\PageController;
use App\Http\Controllers\Api\AduanController;
use App\Http\Controllers\Api\SearchController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ServiceController;
use App\Http\Controllers\Api\WebsiteMenuController;
use App\Http\Controllers\Api\WebsiteIdentityController;
use App\Http\Controllers\Api\AlbumController;
use App\Http\Controllers\Api\OfficialController;



/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// Autentikasi token (Sanctum) untuk Frontend/Mobile.
// Login dibatasi 10x/menit + kunci brute-force (lihat AuthController).
Route::prefix('auth')->group(function () {
    Route::post('/login', [AuthController::class, 'login'])->middleware('throttle:10,1');
    Route::middleware('auth:sanctum')->group(function () {
        Route::get('/me', [AuthController::class, 'me']);
        Route::post('/logout', [AuthController::class, 'logout']);
    });
});

// Layanan: read-only untuk frontend (GET saja) — hanya is_active=active.
Route::middleware('throttle:60,1')->prefix('services')->group(function () {
    Route::get('/', [ServiceController::class, 'index']);
    Route::get('/{uuid}', [ServiceController::class, 'show']);
});


Route::middleware('throttle:60,1')->group(function () {
    Route::get('/faqs', [FaqController::class, 'index']);
    Route::get('/testimonials', [TestimonialController::class, 'index']);
    Route::get('/categories', [ArticleController::class, 'category']);
    Route::get('/banners', [BannerController::class, 'index']);
});
Route::get('/contact/captcha', [ContactController::class, 'captcha'])->middleware('throttle:30,1');
Route::post('/contact', [ContactController::class, 'store'])->middleware('throttle:10,1');

// Album galeri (read-only untuk frontend /album)
Route::middleware('throttle:60,1')->prefix('albums')->group(function () {
    Route::get('/', [AlbumController::class, 'index']);
    Route::get('/{uuid}', [AlbumController::class, 'show']);
});

// Artikel — publik hanya published (lihat ArticleController), throttle anti-scrape
Route::middleware('throttle:60,1')->prefix('articles')->group(function () {
    Route::get('/', [ArticleController::class, 'index']);
    Route::get('category/{slug}', [ArticleController::class, 'byCategory']);
    Route::get('{slug}', [ArticleController::class, 'show']);
});

// Dokumen (read-only untuk frontend; tulis via panel admin)
Route::middleware('throttle:60,1')->group(function () {
    Route::get('/document-categories', [DocumentController::class, 'categories']);
    Route::prefix('documents')->group(function () {
        Route::get('/', [DocumentController::class, 'index']);
        Route::get('/category/{slug}', [DocumentController::class, 'byCategory']);
    });
});

// aduan: baca bebas throttle, lapor wajib login + throttle ketat
Route::middleware('throttle:30,1')->prefix('aduan')->group(function () {
    Route::get('/', [AduanController::class, 'index']);
    Route::get('/track/{nomor_aduan}', [AduanController::class, 'track']);
    Route::post('/', [AduanController::class, 'store'])->middleware(['auth:sanctum', 'throttle:10,1']);
});

// halaman statis — hanya is_published=true (lihat PageController)
Route::middleware('throttle:60,1')->group(function () {
    Route::get('/pages', [PageController::class, 'index']);
    Route::get('/pages/{slug}', [PageController::class, 'show']);
});

// Agenda (modul Agenda; alias /events lama yang duplikat sudah dihapus) — hanya published
Route::middleware('throttle:60,1')->group(function () {
    Route::get('/agenda', [AgendaController::class, 'index']);
    Route::get('/agenda/{slug}', [AgendaController::class, 'show']);
});

// Website Menu (navigasi dinamis)
Route::middleware('throttle:60,1')->group(function () {
    Route::get('/menus', [WebsiteMenuController::class, 'index']);
    Route::get('/menus/{slug}', [WebsiteMenuController::class, 'show']);
});

// Website Identity (SEO, logo, favicon, kontak footer)
Route::middleware('throttle:60,1')->group(function () {
    Route::get('/website-identity', [WebsiteIdentityController::class, 'show']);
    Route::get('/website-identities', [WebsiteIdentityController::class, 'index']); // alias plural
});

// Pejabat (informasi-pejabat) - publik hanya is_pejabat+pegawai+active
Route::middleware('throttle:60,1')->group(function () {
    Route::get('/officials', [OfficialController::class, 'index']);
    Route::get('/officials/{uuid}', [OfficialController::class, 'show']);
});

// Unified Search API (Meilisearch) — throttle ketat anti-abuse
Route::middleware('throttle:30,1')->group(function () {
    Route::get('/search', [SearchController::class, 'search']);
    Route::get('/search/suggest', [SearchController::class, 'suggest']);
});