<?php

namespace App\Http\Controllers;

use App\Http\Requests\StorePackageRequest;
use App\Http\Requests\UpdatePackageRequest;
use App\Models\Package;
use App\Traits\ManagesPostData;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

/**
 * Gestión de paquetes turísticos.
 *
 * Maneja las operaciones CRUD de paquetes, que combinan un alojamiento
 * con un tipo de huésped, tipo de pensión y características propias.
 */
class PackageController extends Controller
{
    use ManagesPostData;

    private const CACHE_KEY = 'packages.all';
    private const CACHE_TTL = 300;

    /**
     * Listado de todos los paquetes con sus relaciones (cacheado por 5 minutos).
     */
    public function index()
    {
        $packages = Cache::remember(self::CACHE_KEY, self::CACHE_TTL, function () {
            return Package::with(['post.images', 'accommodation.post', 'guestType', 'boardType'])->get();
        });

        return response()->json($packages);
    }

    /**
     * Registrar un nuevo paquete turístico con su post asociado.
     */
    public function store(StorePackageRequest $request)
    {
        $package = DB::transaction(function () use ($request) {
            $post = $this->createPost($request);

            if ($request->has('images')) {
                $this->syncImages($post->post_ID, $request->images);
            }

            return Package::create([
                'post_FK'          => $post->post_ID,
                'accommodation_FK' => $request->accommodation_FK,
                'features'         => $request->features ?? null,
                'starting_price'   => $request->starting_price,
                'days'             => $request->days ?? '',
                'guest_type_FK'    => $request->guest_type_FK,
                'board_type_FK'    => $request->board_type_FK,
                'isActive'         => $request->isActive ?? true,
                'isFeatured'       => $request->isFeatured ?? false,
                'end_date'         => $request->end_date ?? now()->addMonth(),
            ]);
        });

        Cache::forget(self::CACHE_KEY);

        return response()->json($package, 201);
    }

    /**
     * Detalle de un paquete específico con todas sus relaciones.
     */
    public function show(Package $package)
    {
        $package->load(['post.images', 'post.inquiries', 'accommodation.post', 'guestType', 'boardType']);

        return response()->json($package);
    }

    /**
     * Actualizar un paquete existente y su post asociado.
     */
    public function update(UpdatePackageRequest $request, Package $package)
    {
        DB::transaction(function () use ($request, $package) {
            $this->updatePost($package->post, $request);

            $package->update(array_filter([
                'accommodation_FK' => $request->input('accommodation_FK', $package->accommodation_FK),
                'features'         => $request->has('features') ? $request->features : $package->features,
                'starting_price'   => $request->input('starting_price', $package->starting_price),
                'days'             => $request->has('days') ? $request->days : $package->days,
                'guest_type_FK'    => $request->input('guest_type_FK', $package->guest_type_FK),
                'board_type_FK'    => $request->input('board_type_FK', $package->board_type_FK),
                'isActive'         => $request->has('isActive') ? $request->isActive : $package->isActive,
                'isFeatured'       => $request->has('isFeatured') ? $request->isFeatured : $package->isFeatured,
                'end_date'         => $request->has('end_date') ? $request->end_date : $package->end_date,
            ], fn($v) => $v !== null));
        });

        Cache::forget(self::CACHE_KEY);

        return response()->json(
            $package->fresh(['post.images', 'accommodation.post', 'guestType', 'boardType'])
        );
    }

    /**
     * Eliminar un paquete y su post asociado.
     */
    public function destroy(Package $package)
    {
        DB::transaction(function () use ($package) {
            $post = $package->post;
            $package->delete();
            if ($post) {
                $this->deletePostWithImages($post);
            }
        });

        Cache::forget(self::CACHE_KEY);

        return response()->json(['message' => 'Paquete eliminado correctamente']);
    }
}
