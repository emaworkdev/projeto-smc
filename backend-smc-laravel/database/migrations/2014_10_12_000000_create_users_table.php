<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
      /*  Schema::create('users', function (Blueprint $table) {
            //$table->id();
            $table->string('uid')->unique();
            $table->string('name');
            $table->string('login')->unique();
            $table->string('email')->unique();
            $table->string('celular');
            $table->string('password');
            $table->string('permissao');
            $table->string('modulo');
            $table->boolean('ativo')->default(true);
            $table->boolean('receber_notificacao_sms')->default(false);
            $table->boolean('receber_notificacao_email')->default(false);
            $table->timestamp('email_verified_at')->nullable();
            $table->rememberToken();
            $table->softDeletes();
            $table->timestamps();
        });*/
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
      //  Schema::dropIfExists('users');
    }
}
