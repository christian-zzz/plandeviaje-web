<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Modelo de Alojamiento (Hotel).
 *
 * Representa un hotel o posada con su destino, estrellas,
 * tipo de pensión, características y tipos de habitación disponibles.
 */
class Accommodation extends Model
{
    use HasFactory;

    protected $table = 'accommodation';
    protected $primaryKey = 'accommodation_ID';
    public $timestamps = false;

    protected $fillable = [
        'post_FK',
        'destination',
        'map_location',
        'starting_price',
        'stars',
        'board_type_FK',
        'features',
        'isActive',
    ];

    protected $casts = [
        'features'       => 'array',
        'starting_price' => 'decimal:2',
        'isActive'       => 'boolean',
        'stars'          => 'integer',
    ];

    /** Post con el contenido multimedia del alojamiento. */
    public function post()
    {
        return $this->belongsTo(Post::class, 'post_FK', 'post_ID');
    }

    /** Tipo de pensión (Todo Incluido, Media Pensión, etc.). */
    public function boardType()
    {
        return $this->belongsTo(BoardType::class, 'board_type_FK', 'board_type_ID');
    }

    /** Paquetes turísticos que incluyen este alojamiento. */
    public function packages()
    {
        return $this->hasMany(Package::class, 'accommodation_FK', 'accommodation_ID');
    }

    /** Tipos de habitación disponibles en este alojamiento. */
    public function roomTypes()
    {
        return $this->belongsToMany(RoomType::class, 'accommodation_room_type', 'accommodation_id', 'room_type_id');
    }
}
