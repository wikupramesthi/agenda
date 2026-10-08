<button {{ $attributes->merge(['type' => 'submit', 'class' => 'btn-soft btn-soft-danger']) }}>
    {{ $slot }}
</button>
