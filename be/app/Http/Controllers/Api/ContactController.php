<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Kontak;
use App\Models\User;
use App\Notifications\KontakBaruNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Str;

class ContactController extends Controller
{
    public function captcha()
    {
        $a = rand(1, 9);
        $b = rand(1, 9);

        $captchaId = Str::uuid()->toString();

        Cache::put(
            'contact_captcha_' . $captchaId,
            $a + $b,
            now()->addMinutes(10)
        );

        return response()->json([
            'status' => 'success',
            'data' => [
                'captcha_id' => $captchaId,
                'question' => "How much is the result of {$a} + {$b}?"
            ]
        ]);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nama' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'no_telp' => 'required|string|max:20',
            'isi' => 'required|string',
            'captcha_id' => 'required|string',
            'captcha_answer' => 'required|integer',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validasi gagal.',
                'errors' => $validator->errors(),
            ], 422);
        }

        // Ambil jawaban CAPTCHA dari cache
        $cacheKey = 'contact_captcha_' . $request->captcha_id;
        $correctAnswer = Cache::get($cacheKey);

        if ($correctAnswer === null) {
            return response()->json([
                'success' => false,
                'message' => 'CAPTCHA sudah kedaluwarsa. Silakan muat ulang halaman.',
            ], 422);
        }

        // Cek jawaban
        if ((int) $request->captcha_answer !== (int) $correctAnswer) {
            return response()->json([
                'success' => false,
                'message' => 'Jawaban CAPTCHA salah.',
            ], 422);
        }

        // CAPTCHA benar → hapus supaya tidak bisa dipakai ulang
        Cache::forget($cacheKey);

        // Simpan ke database
        $contact = Kontak::create([
            'nama' => $request->nama,
            'email' => $request->email,
            'no_telp' => $request->no_telp,
            'isi' => $request->isi,
        ]);

        // Beri tahu petugas backend
        try {
            $petugas = User::role(['super-admin', 'admin'])->get();

            foreach ($petugas as $orang) {
                $orang->notify(new KontakBaruNotification(
                    $contact->nama,
                    Str::limit($contact->isi, 80)
                ));
            }
        } catch (\Throwable $e) {
            report($e);
        }

        return response()->json([
            'success' => true,
            'message' => 'Pesan berhasil dikirim. Kami akan segera menghubungi Anda.',
            'data' => $contact,
        ], 201);
    }
}
