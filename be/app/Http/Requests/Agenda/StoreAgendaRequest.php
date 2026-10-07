<?php

namespace App\Http\Requests\Agenda;

use Illuminate\Foundation\Http\FormRequest;

class StoreAgendaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user() !== null;
    }

    /**
     * @return array<string, mixed>
     */
    public function rules(): array
    {
        return [
            'title'          => ['required', 'string', 'max:255', 'unique:agendas,title'],
            'excerpt'        => ['nullable', 'string', 'max:255'],
            'content'        => ['required', 'string'],
            'category_uuid'  => ['required', 'exists:categories,uuid'],
            'scheduled_at'   => ['nullable', 'date'],
            'featured_image' => ['nullable', 'image', 'mimes:jpeg,png,jpg,gif,webp', 'max:2048'],
            'images'         => ['nullable', 'array'],
            'images.*'       => ['image', 'mimes:jpeg,png,jpg,gif,webp', 'max:2048'],
            'tagging'        => ['nullable', 'string', 'max:255'],
            'video'          => ['nullable', 'string'],
            'status'         => ['required', 'in:draft,published,scheduled,pending'],
            'search_engine'  => ['required', 'in:index,noindex'],
            'is_featured'    => ['nullable', 'boolean'],
            'is_popular'     => ['nullable', 'boolean'],
        ];
    }

    /**
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'title.required'         => 'Judul agenda wajib diisi.',
            'title.max'              => 'Judul agenda maksimal 255 karakter.',
            'title.unique'           => 'Judul agenda sudah digunakan.',
            'content.required'       => 'Isi agenda wajib diisi.',
            'category_uuid.required' => 'Kategori wajib dipilih.',
            'category_uuid.exists'   => 'Kategori yang dipilih tidak valid.',
            'featured_image.image'   => 'Gambar utama harus berupa gambar.',
            'featured_image.max'     => 'Ukuran gambar utama maksimal 2 MB.',
            'images.*.image'         => 'Setiap foto slider harus berupa gambar.',
            'images.*.max'           => 'Ukuran setiap foto slider maksimal 2 MB.',
            'status.required'        => 'Status publikasi wajib dipilih.',
        ];
    }
}
