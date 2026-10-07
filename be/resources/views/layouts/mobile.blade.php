<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>@yield('title')</title>

    <link rel="shortcut icon" href="{{ asset('img/fav.png') }}" type="image/x-icon">

    <!-- Style -->
    @stack('before-style')
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet" />
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
        rel="stylesheet" />
    <link rel="stylesheet" href="{{ asset('dist/assets/compiled/css/mobile.css') }}" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
        href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap"
        rel="stylesheet" />

    @stack('after-style')
    <!-- /Style -->

</head>

<body>
    <div class="phone">
        <main>
            @yield('content')
        </main>

        <nav class="tabbar d-flex {{ request()->routeIs('checkout.package') ? 'd-none' : '' }}">

            <button type="button"
                class="tab-item {{ request()->routeIs('dashboard.index') ? 'active' : '' }}"
                onclick="window.location.href='{{ route('dashboard.index') }}'">
                <span class="ico"><i class="bi bi-house"></i></span>
                <span>Home</span>
            </button>

            <button type="button"
                class="tab-item {{ request()->routeIs('packages.member') ? 'active' : '' }}"
                onclick="window.location.href='{{ route('packages.member') }}'">
                <span class="ico"><i class="bi bi-tags"></i></span>
                <span>Plans</span>
            </button>

            <button class=" tab-item tab-booking" data-tab="bookings">
                <span class="ico"><i class="bi bi-calendar-plus"></i></span>
                <span>Book</span>
            </button>

            <button type="button"
                class="tab-item {{ request()->routeIs('profile.edit') ? 'active' : '' }}"
                onclick="window.location.href='{{ route('profile.edit') }}'">
                <span class="ico"><i class="bi bi-person-circle"></i></span>
                <span>Profile</span>
            </button>

        </nav>
    </div>

    <!-- Script -->
    @stack('before-script')
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    @stack('after-script')
    <!-- /Script -->

</body>

</html>