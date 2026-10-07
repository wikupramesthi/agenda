@extends('layouts.app')
@section('title', 'Tambah Agenda')
@section('breadcrumb')
<x-breadcrumb title="Tambah Agenda" page="Agenda" active="Tambah Agenda" route="{{ route('agenda.index') }}" />
@endsection
@section('content')
<section class="section">
    <div class="card">
        <div class="card-body">
            <form action="{{ route('agenda.store') }}" method="POST" enctype="multipart/form-data">
                @csrf
                @include('pages.agenda._form', ['item' => null])
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Simpan Agenda</button>
                    <a href="{{ route('agenda.index') }}" class="btn btn-light">Batal</a>
                </div>
            </form>
        </div>
    </div>
</section>
@endsection
