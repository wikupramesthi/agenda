<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>@yield('title')</title>

    <meta name="title" content="YogaRoots | Studio Wellness, Yoga & Mindfulness">
    <meta name="description"
        content="YogaRoots adalah studio wellness di Jakarta yang menghadirkan ruang untuk yoga, meditasi, mindfulness, dan praktik kebugaran untuk membantu tubuh dan pikiran lebih seimbang.">
    <meta name="keywords"
        content="YogaRoots Jakarta, studio yoga Jakarta, yoga Jakarta, kelas yoga Jakarta, mindfulness Jakarta, meditasi Jakarta, wellness Jakarta, studio wellness Jakarta">
    <meta name="author" content="YogaRoots">
    <meta name="robots" content="index, follow">

    <meta property="og:title"
        content="YogaRoots | Studio Wellness, Yoga & Mindfulness">
    <meta property="og:description"
        content="Ruang wellness di Jakarta untuk yoga, meditasi, mindfulness, dan praktik kebugaran yang mendukung keseimbangan tubuh dan pikiran.">
    <meta property="og:type" content="website">
    <meta property="og:site_name" content="YogaRoots">
    <meta property="og:image" content="{{ asset('img/seamless-pattern3.png') }}">

    <link rel="shortcut icon" href="{{ asset('img/fav.png') }}" type="image/x-icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Urbanist&display=swap" rel="stylesheet">

    <!-- Google tag (gtag.js) -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-WTJ09KDXS5"></script>
    <script>
        window.dataLayer = window.dataLayer || [];

        function gtag() {
            dataLayer.push(arguments);
        }
        gtag('js', new Date());

        gtag('config', 'G-WTJ09KDXS5');
    </script>


    @vite(['resources/css/app.css'])

</head>

<body class="min-h-screen bg-white selection:bg-primary/10 selection:text-primary dark:bg-gray-900">
    @include('partial.header') 
    @yield('content') 
    @include('partial.footer')

    @stack('before-script')
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
    <script src="https://website-widgets.pages.dev/dist/sienna.min.js" defer></script>
    <script src="{{ asset('/frontend/js/particles.js') }}"></script>
    <script src="{{ asset('/frontend/js/app.js') }}"></script>
    @stack('after-script')

</body>

</html>