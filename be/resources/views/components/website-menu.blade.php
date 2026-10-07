@foreach ($menus as $menu)
    @foreach ($menu->items as $item)
        @include('components.website-menu-item', ['item' => $item])
    @endforeach
@endforeach