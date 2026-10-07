<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Concerns\HandlesTransactions;
use App\Http\Requests\Admin\StoreDepartmentRequest;
use App\Http\Requests\Admin\UpdateDepartmentRequest;
use App\Models\Department;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class DepartmentController extends Controller
{
    
    use HandlesTransactions;
/**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $search = $request->input('search');
        $departments = Department::withCount([
                'users as departments_count'
            ])
            ->when($search, function ($query) use ($search) {
                $query->where(function ($q) use ($search) {
                    $q->where('name', 'like', "%{$search}%")
                        ->orWhere('description', 'like', "%{$search}%");
                });
            })
            ->paginate(10)->withQueryString();

        return view(
            'pages.departments.index',
            compact('departments', 'search')
        );
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreDepartmentRequest $request)
    {
        return $this->transactional(function () use ($request) {
            $slug = $this->uniqueSlug($request->name);
            Department::create([
                'uuid' => (string) Str::uuid(),
                'name' => $request->name,
                'slug' => $slug,
                'description' => $request->description,
            ]);
        }, 'Kategori jabatan berhasil ditambahkan.');
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateDepartmentRequest $request, $uuid)
    {
        return $this->transactional(function () use ($request, $uuid) {
            $item = Department::where('uuid', $uuid)->firstOrFail();
            $slug = $this->uniqueSlug($request->name, $uuid);
            $item->update([
                'name' => $request->name,
                'slug' => $slug,
                'description' => $request->description,
            ]);
        }, 'Kategori jabatan berhasil diperbarui.');
    }

    private function uniqueSlug(string $name, ?string $ignoreUuid = null): string
    {
        $base = Str::slug($name);
        $slug = $base;
        $i = 1;
        while (Department::where('slug', $slug)->when($ignoreUuid, fn($q) => $q->where('uuid', '!=', $ignoreUuid))->exists()) {
            $slug = $base . '-' . $i++;
        }
        return $slug;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($uuid)
    {
        return $this->transactional(function () use ($uuid) {
            $item = Department::where('uuid', $uuid)->firstOrFail();
            $item->delete();
        }, 'Kategori jabatan berhasil dihapus.');
    }
}
