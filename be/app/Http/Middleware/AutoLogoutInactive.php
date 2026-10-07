<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class AutoLogoutInactive
{
    /**
     * Logout user jika idle melebihi SESSION_INACTIVE_TIMEOUT (default 30 menit).
     * Server-side layer: proteksi walau JS dimatikan.
     */
    public function handle(Request $request, Closure $next): Response
    {
        if (Auth::check()) {
            $timeoutMinutes = (int) config('session.inactive_timeout', 60);
            $lastActivity = $request->session()->get('last_activity');

            if ($lastActivity !== null) {
                $inactiveSeconds = time() - $lastActivity;
                if ($inactiveSeconds > $timeoutMinutes * 60) {
                    Auth::guard('web')->logout();
                    $request->session()->invalidate();
                    $request->session()->regenerateToken();

                    if ($request->expectsJson() || $request->is('api/*')) {
                        return response()->json([
                            'message' => 'Sesi berakhir karena tidak ada aktivitas selama ' . $timeoutMinutes . ' menit. Silakan login kembali.',
                        ], 401);
                    }

                    return redirect()
                        ->route('login')
                        ->withErrors(['session_expired' => 'Sesi berakhir karena tidak ada aktivitas selama ' . $timeoutMinutes . ' menit. Silakan login kembali.']);
                }
            }

            // update timestamp tiap request terautentikasi
            $request->session()->put('last_activity', time());
        }

        return $next($request);
    }
}
