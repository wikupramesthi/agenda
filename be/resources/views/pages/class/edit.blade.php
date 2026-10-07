@extends('layouts.app')

@section('title', 'Edit Class')

@section('content')

@section('breadcrumb')
<x-breadcrumb
    title="Edit Class"
    page="Classes"
    active="Edit Class"
    route="{{ route('classes.index') }}" />
@endsection

<section class="section">

    <div class="card">

        <div class="card-body">

            <form
                action="{{ route('classes.update', $class->uuid) }}"
                method="POST"
                enctype="multipart/form-data">

                @csrf
                @method('PUT')

                {{-- Class Name --}}
                <div class="form-group mb-3">

                    <label for="name" class="mb-2">
                        Class Name <span class="text-danger">*</span>
                    </label>

                    <input
                        type="text"
                        name="name"
                        id="name"
                        placeholder="Example: Hatha Yoga"
                        value="{{ old('name', $class->name) }}"
                        class="form-control @error('name') is-invalid @enderror"
                        required>

                    @error('name')
                    <div class="invalid-feedback">{{ $message }}</div>
                    @enderror

                </div>

                {{-- Image --}}
                <div class="form-group mb-3">

                    <label for="image" class="mb-2">
                        Class Image
                    </label>

                    @if ($class->image)
                    <div class="mb-2">
                        <img
                            src="{{ asset('storage/' . $class->image) }}"
                            alt="{{ $class->name }}"
                            style="width: 150px; height: 100px; object-fit: cover; border-radius: 6px;">
                    </div>
                    @endif

                    <input
                        type="file"
                        name="image"
                        id="image"
                        class="form-control @error('image') is-invalid @enderror"
                        accept="image/*">

                    <small class="text-muted">
                        Leave empty if you don't want to change the image.
                    </small>

                    @error('image')
                    <div class="invalid-feedback">{{ $message }}</div>
                    @enderror

                </div>

                <div class="row">

                    {{-- Level --}}
                    <div class="col-md-6 mb-3">

                        <label for="level" class="mb-2">
                            Level <span class="text-danger">*</span>
                        </label>

                        <select
                            name="level"
                            id="level"
                            class="form-control @error('level') is-invalid @enderror"
                            required>

                            <option value="">-- Select Level --</option>

                            <option value="foundation"
                                {{ old('level', $class->level) == 'foundation' ? 'selected' : '' }}>
                                Foundation
                            </option>

                            <option value="intermediate"
                                {{ old('level', $class->level) == 'intermediate' ? 'selected' : '' }}>
                                Intermediate
                            </option>

                            <option value="advance"
                                {{ old('level', $class->level) == 'advance' ? 'selected' : '' }}>
                                Advance
                            </option>

                        </select>

                        @error('level')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror

                    </div>

                    {{-- Duration --}}
                    <div class="col-md-6 mb-3">

                        <label for="duration" class="mb-2">
                            Duration <span class="text-danger">*</span>
                        </label>

                        <input
                            type="number"
                            name="duration"
                            id="duration"
                            placeholder="Example: 60"
                            value="{{ old('duration', $class->duration) }}"
                            min="1"
                            class="form-control @error('duration') is-invalid @enderror"
                            required>

                        <small class="text-muted">
                            Duration in minutes
                        </small>

                        @error('duration')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror

                    </div>

                </div>

                {{-- Instructor --}}
                <div class="form-group mb-3">

                    <label for="instructor_uuid" class="mb-2">
                        Instructor <span class="text-danger">*</span>
                    </label>

                    @if(
                    auth()->user()->hasRole('admin') ||
                    auth()->user()->hasRole('superadmin')
                    )

                    <select
                        name="instructor_uuid"
                        id="instructor_uuid"
                        class="form-control @error('instructor_uuid') is-invalid @enderror"
                        required>

                        <option value="">-- Select Instructor --</option>

                        @foreach ($instructors as $instructor)
                        <option
                            value="{{ $instructor->uuid }}"
                            {{ old('instructor_uuid', $class->instructor_uuid) == $instructor->uuid ? 'selected' : '' }}>
                            {{ $instructor->name }}
                        </option>
                        @endforeach

                    </select>

                    @error('instructor_uuid')
                    <div class="invalid-feedback">
                        {{ $message }}
                    </div>
                    @enderror

                    @else

                    <input
                        type="text"
                        class="form-control"
                        value="{{ auth()->user()->name }}"
                        readonly>

                    <input
                        type="hidden"
                        name="instructor_uuid"
                        value="{{ auth()->user()->uuid }}">

                    <small class="text-muted">
                        You are automatically assigned as the instructor for this class.
                    </small>

                    @endif

                </div>

                <div class="row">

                    {{-- Price --}}
                    <div class="col-md-6 mb-3">

                        <label for="price" class="mb-2">
                            Price
                        </label>

                        <input
                            type="number"
                            name="price"
                            id="price"
                            placeholder="Leave empty if free"
                            value="{{ old('price', $class->price) }}"
                            min="0"
                            class="form-control @error('price') is-invalid @enderror">

                        <small class="text-muted">
                            Optional. Leave empty for free classes.
                        </small>

                        @error('price')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror

                    </div>

                    {{-- Quota Cost --}}
                    <div class="col-md-6 mb-3">

                        <label for="quota_cost" class="mb-2">
                            Quota Cost <span class="text-danger">*</span>
                        </label>

                        <input
                            type="number"
                            name="quota_cost"
                            id="quota_cost"
                            placeholder="Example: 1"
                            value="{{ old('quota_cost', $class->quota_cost) }}"
                            min="1"
                            class="form-control @error('quota_cost') is-invalid @enderror"
                            required>

                        @error('quota_cost')
                        <div class="invalid-feedback">{{ $message }}</div>
                        @enderror

                    </div>

                </div>

                {{-- Status --}}
                <div class="form-group mb-3">

                    <label for="is_active" class="mb-2">
                        Status <span class="text-danger">*</span>
                    </label>

                    <select
                        name="is_active"
                        id="is_active"
                        class="form-control @error('is_active') is-invalid @enderror"
                        required>

                        <option value="active"
                            {{ old('is_active', $class->is_active) == 'active' ? 'selected' : '' }}>
                            Active
                        </option>

                        <option value="inactive"
                            {{ old('is_active', $class->is_active) == 'inactive' ? 'selected' : '' }}>
                            Inactive
                        </option>

                    </select>

                    @error('is_active')
                    <div class="invalid-feedback">{{ $message }}</div>
                    @enderror

                </div>

                {{-- Description --}}
                <div class="form-group mb-3">

                    <label for="description" class="mb-2">
                        Description
                    </label>

                    <textarea
                        name="description"
                        id="description"
                        rows="4"
                        placeholder="Class description"
                        class="form-control @error('description') is-invalid @enderror">{{ old('description', $class->description) }}</textarea>

                    @error('description')
                    <div class="invalid-feedback">{{ $message }}</div>
                    @enderror

                </div>

                {{-- Button --}}
                <div class="form-group text-right mt-4">

                    <a
                        href="{{ route('classes.index') }}"
                        class="btn btn-secondary me-2">
                        Cancel
                    </a>

                    <button
                        type="submit"
                        class="btn btn-danger">
                        Update
                    </button>

                </div>

            </form>

        </div>

    </div>

</section>

@endsection