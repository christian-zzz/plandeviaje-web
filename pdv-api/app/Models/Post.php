<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Modelo central de contenido.
 *
 * Actúa como tabla base para vuelos, alojamientos, paquetes y blog posts.
 * Contiene los campos compartidos: nombre, descripción, banner e imágenes.
 *
 * @property int    $post_ID
 * @property string $name
 * @property string $overview
 * @property string $information
 * @property string $banner
 * @property string $thumbnail
 * @property int    $createdBy
 * @property int    $updatedBy
 */
class Post extends Model
{
    use HasFactory;

    protected $table = 'posts';
    protected $primaryKey = 'post_ID';
    public $timestamps = false;

    protected $fillable = [
        'name',
        'overview',
        'information',
        'banner',
        'thumbnail',
        'createdBy',
        'updatedBy',
    ];

    /** Imágenes de galería asociadas al post. */
    public function images()
    {
        return $this->hasMany(Image::class, 'post_FK', 'post_ID');
    }

    /** Vuelo asociado (si el post es un vuelo). */
    public function flight()
    {
        return $this->hasOne(Flight::class, 'post_FK', 'post_ID');
    }

    /** Alojamiento asociado (si el post es un hotel). */
    public function accommodation()
    {
        return $this->hasOne(Accommodation::class, 'post_FK', 'post_ID');
    }

    /** Paquete asociado (si el post es un paquete). */
    public function package()
    {
        return $this->hasOne(Package::class, 'post_FK', 'post_ID');
    }

    /** Blog post asociado (si el post es una publicación). */
    public function blogPost()
    {
        return $this->hasOne(BlogPost::class, 'post_FK', 'post_ID');
    }

    /** Consultas de clientes vinculadas a este post. */
    public function inquiries()
    {
        return $this->hasMany(Inquiry::class, 'post_FK', 'post_ID');
    }
}
