<?php

namespace Calc\Repl;

class QuitCommand
{
    public static function run(ReplContext $context, array $parts): string
    {
        $context->settings->running = false;
        return 'bye (' . $context->history->count() . ' calculations this session)';
    }
}
