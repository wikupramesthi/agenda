@extends('layouts.auth')
@section('title', '404')
@section('content')

   <div class="nf-stage">
        <div class="nf-blob nf-blob-a" aria-hidden="true"></div>
        <div class="nf-blob nf-blob-b" aria-hidden="true"></div>
        <div class="nf-blob nf-blob-c" aria-hidden="true"></div>

        <!-- Logo -->
        <a href="#" class="nf-mast" aria-label="Beranda DBMSDA Kota Bekasi">
            <img src="{{ asset('img/logo.png') }}" class="auth-brand-logo-wrap" alt="Logo DBMSDA Kota Bekasi" decoding="async">
        </a>

        <!-- Orb hiasan -->
        <div class="nf-orb" aria-hidden="true">
            <svg viewBox="0 0 240 140" xmlns="http://www.w3.org/2000/svg">
                <circle cx="120" cy="70" r="56" class="nf-orb-halo"/>
                <ellipse cx="120" cy="70" rx="58" ry="14" class="nf-orb-band nf-orb-band-dash"/>
                <ellipse cx="120" cy="70" rx="48" ry="11" class="nf-orb-band nf-orb-band-gold"/>
                <circle cx="120" cy="70" r="22" class="nf-orb-core"/>
                <circle cx="111" cy="62" r="6" class="nf-orb-glint"/>
                <circle r="4.2" fill="#FCAC0A" class="nf-orb-moon">
                    <animateMotion dur="12s" repeatCount="indefinite" path="M62,70 a58,14 0 1,1 116,0 a58,14 0 1,1 -116,0"/>
                    <animate attributeName="opacity" values="0.45;0.95;0.45" dur="12s" repeatCount="indefinite"/>
                </circle>
            </svg>
        </div>

        <!-- Konten -->
        <div class="nf-center">
            <div class="nf-code" role="img" aria-label="404">
                <span class="nf-num nf-num-first">4</span>
                <span class="nf-lens nf-num-mid">
                    <span class="nf-lens-halo" aria-hidden="true"></span>
                    <span class="nf-lens-band" aria-hidden="true"></span>
                    <span class="nf-lens-core" aria-hidden="true"></span>
                    <span class="nf-lens-glint" aria-hidden="true"></span>
                    0
                </span>
                <span class="nf-num nf-num-last">4</span>
            </div>

            <h1 class="nf-title">Ups, halaman tidak ditemukan.</h1>
            <p class="nf-copy">
                Sepertinya halaman yang Anda cari sudah dipindah, dihapus,
                atau alamatnya tidak tepat. Silakan kembali ke beranda atau coba masuk kembali.
            </p>

            <div class="nf-cta">
                <a href="https://dbmsda.bekasikota.go.id/" class="nf-btn-solid">
                    <i class="ti ti-login-2" aria-hidden="true"></i><span>Kembali ke Beranda</span>
                </a>
            </div>

            <div class="nf-foot">
                <small>
                        © {{ date('Y') }}
                        <a href="#">DBMSDA Kota Bekasi.</a>
                        All Rights Reserved
                    </small>

            </div>
        </div>
    </div>

@endsection