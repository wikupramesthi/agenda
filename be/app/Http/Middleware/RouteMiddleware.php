<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use App\Models\ManagementAccess\Route;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Foundation\Support\Providers\RouteServiceProvider;

class RouteMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    // public function handle(Request $request, Closure $next) : Response
    // {
    //     $routes = Route::firstWhere('route', $request->route()?->getName());

    //     return blank($routes) || (bool) $routes->status && $request->user()->can($routes->permission_name)
    //         ? $next($request)
    //         : redirect(RouteServiceProvider::HOME)->withErrors('you do not have access to this route!');
    // }

    public function handle(Request $request, Closure $next): Response
    {
        $routes = Route::firstWhere(
            'route',
            $request->route()?->getName()
        );

        return blank($routes)
            || (
                (bool) $routes->status
                && $request->user()->can($routes->permission_name)
            )
            ? $next($request)
            : abort(404);
    }
}
