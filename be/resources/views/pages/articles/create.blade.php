@extends('layouts.app')
@section('title', 'Tambah Berita')
@section('content')

@section('breadcrumb')
    <x-breadcrumb title="Tambah Berita" page="Berita" active="Tambah Berita" route="{{ route('articles.index') }}" />
@endsection

<section class="section">
    @include('pages.articles.partials.form', [
        'action' => route('articles.store'),
        'method' => 'POST',
        'article' => null,
        'submitLabel' => 'Simpan Berita',
    ])
</section>

@endsection
