<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoardType extends Model
{
    use HasFactory;

    protected $table = 'board_types';
    protected $primaryKey = 'board_type_ID';
    public $timestamps = false;

    protected $fillable = [
        'type',
    ];

    public function accommodation()
    {
        return $this->hasMany(Accommodation::class, 'board_type_FK', 'board_type_ID');
    }

    public function packages()
    {
        return $this->hasMany(Package::class, 'board_type_FK', 'board_type_ID');
    }
}
