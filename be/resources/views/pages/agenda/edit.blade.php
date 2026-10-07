@extends('layouts.app')
@section('title', 'Edit Agenda')
@section('breadcrumb')
<x-breadcrumb title="Edit Agenda" page="Agenda" active="Edit Agenda" route="{{ route('agenda.index') }}" />
@endsection
@section('content')
<section class="section">
    <div class="card">
        <div class="card-body">
            <form action="{{ route('agenda.update', $item->uuid) }}" method="POST" enctype="multipart/form-data">
                @csrf @method('PUT')
                @include('pages.agenda._form', ['item' => $item])
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Update Agenda</button>
                    <a href="{{ route('agenda.index') }}" class="btn btn-light">Batal</a>
                </div>
            </form>
        </div>
    </div>
</section>
@endsection
