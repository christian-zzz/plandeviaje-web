<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

/**
 * Validación para la actualización de un vuelo.
 */
class UpdateFlightRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name'            => 'sometimes|string|max:255',
            'overview'        => 'sometimes|string',
            'information'     => 'nullable|string',
            'banner'          => 'nullable|string|max:500',
            'thumbnail'       => 'nullable|string|max:500',
            'images'          => 'nullable|array',
            'images.*'        => 'string|max:500',
            'destination'     => 'sometimes|string|max:255',
            'country_FK'      => 'sometimes|exists:countries,country_ID',
            'map_location'    => 'nullable|string|max:500',
            'features'        => 'nullable|array',
            'features.*.icon' => 'required_with:features|string',
            'features.*.label'=> 'required_with:features|string',
            'requirements'    => 'nullable|array',
            'requirements.*'  => 'string',
            'starting_price'  => 'sometimes|numeric|min:0',
            'isActive'        => 'boolean',
        ];
    }
}
