@extends('layouts.app')

@section('title', 'Classes')

@section('content')

@section('breadcrumb')
<x-breadcrumb
    title="Classes"
    page="Classes"
    active="All Classes"
    route="{{ route('classes.index') }}" />
@endsection

<section class="section">

    @if (session('success'))
    <div class="alert alert-success alert-dismissible mb-3 mt-3 fade show" role="alert">

        <span class="alert-text text-white">
            {{ session('success') }}
        </span>

        <button
            type="button"
            class="btn-close"
            data-bs-dismiss="alert"
            aria-label="Close">

            <span aria-hidden="true">&times;</span>

        </button>

    </div>
    @endif

    {{-- Alert Error --}}
    @if (session('error'))
    <div class="alert alert-danger alert-dismissible mb-3 mt-3 fade show" role="alert">

        <span class="alert-text text-white">
            {{ session('error') }}
        </span>

        <button
            type="button"
            class="btn-close"
            data-bs-dismiss="alert"
            aria-label="Close">

            <span aria-hidden="true">&times;</span>

        </button>

    </div>
    @endif

    <div class="card">

        <div class="card-header">

            <div class="d-flex align-items-center justify-content-between gap-3 flex-wrap">

                <form
                    action="{{ route('classes.index') }}"
                    method="GET"
                    class="d-flex align-items-center gap-2 flex-wrap flex-grow-1">

                    {{-- Level --}}
                    <div class="input-group input-group-sm" style="width: 220px;">

                        <span class="input-group-text">
                            Level
                        </span>

                        <select
                            name="level"
                            class="form-select">

                            <option value="">-- All --</option>

                            <option
                                value="foundation"
                                {{ request('level') == 'foundation' ? 'selected' : '' }}>
                                Foundation
                            </option>

                            <option
                                value="intermediate"
                                {{ request('level') == 'intermediate' ? 'selected' : '' }}>
                                Intermediate
                            </option>

                            <option
                                value="advance"
                                {{ request('level') == 'advance' ? 'selected' : '' }}>
                                Advance
                            </option>

                        </select>

                    </div>


                    {{-- Instructor --}}
                    @if(auth()->user()->hasRole('admin') || auth()->user()->hasRole('superadmin'))

                    <div
                        class="input-group input-group-sm"
                        style="width: 260px;">

                        <span class="input-group-text">
                            Instructor
                        </span>

                        <select
                            name="instructor_uuid"
                            class="form-select">

                            <option value="">
                                All Instructors
                            </option>

                            @foreach($instructors as $instructor)

                            <option
                                value="{{ $instructor->uuid }}"
                                {{ request('instructor_uuid') == $instructor->uuid ? 'selected' : '' }}>

                                {{ $instructor->name }}

                            </option>

                            @endforeach

                        </select>

                    </div>

                    @endif


                    {{-- Status --}}
                    <div
                        class="input-group input-group-sm"
                        style="width: 190px;">

                        <span class="input-group-text">
                            Status
                        </span>

                        <select
                            name="is_active"
                            class="form-select">

                            <option value="">
                                -- All --
                            </option>

                            <option
                                value="active"
                                {{ request('is_active') == 'active' ? 'selected' : '' }}>
                                Active
                            </option>

                            <option
                                value="inactive"
                                {{ request('is_active') == 'inactive' ? 'selected' : '' }}>
                                Inactive
                            </option>

                        </select>

                    </div>


                    {{-- Filter --}}
                    <button
                        type="submit"
                        class="btn btn-sm btn-success px-3">

                        <i class="bi bi-funnel me-1"></i>
                        Filter

                    </button>


                    {{-- Reset --}}
                    <a
                        href="{{ route('classes.index') }}"
                        class="btn btn-sm btn-secondary px-3">

                        <i class="bi bi-arrow-counterclockwise me-1"></i>
                        Reset

                    </a>

                </form>


                {{-- =========================
            ADD CLASS
        ========================== --}}
                <div class="flex-shrink-0">

                    @can('classes.create')

                    <a
                        href="{{ route('classes.create') }}"
                        class="btn btn-primary btn-md">

                        <i class="bi bi-plus-lg me-1"></i>
                        Add Class

                    </a>

                    @endcan

                </div>

            </div>

        </div>

        <div class="card-body">

            <div class="table-responsive text-nowrap mx-2">

                <table
                    class="table table-bordered"
                    id="table1">

                    <thead>

                        <tr>

                            <th>No.</th>
                            <th>Class</th>
                            <th>Level</th>
                            <th>Duration</th>
                            <th>Instructor</th>
                            <th>Price</th>
                            <th>Quota Cost</th>
                            <th>Status</th>
                            <th>Edit</th>
                            <th>Delete</th>

                        </tr>

                    </thead>

                    <tbody>

                        @foreach ($classes as $class)

                        <tr>

                            {{-- No --}}
                            <td>
                                {{ $loop->iteration }}
                            </td>

                            {{-- Class --}}
                            <td>

                                <div class="d-flex align-items-center gap-2">

                                    @if ($class->image)

                                    <img
                                        src="{{ asset('storage/' . $class->image) }}"
                                        alt="{{ $class->name }}"
                                        width="60"
                                        height="60"
                                        class="rounded"
                                        style="object-fit: cover;">

                                    @else

                                    <div
                                        class="bg-light rounded d-flex align-items-center justify-content-center"
                                        style="width:60px;height:60px;">

                                        <i class="bi bi-image text-muted fs-4"></i>

                                    </div>

                                    @endif

                                    <div>

                                        <strong>
                                            {{ $class->name }}
                                        </strong>

                                        @if ($class->description)

                                        <br>

                                        <small class="text-muted">

                                            {{ \Illuminate\Support\Str::limit($class->description, 80) }}

                                        </small>

                                        @endif

                                    </div>

                                </div>

                            </td>

                            {{-- Level --}}
                            <td>
                                @switch($class->level)

                                @case('foundation')
                                <span
                                    class="badge bg-success"
                                    role="button"
                                    data-bs-toggle="modal"
                                    data-bs-target="#modal-change-level-{{ $class->uuid }}">
                                    Foundation
                                </span>
                                @break

                                @case('intermediate')
                                <span
                                    class="badge bg-warning text-dark"
                                    role="button"
                                    data-bs-toggle="modal"
                                    data-bs-target="#modal-change-level-{{ $class->uuid }}">
                                    Intermediate
                                </span>
                                @break

                                @case('advance')
                                <span
                                    class="badge bg-danger"
                                    role="button"
                                    data-bs-toggle="modal"
                                    data-bs-target="#modal-change-level-{{ $class->uuid }}">
                                    Advance
                                </span>
                                @break

                                @default
                                <span
                                    class="badge bg-secondary"
                                    role="button"
                                    data-bs-toggle="modal"
                                    data-bs-target="#modal-change-level-{{ $class->uuid }}">
                                    -
                                </span>

                                @endswitch
                            </td>

                            {{-- Duration --}}
                            <td>

                                @if ($class->duration)

                                {{ $class->duration }} min

                                @else

                                -

                                @endif

                            </td>

                            {{-- Instructor --}}
                            <td>

                                @if ($class->instructor)

                                <div class="d-flex align-items-center gap-2">

                                    @if ($class->instructor->foto)

                                    <img
                                        src="{{ asset('storage/' . $class->instructor->foto) }}"
                                        alt="{{ $class->instructor->name }}"
                                        width="35"
                                        height="35"
                                        class="rounded-circle"
                                        style="object-fit: cover;">

                                    @endif

                                    <span>
                                        {{ $class->instructor->name }}
                                    </span>

                                </div>

                                @else

                                <span class="text-muted">
                                    -
                                </span>

                                @endif

                            </td>

                            {{-- Price --}}
                            <td>

                                <strong>
                                    Rp {{ number_format($class->price, 0, ',', '.') }}
                                </strong>

                            </td>

                            {{-- Quota Cost --}}
                            <td>

                                <span class="badge bg-secondary">
                                    {{ $class->quota_cost }}x
                                </span>

                            </td>

                            {{-- Status --}}
                            <td>

                                @if ($class->is_active === 'active')

                                <span class="badge bg-success">
                                    Active
                                </span>

                                @else

                                <span class="badge bg-secondary">
                                    Inactive
                                </span>

                                @endif

                            </td>

                            {{-- Edit --}}
                            <td>

                                @can('classes.update')

                                <a href="{{ route('classes.edit', $class->uuid) }}" title="Edit"
                                    class="btn btn-icon btn-success text-white">
                                    <i class="bi bi-pencil-square"></i> Edit
                                </a>

                                @endcan

                            </td>

                            {{-- Delete --}}
                            <td>

                                @can('classes.destroy')

                                <a
                                    onclick="showSweetAlert('{{ $class->uuid }}')"
                                    title="Delete"
                                    class="btn btn-icon btn-danger text-white">

                                    <i class="bi bi-x-square"></i>
                                    Delete

                                </a>

                                <form
                                    id="deleteForm_{{ $class->uuid }}"
                                    action="{{ route('classes.destroy', $class->uuid) }}"
                                    method="POST">

                                    @method('DELETE')
                                    @csrf

                                </form>

                                @endcan

                            </td>

                        </tr>

                        @endforeach

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</section>

@include('pages.class.modal-change-level')

<script>
    function showSweetAlert(getId) {

        Swal.fire({

            title: 'Delete Class?',
            text: 'This class will be permanently deleted. Are you sure?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes, Delete!',
            cancelButtonText: 'Cancel'

        }).then((result) => {

            if (result.isConfirmed) {

                document
                    .getElementById('deleteForm_' + getId)
                    .submit();

            }

        });

    }
</script>

@endsection