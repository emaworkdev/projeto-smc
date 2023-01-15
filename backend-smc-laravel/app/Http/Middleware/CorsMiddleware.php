<?php

namespace App\Http\Middleware;

use Closure;

class CorsMiddleware
{

    public function handle($request, Closure $next)
    {
        if($request->is('api/*')){
            header("Access-Control-Allow-Origin: *");
            header('Access-Control-Allow-Headers: Content-Type,Authorization');
            header('Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE');
            header('Access-Control-Expose-Headers: Authorization');
        }

        return $next($request);
    }
}
