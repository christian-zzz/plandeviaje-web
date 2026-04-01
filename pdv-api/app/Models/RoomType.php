<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RoomType extends Model
{
    use HasFactory;
    
    protected $table = 'room_types';
    protected $primaryKey = 'room_type_ID';
    public $timestamps = false;
    
    protected $fillable = ['type'];

    public function accommodations()
    {
        return $this->belongsToMany(Accommodation::class, 'accommodation_room_type', 'room_type_id', 'accommodation_id');
    }
}
