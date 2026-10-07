@extends('layouts.app')
@section('title', 'Edit Berita')
@section('content')

@section('breadcrumb')
    <x-breadcrumb title="Edit Berita" page="Berita" active="Edit Berita" route="{{ route('articles.index') }}" />
@endsection

<section class="section">
    @include('pages.articles.partials.form', [
        'action' => route('articles.update', $article->uuid),
        'method' => 'PUT',
        'article' => $article,
        'submitLabel' => 'Perbarui Berita',
    ])
</section>

@endsection
