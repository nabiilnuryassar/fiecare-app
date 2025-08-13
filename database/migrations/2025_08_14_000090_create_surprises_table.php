<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('surprises', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained('users');
            $table->string('title')->nullable();
            $table->text('body')->nullable();
            $table->string('media_url')->nullable();
            $table->string('trigger_type')->nullable()->comment('fixed_date | random_window | birthday');
            $table->timestamp('trigger_at')->nullable();
            $table->json('window')->nullable()->comment('{ "start":"YYYY-MM-DD","end":"YYYY-MM-DD","hour":"20:00" }');
            $table->boolean('active')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('surprises');
    }
};
