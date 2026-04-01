<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GuestType extends Model
{
    use HasFactory;

    protected $table = 'guest_types';
    protected $primaryKey = 'guest_type_ID';
    public $timestamps = false;

    protected $fillable = [
        'type',
    ];

    public function packages()
    {
        return $this->hasMany(Package::class, 'guest_type_FK', 'guest_type_ID');
    }

    public function inquiries()
    {
        return $this->hasMany(Inquiry::class, 'guest_type_FK', 'guest_type_ID');
    }
}
