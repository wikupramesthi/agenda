@extends('layouts.app')

@section('content')

<style>
    .membership-page {
        min-height: 100vh;
        padding: 55px 0 70px;
    }

    /* =========================
       HEADER
    ========================= */

    .membership-header {
        text-align: center;
        max-width: 720px;
        margin: 0 auto 55px;
    }

    .membership-header .eyebrow {
        color: #6d4aff;
        font-size: 13px;
        font-weight: 700;
        letter-spacing: 1.5px;
        text-transform: uppercase;
        margin-bottom: 10px;
    }

    .membership-header h2 {
        font-size: 38px;
        font-weight: 700;
        color: #1f2937;
        margin-bottom: 12px;
    }

    .membership-header p {
        color: #6b7280;
        font-size: 16px;
        line-height: 1.7;
        margin-bottom: 20px;
    }

    .membership-note {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: #fff;
        border: 1px solid #ece9e4;
        border-radius: 50px;
        padding: 9px 18px;
        color: #555;
        font-size: 13px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, .04);
    }

    .membership-note i {
        color: #6d4aff;
    }


    /* =========================
       CARD
    ========================= */

    .membership-card {
        position: relative;
        height: 100%;
        background: #fff;
        border: 1px solid #ece9e4;
        border-radius: 24px;
        padding: 30px;
        display: flex;
        flex-direction: column;
        box-shadow: 0 8px 30px rgba(0, 0, 0, .045);
        transition: all .3s ease;
    }

    .membership-card:hover {
        transform: translateY(-7px);
        box-shadow: 0 18px 45px rgba(0, 0, 0, .10);
    }


    /* =========================
       POPULAR CARD
    ========================= */

    .membership-card.popular {
        background: linear-gradient(145deg,
                #32165f 0%,
                #47217d 50%,
                #29205d 100%);

        border: 2px solid #7047e8;
        color: #fff;
        box-shadow: 0 20px 45px rgba(73, 37, 126, .25);
        transform: translateY(-10px);
    }

    .membership-card.popular:hover {
        transform: translateY(-16px);
    }

    .popular-badge {
        position: absolute;
        top: -14px;
        left: 50%;
        transform: translateX(-50%);
        background: #7047e8;
        color: #fff;
        padding: 7px 18px;
        border-radius: 50px;
        font-size: 12px;
        font-weight: 700;
        white-space: nowrap;
        box-shadow: 0 6px 18px rgba(112, 71, 232, .35);
    }


    /* =========================
       PACKAGE NAME
    ========================= */

    .package-name {
        font-size: 25px;
        font-weight: 700;
        color: #202020;
        margin-bottom: 7px;
    }

    .popular .package-name {
        color: #fff;
    }

    .package-description {
        color: #6b7280;
        font-size: 14px;
        line-height: 1.6;
        min-height: 45px;
        margin-bottom: 22px;
    }

    .popular .package-description {
        color: rgba(255, 255, 255, .78);
    }


    /* =========================
       DIVIDER
    ========================= */

    .package-divider {
        border-top: 1px solid #eee;
        margin-bottom: 22px;
    }

    .popular .package-divider {
        border-color: rgba(255, 255, 255, .16);
    }


    /* =========================
       PRICE
    ========================= */

    .price-label {
        font-size: 13px;
        color: #777;
        margin-bottom: 6px;
    }

    .popular .price-label {
        color: rgba(255, 255, 255, .7);
    }

    .package-price-wrapper {
        margin-bottom: 25px;
    }

    .package-old-price {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 2px;
        min-height: 22px;
    }

    .package-old-price .amount {
        color: #999;
        font-size: 14px;
        text-decoration: line-through;
    }

    .popular .package-old-price .amount {
        color: rgba(255, 255, 255, .55);
    }

    .discount-badge {
        display: inline-flex;
        align-items: center;
        background: #fce8e8;
        color: #d9534f;
        border-radius: 6px;
        padding: 3px 7px;
        font-size: 11px;
        font-weight: 700;
    }

    .popular .discount-badge {
        background: rgba(255, 255, 255, .15);
        color: #fff;
    }

    .package-price {
        display: flex;
        align-items: baseline;
        gap: 5px;
    }

    .package-price .currency {
        font-size: 15px;
        font-weight: 600;
        color: #202020;
    }

    .popular .package-price .currency {
        color: #fff;
    }

    .package-price .amount {
        font-size: 35px;
        font-weight: 800;
        letter-spacing: -1px;
        color: #202020;
        line-height: 1;
    }

    .popular .package-price .amount {
        color: #fff;
    }

    .package-price .period {
        font-size: 13px;
        color: #777;
    }

    .popular .package-price .period {
        color: rgba(255, 255, 255, .7);
    }


    /* =========================
       QUOTA
    ========================= */

    .quota-box {
        background: #fafafa;
        border: 1px solid #eee;
        border-radius: 15px;
        padding: 15px 17px;
        margin-bottom: 25px;
    }

    .popular .quota-box {
        background: rgba(255, 255, 255, .08);
        border-color: rgba(255, 255, 255, .12);
    }

    .quota-label {
        display: flex;
        align-items: center;
        gap: 7px;
        color: #777;
        font-size: 13px;
        margin-bottom: 5px;
    }

    .popular .quota-label {
        color: rgba(255, 255, 255, .7);
    }

    .quota-label i {
        color: #6d4aff;
    }

    .popular .quota-label i {
        color: #b49aff;
    }

    .quota-value {
        font-size: 20px;
        font-weight: 700;
        color: #2d6041;
    }

    .popular .quota-value {
        color: #fff;
    }


    /* =========================
       FEATURES
    ========================= */

    .features-title {
        font-size: 13px;
        font-weight: 700;
        color: #444;
        margin-bottom: 14px;
    }

    .popular .features-title {
        color: #fff;
    }

    .package-features {
        list-style: none;
        padding: 0;
        margin: 0 0 28px;
        flex-grow: 1;
    }

    .package-features li {
        display: flex;
        align-items: flex-start;
        gap: 10px;
        color: #555;
        font-size: 14px;
        line-height: 1.5;
        margin-bottom: 11px;
    }

    .package-features li:last-child {
        margin-bottom: 0;
    }

    .package-features li i {
        color: #39a66b;
        font-size: 14px;
        flex-shrink: 0;
    }

    .popular .package-features li {
        color: rgba(255, 255, 255, .86);
    }

    .popular .package-features li i {
        color: #b49aff;
    }


    /* =========================
       BUTTON
    ========================= */

    .choose-package {
        width: 100%;
        border-radius: 12px;
        padding: 12px 20px;
        font-size: 14px;
        font-weight: 700;
        border: 1.5px solid #6d4aff;
        background: transparent;
        color: #6d4aff;
        transition: all .25s ease;
    }

    .choose-package:hover {
        background: #6d4aff;
        color: #fff;
    }

    .popular .choose-package {
        background: #7047e8;
        border-color: #7047e8;
        color: #fff;
    }

    .popular .choose-package:hover {
        background: #805cf0;
        border-color: #805cf0;
    }


    /* =========================
       BOTTOM TEXT
    ========================= */

    .saving-text {
        text-align: center;
        margin-top: 17px;
        color: #6d4aff;
        font-size: 13px;
        font-weight: 700;
    }

    .popular .saving-text {
        color: rgba(255, 255, 255, .75);
    }


    /* =========================
       RESPONSIVE
    ========================= */

    @media (max-width: 1199px) {

        .membership-card.popular {
            transform: none;
        }

        .membership-card.popular:hover {
            transform: translateY(-7px);
        }
    }


    @media (max-width: 767px) {

        .membership-page {
            padding: 40px 15px 55px;
        }

        .membership-header {
            margin-bottom: 45px;
        }

        .membership-header h2 {
            font-size: 30px;
        }

        .membership-header p {
            font-size: 14px;
        }

        .membership-card {
            padding: 25px;
        }

        .membership-card.popular {
            transform: none;
        }

        .membership-card.popular:hover {
            transform: translateY(-5px);
        }

        .package-price .amount {
            font-size: 31px;
        }
    }
</style>


<div class="membership-page">

    <div class="container">

        {{-- =========================
             HEADER
        ========================= --}}
        <div class="membership-header">

            <div class="eyebrow">
                Yogaroots Membership
            </div>

            <h2>
                Membership Packages
            </h2>

            <p>
                Choose the membership package that suits your yoga journey.
            </p>

            <div class="membership-note">
                <i class="bi bi-stars"></i>
                All packages can be used for Yogaroots classes
            </div>

        </div>


        {{-- =========================
             PACKAGES
        ========================= --}}
        <div class="row g-4 align-items-stretch">

            @forelse ($packages as $package)

            @php

            $isPopular = $package->is_popular;

            /*
            |--------------------------------------------------------------------------
            | Duration
            |--------------------------------------------------------------------------
            */

            $durationLabel = match ($package->duration_unit) {

            'day' => $package->duration > 1
            ? 'Days'
            : 'Day',

            'week' => $package->duration > 1
            ? 'Weeks'
            : 'Week',

            'month' => $package->duration > 1
            ? 'Months'
            : 'Month',

            'year' => $package->duration > 1
            ? 'Years'
            : 'Year',

            default => $package->duration_unit,

            };


            /*
            |--------------------------------------------------------------------------
            | Price
            |--------------------------------------------------------------------------
            */

            $hasDiscount =
            !is_null($package->discount_price)
            && $package->discount_price < $package->price;

                $finalPrice = $hasDiscount
                ? $package->discount_price
                : $package->price;


                /*
                |--------------------------------------------------------------------------
                | Discount Percentage
                |--------------------------------------------------------------------------
                */

                $discountPercent =
                ($hasDiscount && $package->price > 0)
                ? round(
                (
                ($package->price - $package->discount_price)
                / $package->price
                ) * 100
                )
                : 0;

                @endphp


                <div class="col-xl-4 col-lg-4 col-md-6">

                    <div class="membership-card {{ $isPopular ? 'popular' : '' }}">


                        {{-- =========================
                             POPULAR BADGE
                        ========================= --}}
                        @if ($isPopular)

                        <div class="popular-badge">

                            <i class="bi bi-star-fill me-1"></i>

                            POPULAR

                        </div>

                        @endif


                        {{-- =========================
                             PACKAGE NAME
                        ========================= --}}
                        <div class="package-name">

                            {{ $package->name }}

                        </div>


                        {{-- =========================
                             DESCRIPTION
                        ========================= --}}
                        <div class="package-description">

                            {{ $package->description ?: 'Start your yoga journey with a membership designed for you.' }}

                        </div>


                        <div class="package-divider"></div>


                        {{-- =========================
                             PRICE
                        ========================= --}}
                        <div class="price-label">
                            Membership price
                        </div>

                        <div class="package-price-wrapper">


                            {{-- Old Price + Discount --}}
                            @if ($hasDiscount)

                            <div class="package-old-price">

                                <span class="amount">
                                    Rp {{ number_format($package->price, 0, ',', '.') }}
                                </span>

                                <span class="discount-badge">
                                    -{{ $discountPercent }}%
                                </span>

                            </div>

                            @endif


                            {{-- Final Price --}}
                            <div class="package-price">

                                <span class="currency">
                                    Rp
                                </span>

                                <span class="amount">
                                    {{ number_format($finalPrice, 0, ',', '.') }}
                                </span>

                                <span class="period">
                                    / {{ $durationLabel }}
                                </span>

                            </div>

                        </div>


                        {{-- =========================
                             QUOTA
                        ========================= --}}
                        <div class="quota-box">

                            <div class="quota-label">

                                <i class="bi bi-calendar-check"></i>

                                Class Quota

                            </div>

                            <div class="quota-value">

                                @if (is_null($package->quota))

                                Unlimited

                                @else

                                {{ $package->quota }} Classes

                                @endif

                            </div>

                        </div>


                        {{-- =========================
                             FEATURES
                        ========================= --}}
                        <div class="features-title">
                            What's included
                        </div>

                        <ul class="package-features">

                            @forelse ($package->features as $feature)

                            <li>

                                <i class="bi bi-check-circle-fill"></i>

                                <span>
                                    {{ $feature->feature }}
                                </span>

                            </li>

                            @empty

                            <li>

                                <i class="bi bi-check-circle-fill"></i>

                                <span>
                                    Access to Yogaroots classes
                                </span>

                            </li>

                            @endforelse

                        </ul>


                        {{-- =========================
                             BUTTON
                        ========================= --}}
                        <div class="mt-auto">

                            <button
                                type="button"
                                class="choose-package"
                                onclick="choosePackage('{{ $package->uuid }}')">

                                Choose Package

                                <i class="bi bi-arrow-right ms-1"></i>

                            </button>


                            <div class="saving-text">

                                <i class="bi bi-heart-fill me-1"></i>

                                Start your yoga journey

                            </div>

                        </div>

                    </div>

                </div>


                @empty

                {{-- =========================
                     EMPTY STATE
                ========================= --}}
                <div class="col-12">

                    <div class="text-center py-5">

                        <div class="mb-3">

                            <i class="bi bi-box-seam fs-1 text-muted"></i>

                        </div>

                        <h5 class="fw-bold">
                            No Membership Packages Available
                        </h5>

                        <p class="text-muted">
                            Membership packages are currently unavailable.
                        </p>

                    </div>

                </div>

                @endforelse

        </div>

    </div>

</div>


<script>
    function choosePackage(uuid) {

        // Nanti diarahkan ke proses pembelian package
        console.log('Selected package:', uuid);

        // Contoh:
        // window.location.href = '/packages/' + uuid + '/checkout';

    }
</script>

@endsection