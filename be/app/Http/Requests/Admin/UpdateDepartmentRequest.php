<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class UpdateDepartmentRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $uuid = $this->route('department') ?? $this->route('uuid') ?? $this->input('uuid');
        return [
            'name' => ['required', 'string', 'max:255', 'unique:departments,name,' . $uuid . ',uuid'],
            'description' => ['nullable', 'string'],
        ];
    }
}
