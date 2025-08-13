<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('reminder_rules', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained('users')->comment('null = default global');
            $table->string('type')->nullable()->comment('meal | workout | sleep');
            $table->json('schedule')->nullable()->comment('{ "times": ["07:30","12:30","19:30"] }');
            $table->boolean('active')->nullable();
            $table->smallInteger('priority')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reminder_rules');
    }
};
