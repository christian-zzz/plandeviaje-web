<?php

namespace App\Http\Controllers;

use App\Models\Setting;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Storage;

class SettingController extends Controller
{
    /**
     * Display a listing of the settings.
     */
    public function index(Request $request)
    {
        $group = $request->query('group');
        
        // Cache key based on group if provided
        $cacheKey = $group ? "settings.{$group}" : "settings.all";

        $settings = Cache::rememberForever($cacheKey, function () use ($group) {
            $query = Setting::query();
            
            if ($group) {
                $query->where('group', $group);
            }
            
            return $query->get()->keyBy('key')->map(function($setting) {
                if ($setting->type === 'json' && is_string($setting->value)) {
                    $setting->value = json_decode($setting->value, true);
                }
                return $setting;
            });
        });

        return response()->json($settings);
    }

    /**
     * Update settings in bulk.
     */
    public function updateBulk(Request $request)
    {
        // Don't process tokens or methods
        $data = $request->except(['_method', '_token']);
        
        foreach ($data as $key => $value) {
            $setting = Setting::where('key', $key)->first();
            
            if (!$setting) {
                // If setting doesn't exist but data was sent, we create it dynamically 
                // However, usually we pre-seed them. This handles it just in case.
                $setting = new Setting();
                $setting->key = $key;
                $setting->type = $request->hasFile($key) ? 'image' : (is_array($value) ? 'json' : 'text');
                $setting->group = 'general'; // Default group if auto-created
            }

            // Check if it's a file
            if ($request->hasFile($key)) {
                // Delete old file if exists
                if ($setting->value && strpos($setting->value, '/storage/') === 0) {
                    $oldPath = str_replace('/storage/', '', $setting->value);
                    if (Storage::disk('public')->exists($oldPath)) {
                        Storage::disk('public')->delete($oldPath);
                    }
                }
                
                $file = $request->file($key);
                $path = $file->store('settings', 'public');
                $setting->value = '/storage/' . $path;
            } else {
                // For non-files, if frontend sends an array, it's a json type
                if (is_array($value)) {
                    $setting->type = 'json';
                    $setting->value = json_encode($value);
                } else if ($value === 'null') {
                    $setting->value = null; // Handle string "null" from FormData
                } else {
                    $setting->value = $value;
                }
            }

            $setting->save();
        }

        // Clear all caches
        Cache::forget('settings.all');
        Cache::forget('settings.informacion');
        Cache::forget('settings.imagenes');
        Cache::forget('settings.contenido');

        return response()->json(['message' => 'Configuración actualizada']);
    }
}
