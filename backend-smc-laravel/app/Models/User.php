<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class User extends Model
{
   
    protected $connection = 'mysql';
    protected $table = 'users';
    public $timestamps = false;

}
