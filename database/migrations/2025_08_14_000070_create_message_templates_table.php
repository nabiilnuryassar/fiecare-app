<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('message_templates', function (Blueprint $table) {
            $table->id();
            $table->string('channel')->nullable()->comment('reminder | surprise | generic');
            $table->string('audience')->nullable()->comment('happy | neutral | sad | any');
            $table->string('activity')->nullable()->comment('meal | workout | sleep | none');
            $table->string('locale')->nullable();
            $table->text('content')->nullable()->comment('gunakan {{name}}');
            $table->smallInteger('weight')->nullable();
            $table->boolean('active')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('message_templates');
    }
};
