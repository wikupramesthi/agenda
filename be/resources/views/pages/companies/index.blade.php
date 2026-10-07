@extends('layouts.app')
@section('title', 'Profil Website')
@section('content')

@section('breadcrumb')
<x-breadcrumb title="Profil Website" page="Profil Website" active="Informasi Umum" route="{{ route('company.index') }}" />
@endsection
<!-- Content -->


<section class="section">
    @if ($message = Session::get('success'))
    <div class="alert alert-success alert-dismissible mb-3 mt-3 fade show" role="alert">
        <span class="alert-text text-white"> {{ $message }}</span>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    @endif
    <div class="card">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center ">
                <h4 class="fw-normal mb-0 text-body">Profil Website</h4>
                <!-- @can('company.store')
                <a href="{{ route('company.create') }}" class="btn btn-primary btn-md"><i class="bi bi-plus-lg"></i>
                    Tambah Baru</a>
                @endcan -->

            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive text-nowrap mx-2">
                <table class="table table-bordered">
                    <tr>
                        <th>No</th>
                        <th>Visi</th>
                        <th>Misi</th>
                        <th>Kebijakan</th>
                        <th>Jasa Pelayanan</th>
                        <th>Aksi</th>
                    </tr>

                    @foreach ($companies as $company)
                    <tr>
                        <td>{{ ++$i }}</td>
                        <td>{{ $company->visi }}</td>
                        <td>{{ $company->misi }}</td>
                        <td>{{ $company->kebijakan }}</td>
                        <td>{{ $company->jasapelayanan }}</td>

                        <td>
                            <form action="{{ route('company.destroy', $company->id) }}" method="POST">
                                <a class="btn btn-sm py-2 btn-info" href="{{ route('company.edit', $company->id) }}">Edit</a>

                            </form>
                        </td>
                    </tr>
                    @endforeach
                </table>

            </div>
        </div>
    </div>
</section>
@endsection