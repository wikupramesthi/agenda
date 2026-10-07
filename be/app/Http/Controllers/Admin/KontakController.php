<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Concerns\HandlesTransactions;
use App\Models\Kontak;
use Illuminate\Http\Request;

class KontakController extends Controller
{
    
    use HandlesTransactions;
public function index()
    {
        $kontak = Kontak::first();
        return view('admin.pages.kontak.index', [
            'title' => 'Kelola Kontak',
            'item' => $kontak
        ]);
    }

    public function destroy($uuid)
    {
        DB::beginTransaction();
        try {
            $item = Kontak::where('uuid', $uuid)->firstOrFail();
            $item->delete();

            DB::commit();
            return redirect()->back()->with('success', 'Pesan masuk berhasil dihapus.');
        } catch (\Throwable $th) {
            DB::rollBack();
            return redirect()->back()->with('error', $th->getMessage());
        }
    }
}
