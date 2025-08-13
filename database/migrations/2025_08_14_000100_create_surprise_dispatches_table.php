<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('surprise_dispatches', function (Blueprint $table) {
            $table->id();
            $table->foreignId('surprise_id')->nullable()->constrained('surprises');
            $table->foreignId('user_id')->nullable()->constrained('users');
            $table->timestamp('dispatched_at')->nullable();
            $table->foreignId('message_log_id')->nullable()->constrained('message_logs');
            $table->string('status')->nullable()->comment('queued | sent | failed');
            $table->text('error')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('surprise_dispatches');
    }
};
