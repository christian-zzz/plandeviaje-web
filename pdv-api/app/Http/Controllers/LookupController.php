<?php

namespace App\Http\Controllers;

use App\Models\Accommodation;
use App\Models\BlogCategory;
use App\Models\BlogTag;
use App\Models\BoardType;
use App\Models\Country;
use App\Models\GuestType;
use App\Models\Post;
use App\Models\RoomType;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class LookupController extends Controller
{
    private const CACHE_KEY = 'lookups.all';
    private const CACHE_TTL = 600; // 10 minutes — lookups change rarely

    /**
     * Get all lookup lists (cached).
     */
    public function index()
    {
        $data = Cache::remember(self::CACHE_KEY, self::CACHE_TTL, function () {
            $accommodations = Accommodation::with('post:post_ID,name')->get()
                ->map(fn($acc) => [
                    'accommodation_ID' => $acc->accommodation_ID,
                    'name'             => $acc->post->name ?? 'Unknown',
                ]);

            return [
                'countries'       => Country::all(),
                'guest_types'     => GuestType::all(),
                'board_types'     => BoardType::all(),
                'room_types'      => RoomType::all(),
                'blog_categories' => BlogCategory::all(),
                'blog_tags'       => BlogTag::all(),
                'accommodations'  => $accommodations,
            ];
        });

        return response()->json($data);
    }

    public function storeCountry(Request $request)
    {
        $request->validate(['name' => 'required|string|max:100|unique:countries,name']);
        $country = Country::create(['name' => $request->name]);
        $this->clearCache();
        return response()->json($country, 201);
    }

    public function storeGuestType(Request $request)
    {
        $request->validate(['type' => 'required|string|max:100|unique:guest_types,type']);
        $guestType = GuestType::create(['type' => $request->type]);
        $this->clearCache();
        return response()->json($guestType, 201);
    }

    public function storeBoardType(Request $request)
    {
        $request->validate(['type' => 'required|string|max:100|unique:board_types,type']);
        $boardType = BoardType::create(['type' => $request->type]);
        $this->clearCache();
        return response()->json($boardType, 201);
    }

    public function storeRoomType(Request $request)
    {
        $request->validate(['type' => 'required|string|max:100|unique:room_types,type']);
        $roomType = RoomType::create(['type' => $request->type]);
        $this->clearCache();
        return response()->json($roomType, 201);
    }

    public function storeBlogCategory(Request $request)
    {
        $request->validate(['name' => 'required|string|max:100|unique:blog_categories,name']);
        $category = BlogCategory::create(['name' => $request->name]);
        $this->clearCache();
        return response()->json($category, 201);
    }

    public function storeBlogTag(Request $request)
    {
        $request->validate(['name' => 'required|string|max:100|unique:blog_tags,name']);
        $tag = BlogTag::create(['name' => $request->name]);
        $this->clearCache();
        return response()->json($tag, 201);
    }

    public function storeAccommodation(Request $request)
    {
        $request->validate(['name' => 'required|string|max:255']);

        $defaultBoard = BoardType::first()?->board_type_ID ?? 1;

        $acc = DB::transaction(function () use ($request, $defaultBoard) {
            $post = Post::create([
                'name'        => $request->name,
                'overview'    => 'Pendiente de descripción',
                'information' => '',
                'banner'      => '',
                'thumbnail'   => '',
                'createdBy'   => auth()->id(),
                'updatedBy'   => auth()->id(),
            ]);

            return Accommodation::create([
                'post_FK'        => $post->post_ID,
                'destination'    => 'Pendiente',
                'map_location'   => '',
                'starting_price' => 0,
                'stars'          => 0,
                'board_type_FK'  => $defaultBoard,
                'isActive'       => false,
            ]);
        });

        $this->clearCache();
        Cache::forget('accommodations.all');

        return response()->json([
            'accommodation_ID' => $acc->accommodation_ID,
            'name'             => $request->name,
        ], 201);
    }

    /**
     * Clear the lookups cache.
     */
    private function clearCache(): void
    {
        Cache::forget(self::CACHE_KEY);
    }
}
