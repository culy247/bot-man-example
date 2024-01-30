<?php

use App\Http\Controllers\BotManController;

Route::match(['get', 'post'], '/say', BotManController::class.'@startConversation');
