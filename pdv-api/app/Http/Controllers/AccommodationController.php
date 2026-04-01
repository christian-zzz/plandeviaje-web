<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreAccommodationRequest;
use App\Http\Requests\UpdateAccommodationRequest;
use App\Models\Accommodation;
use App\Traits\ManagesPostData;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

/**
 * Gestión de alojamientos (hoteles).
 *
 * Maneja las operaciones CRUD de alojamientos, incluyendo la relación
 * con tipos de habitación, tipo de pensión, imágenes y cacheo de consultas.
 */
class AccommodationController extends Controller
{
    use ManagesPostData;

    private const CACHE_KEY = 'accommodations.all';
    private const CACHE_TTL = 300;

    /**
     * Listado de todos los alojamientos (cacheado por 5 minutos).
     */
    public function index()
    {
        $accommodations = Cache::remember(self::CACHE_KEY, self::CACHE_TTL, function () {
            return Accommodation::with(['post.images', 'roomTypes', 'boardType'])->get();
        });

        return response()->json($accommodations);
    }

    /**
     * Registrar un nuevo alojamiento con su post y tipos de habitación.
     */
    public function store(StoreAccommodationRequest $request)
    {
        $accommodation = DB::transaction(function () use ($request) {
            $post = $this->createPost($request);

            if ($request->has('images')) {
                $this->syncImages($post->post_ID, $request->images);
            }

            $newAccommodation = Accommodation::create([
                'post_FK'        => $post->post_ID,
                'destination'    => $request->destination,
                'map_location'   => $request->map_location ?? '',
                'starting_price' => $request->starting_price,
                'stars'          => $request->stars,
                'features'       => $request->features ?? null,
                'board_type_FK'  => $request->board_type_FK,
                'isActive'       => $request->isActive ?? true,
            ]);

            if ($request->has('room_types')) {
                $newAccommodation->roomTypes()->sync($request->room_types);
            }

            return $newAccommodation;
        });

        Cache::forget(self::CACHE_KEY);

        return response()->json($accommodation, 201);
    }

    /**
     * Detalle de un alojamiento específico con todas sus relaciones.
     */
    public function show(Accommodation $accommodation)
    {
        $accommodation->load(['post.images', 'roomTypes', 'boardType']);

        return response()->json($accommodation);
    }

    /**
     * Actualizar un alojamiento existente y su post asociado.
     */
    public function update(UpdateAccommodationRequest $request, Accommodation $accommodation)
    {
        DB::transaction(function () use ($request, $accommodation) {
            $this->updatePost($accommodation->post, $request);

            $accommodation->update(array_filter([
                'destination'    => $request->input('destination', $accommodation->destination),
                'map_location'   => $request->has('map_location') ? $request->map_location : $accommodation->map_location,
                'starting_price' => $request->input('starting_price', $accommodation->starting_price),
                'stars'          => $request->input('stars', $accommodation->stars),
                'features'       => $request->has('features') ? $request->features : $accommodation->features,
                'board_type_FK'  => $request->has('board_type_FK') ? $request->board_type_FK : $accommodation->board_type_FK,
                'isActive'       => $request->has('isActive') ? $request->isActive : $accommodation->isActive,
            ], fn($v) => $v !== null));

            if ($request->has('room_types')) {
                $accommodation->roomTypes()->sync($request->room_types);
            }
        });

        Cache::forget(self::CACHE_KEY);

        return response()->json(
            $accommodation->fresh(['post.images', 'boardType', 'roomTypes'])
        );
    }

    /**
     * Eliminar un alojamiento, sus tipos de habitación y su post asociado.
     */
    public function destroy(Accommodation $accommodation)
    {
        DB::transaction(function () use ($accommodation) {
            $post = $accommodation->post;
            $accommodation->roomTypes()->detach();
            $accommodation->delete();
            if ($post) {
                $this->deletePostWithImages($post);
            }
        });

        Cache::forget(self::CACHE_KEY);

        return response()->json(['message' => 'Alojamiento eliminado correctamente']);
    }
}
