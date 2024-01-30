<?php

namespace App\Http\Controllers;

use BotMan\BotMan\Messages\Incoming\Answer;

class BotManController extends Controller
{
    public function startConversation()
    {
        $hiMessage = config('botman.message.hi');
        $noAnswer = config('botman.message.no_answer');
        $botman = app('botman');

        $botman->hears('{message}', function ($botman, $message) use ($hiMessage, $noAnswer) {
            if ($message == $hiMessage) {
                $this->askName($botman);
            } else {
                $botman->reply($noAnswer);
            }
        });

        $botman->listen();
    }

    /**
     * Place your BotMan logic here.
     */
    public function askName($botman)
    {
        $botman->ask('Hello! What is your Name?', function (Answer $answer) {

            $name = $answer->getText();

            $this->say('Nice to meet you '.$name);
        });
    }
}
