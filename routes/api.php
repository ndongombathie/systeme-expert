<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\GuidanceController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');


Route::get('/ues/{filiere}/{niveau}', [GuidanceController::class,'getUes']);
Route::post('/guidance/analyse', [GuidanceController::class,'analyse']);


