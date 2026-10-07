<?php

use Illuminate\Support\Facades\Route;
use Mews\Captcha\CaptchaController;

Route::group(['middleware' => ['captcha']], function () {
    Route::get('/captcha-file/{config?}', function($config = 'flat') {
        $captcha = app('captcha');
        if (ob_get_contents()) {
            ob_clean();
        }
        return $captcha->create($config);
    })->name('captcha.file');
});