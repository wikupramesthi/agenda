<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Concerns\HandlesTransactions;
use App\Models\Document;
use App\Models\DocumentCategory;
use App\Services\HtmlSanitizer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class DocumentController extends Controller
{
    
    use HandlesTransactions;
/**
     * Display a listing of the documents.
     */

    public function index(Request $request)
    {
        $baseQuery = Document::query();

        // Searching
        if ($request->filled('search')) {
            $search = $request->search;

            $baseQuery->where(function ($q) use ($search) {
                $q->where('title', 'like', '%' . $search . '%')
                    ->orWhere('excerpt', 'like', '%' . $search . '%');
            });
        }

        // Filter kategori
        if ($request->filled('category_uuid')) {
            $baseQuery->where('category_uuid', $request->category_uuid);
        }

        // Filter status
        if ($request->filled('status')) {
            $baseQuery->where('status', $request->status);
        }

        // Statistik dihitung dari query yang SUDAH difilter (tanpa paginasi),
        // sehingga angka pada card selalu sesuai dengan data hasil filter.
        $stats = [
            'total'      => (clone $baseQuery)->count(),
            'active'     => (clone $baseQuery)->where('status', 'active')->count(),
            'inactive'   => (clone $baseQuery)->where('status', 'inactive')->count(),
            'categories' => (clone $baseQuery)->distinct()->count('category_uuid'),
        ];

        $documents = $baseQuery
            ->with('category')
            ->orderByDesc('published_at')
            ->paginate(10)
            ->withQueryString();

        $categories = DocumentCategory::orderBy('name')->get();

        return view(
            'pages.documents.index',
            compact('documents', 'categories', 'stats')
        );
    }


    /**
     * Show the form for creating a new document.
     */
    public function create()
    {
        $categories = DocumentCategory::where('status', 'active')
            ->orderBy('name')
            ->get();

        return view('pages.documents.create', compact('categories'));
    }

    /**
     * Store a newly created.
     */
    public function store(Request $request)
    {
        $request->validate([
            'category_uuid' => 'required|exists:document_categories,uuid',
            'title'         => 'required|string|max:255',
            'slug'          => 'nullable|string|max:255|unique:documents,slug',
            'excerpt'       => 'nullable|string|max:500',
            'description'   => 'nullable|string',
            'published_at'  => 'nullable|date',
            'file'          => 'required|file|mimes:pdf,doc,docx,xls,xlsx,ppt,pptx|max:10240',
            'thumbnail'     => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
            'status'        => 'required|in:active,inactive',
        ]);

        $filePath = null;
        $thumbPath = null;
        try {
            $filePath = $request->file('file')->store('documents/files', 'public');
            if ($request->hasFile('thumbnail')) {
                $thumbPath = $request->file('thumbnail')->store('documents/thumbnails', 'public');
            }
            \Illuminate\Support\Facades\DB::beginTransaction();
            Document::create([
                'category_uuid' => $request->category_uuid,
                'title'        => $request->title,
                'slug'         => $request->slug ? Str::slug($request->slug) : Str::slug($request->title),
                'excerpt'      => $request->excerpt,
                'description'  => HtmlSanitizer::clean($request->description),
                'published_at' => $request->published_at,
                'file'         => $filePath,
                'thumbnail'    => $thumbPath,
                'status'       => $request->status,
            ]);
            \Illuminate\Support\Facades\DB::commit();
            return redirect()->route('documents.index')->with('success', 'Dokumen berhasil disimpan.');
        } catch (\Throwable $e) {
            \Illuminate\Support\Facades\DB::rollBack();
            if ($filePath && Storage::disk('public')->exists($filePath)) Storage::disk('public')->delete($filePath);
            if ($thumbPath && Storage::disk('public')->exists($thumbPath)) Storage::disk('public')->delete($thumbPath);
            return back()->withInput()->with('error', $e->getMessage());
        }
    }

    /**
     * Show the form for editing the specified studio.
     */
    public function edit(Document $document)
    {
        $document->load(['versions.user', 'category']);
        $categories = DocumentCategory::where('status', 'active')
            ->orderBy('name')
            ->get();

        return view(
            'pages.documents.edit',
            compact('document', 'categories')
        );
    }

    /**
     * Update the specified .
     */
    public function update(Request $request, Document $document)
    {
        $request->validate([
            'category_uuid' => 'required|exists:document_categories,uuid',
            'title'         => 'required|string|max:255',
            'slug'          => 'nullable|string|max:255|unique:documents,slug,' . $document->uuid . ',uuid',
            'excerpt'       => 'nullable|string|max:500',
            'description'   => 'nullable|string',
            'published_at'  => 'nullable|date',
            'file'          => 'nullable|file|mimes:pdf,doc,docx,xls,xlsx,ppt,pptx|max:10240',
            'thumbnail'     => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
            'status'        => 'required|in:active,inactive',
        ]);

        $oldFile = $document->file;
        $oldThumb = $document->thumbnail;
        $newFile = null;
        $newThumb = null;
        try {
            if ($request->hasFile('file')) {
                $newFile = $request->file('file')->store('documents/files', 'public');
            }
            if ($request->hasFile('thumbnail')) {
                $newThumb = $request->file('thumbnail')->store('documents/thumbnails', 'public');
            }
            $data = $request->only(['category_uuid', 'title', 'excerpt', 'status']);
            $data['description'] = HtmlSanitizer::clean($request->description);
            if ($request->filled('published_at')) $data['published_at'] = $request->published_at;
            $data['slug'] = $request->slug ? Str::slug($request->slug) : Str::slug($request->title);
            if ($newFile) $data['file'] = $newFile;
            if ($newThumb) $data['thumbnail'] = $newThumb;

            \Illuminate\Support\Facades\DB::beginTransaction();
            // simpan versi lama sebelum update (agar tidak hilang file lama)
            $nextVersi = ($document->versions()->max('versi') ?? 0) + 1;
            \App\Models\DocumentVersion::create([
                'document_uuid' => $document->uuid,
                'title' => $document->title,
                'file' => $oldFile,
                'thumbnail' => $oldThumb,
                'keterangan' => 'Versi sebelum update: ' . now()->format('d/m/Y H:i'),
                'user_uuid' => auth()->user()->uuid ?? null,
                'versi' => $nextVersi,
            ]);
            $document->update($data);
            \Illuminate\Support\Facades\DB::commit();
            if ($newFile && $oldFile && Storage::disk('public')->exists($oldFile)) Storage::disk('public')->delete($oldFile);
            if ($newThumb && $oldThumb && Storage::disk('public')->exists($oldThumb)) Storage::disk('public')->delete($oldThumb);
            return redirect()->route('documents.index')->with('success', 'Dokumen berhasil diperbarui.');
        } catch (\Throwable $e) {
            \Illuminate\Support\Facades\DB::rollBack();
            if ($newFile && Storage::disk('public')->exists($newFile)) Storage::disk('public')->delete($newFile);
            if ($newThumb && Storage::disk('public')->exists($newThumb)) Storage::disk('public')->delete($newThumb);
            return back()->withInput()->with('error', $e->getMessage());
        }
    }
    /**
     * Remove the specified document.
     */
    public function destroy(Document $document)
    {
        $file = $document->file;
        $thumb = $document->thumbnail;
        try {
            \Illuminate\Support\Facades\DB::beginTransaction();
            $document->delete();
            \Illuminate\Support\Facades\DB::commit();
            if ($file && Storage::disk('public')->exists($file)) Storage::disk('public')->delete($file);
            if ($thumb && Storage::disk('public')->exists($thumb)) Storage::disk('public')->delete($thumb);
            return redirect()->route('documents.index')->with('success', 'Dokumen berhasil dihapus.');
        } catch (\Throwable $e) {
            \Illuminate\Support\Facades\DB::rollBack();
            return redirect()->route('documents.index')->with('error', 'Gagal menghapus dokumen: ' . $e->getMessage());
        }
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request->input('ids', []);
        if (!is_array($ids) || empty($ids)) return back()->with('error', 'Tidak ada data dipilih.');
        $docs = Document::whereIn('uuid', $ids)->get();
        try {
            \Illuminate\Support\Facades\DB::beginTransaction();
            Document::whereIn('uuid', $ids)->delete();
            \Illuminate\Support\Facades\DB::commit();
            foreach ($docs as $d) {
                if ($d->file && Storage::disk('public')->exists($d->file)) Storage::disk('public')->delete($d->file);
                if ($d->thumbnail && Storage::disk('public')->exists($d->thumbnail)) Storage::disk('public')->delete($d->thumbnail);
            }
            return back()->with('success', count($ids) . ' dokumen berhasil dihapus.');
        } catch (\Throwable $e) {
            \Illuminate\Support\Facades\DB::rollBack();
            return back()->with('error', $e->getMessage());
        }
    }
}
