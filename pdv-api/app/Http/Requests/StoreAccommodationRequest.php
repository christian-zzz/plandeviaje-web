<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

/**
 * Validación para la creación de un alojamiento.
 */
class StoreAccommodationRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name'            => 'required|string|max:255',
            'overview'        => 'required|string',
            'information'     => 'nullable|string',
            'banner'          => 'nullable|string|max:500',
            'thumbnail'       => 'nullable|string|max:500',
            'images'          => 'nullable|array',
            'images.*'        => 'string|max:500',
            'destination'     => 'required|string|max:255',
            'map_location'    => 'nullable|string|max:500',
            'starting_price'  => 'required|numeric|min:0',
            'stars'           => 'required|integer|min:1|max:5',
            'board_type_FK'   => 'nullable|exists:board_types,board_type_ID',
            'features'        => 'nullable|array',
            'features.*.icon' => 'required_with:features|string',
            'features.*.label'=> 'required_with:features|string',
            'room_types'      => 'nullable|array',
            'room_types.*'    => 'exists:room_types,room_type_ID',
            'isActive'        => 'boolean',
        ];
    }

    public function messages(): array
    {
        return [
            'name.required'           => 'El nombre del alojamiento es obligatorio.',
            'overview.required'       => 'El resumen es obligatorio.',
            'destination.required'    => 'El destino es obligatorio.',
            'starting_price.required' => 'El precio inicial es obligatorio.',
            'stars.required'          => 'Las estrellas son obligatorias.',
            'stars.max'               => 'El máximo de estrellas es 5.',
        ];
    }
}
