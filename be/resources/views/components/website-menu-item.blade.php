@php
    $hasChildren = $item->children->count() > 0;
    $link = $item->link;
    $target = $item->target_blank ? '_blank' : '_self';
    $classes = 'nav-link';
    if ($hasChildren) {
        $classes .= ' dropdown-toggle';
    }
    $depthClass = $depth > 0 ? 'dropdown-item' : 'nav-link';
@endphp

@if ($depth === 0)
    <li class="nav-item {{ $hasChildren ? 'dropdown' : '' }}">
        <a href="{{ $link }}" class="{{ $classes }}" {{ $hasChildren ? 'data-bs-toggle="dropdown"' : '' }} target="{{ $target }}">
            @if ($item->icon)
                <i class="bx {{ $item->icon }} me-2"></i>
            @endif
            {{ $item->name }}
        </a>

        @if ($hasChildren)
            <ul class="dropdown-menu">
                @foreach ($item->children as $child)
                    <x-website-menu-item :item="$child" :depth="1" />
                @endforeach
            </ul>
        @endif
    </li>
@else
    <li>
        <a href="{{ $link }}" class="dropdown-item" target="{{ $target }}">
            @if ($item->icon)
                <i class="bx {{ $item->icon }} me-2"></i>
            @endif
            {{ $item->name }}
        </a>
    </li>
@endif