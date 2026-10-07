@extends('layouts.app')
@section('title', 'Edit Profil Website')
@section('content')

@section('breadcrumb')
<x-breadcrumb title="Profil Website" page="Profil Website" active="Edit Detail Website" route="{{ route('company.index') }}" />
@endsection

<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title mb-5">Edit Detail Website</h4>
                @if ($errors->any())
                <div class="alert alert-danger">
                    <strong>Whoops!</strong> There were some problems with your input.<br><br>
                    <ul>
                        @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
                @endif

                <form action="{{ route('company.update', $company->id) }}" method="POST">
                    @csrf
                    @method('put')

                    <div class="form-group mb-3">
                        <label for="visi">Visi:</label>
                        <input type="text" name="visi" class="form-control" placeholder="Masukkan Visi Perusahaan" value="{{ $company->visi }}">
                    </div>

                    <div class="form-group mb-3">
                        <label for="misi">Misi:</label>
                        <textarea name="misi" class="form-control" placeholder="Masukkan Misi Perusahaan">{{ $company->misi }}</textarea>
                    </div>

                    <div class="form-group mb-3">
                        <label for="kebijakan">Kebijakan:</label>
                        <textarea name="kebijakan" class="form-control" placeholder="Masukkan Kebijakan Perusahaan">{{ $company->kebijakan }}</textarea>
                    </div>

                    <div class="form-group mb-3">
                        <label for="jasapelayanan">Jasa Pelayanan:</label>
                        <textarea name="jasapelayanan" class="form-control" placeholder="Masukkan Jasa Pelayanan Perusahaan">{{ $company->jasapelayanan }}</textarea>
                    </div>

                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
        </div>
    </div>
</div>
@endsection