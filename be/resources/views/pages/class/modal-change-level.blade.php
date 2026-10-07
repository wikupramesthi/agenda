@foreach ($classes as $class)
<div
    class="modal fade"
    id="modal-change-level-{{ $class->uuid }}"
    tabindex="-1"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <form action="{{ route('classes.change-level', $class->uuid) }}" method="POST">
                @csrf
                @method('PATCH')

                <div class="modal-header">
                    <h5 class="modal-title">Change Level</h5>

                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">

                    <label class="form-label">
                        Level
                    </label>

                    <select name="level" class="form-select" required>
                        <option value="foundation"
                            {{ $class->level === 'foundation' ? 'selected' : '' }}>
                            Foundation
                        </option>

                        <option value="intermediate"
                            {{ $class->level === 'intermediate' ? 'selected' : '' }}>
                            Intermediate
                        </option>

                        <option value="advance"
                            {{ $class->level === 'advance' ? 'selected' : '' }}>
                            Advance
                        </option>
                    </select>

                </div>

                <div class="modal-footer">
                    <button
                        type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal">
                        Cancel
                    </button>

                    <button type="submit" class="btn btn-primary">
                        Save
                    </button>
                </div>

            </form>

        </div>
    </div>
</div>
@endforeach