<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

/**
 * Validación para la creación de un vuelo.
 */
class StoreFlightRequest extends FormRequest
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
            'country_FK'      => 'required|exists:countries,country_ID',
            'map_location'    => 'nullable|string|max:500',
            'features'        => 'nullable|array',
            'features.*.icon' => 'required_with:features|string',
            'features.*.label'=> 'required_with:features|string',
            'requirements'    => 'nullable|array',
            'requirements.*'  => 'string',
            'starting_price'  => 'required|numeric|min:0',
            'isActive'        => 'boolean',
        ];
    }

    public function messages(): array
    {
        return [
            'name.required'           => 'El nombre del vuelo es obligatorio.',
            'overview.required'       => 'El resumen es obligatorio.',
            'destination.required'    => 'El destino es obligatorio.',
            'country_FK.required'     => 'Debe seleccionar un país.',
            'country_FK.exists'       => 'El país seleccionado no existe.',
            'starting_price.required' => 'El precio inicial es obligatorio.',
            'starting_price.min'      => 'El precio no puede ser negativo.',
        ];
    }
}
