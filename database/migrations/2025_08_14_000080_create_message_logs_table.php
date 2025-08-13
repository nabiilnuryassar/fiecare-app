<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('message_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained('users');
            $table->string('source_type')->nullable()->comment('reminder | surprise | system');
            $table->unsignedBigInteger('source_id')->nullable();
            $table->foreignId('template_id')->nullable()->constrained('message_templates');
            $table->string('channel')->nullable()->comment('push | inapp | email');
            $table->text('rendered')->nullable();
            $table->timestamp('sent_at')->nullable();
            $table->timestamp('delivered_at')->nullable();
            $table->string('status')->nullable()->comment('sent | failed');
            $table->json('meta')->nullable();
            $table->timestamps();
            $table->index(['source_type', 'source_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('message_logs');
    }
};
