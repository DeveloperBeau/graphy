<?php

namespace Calc\Repl;

require_once __DIR__ . '/HelpCommand.php';
require_once __DIR__ . '/VarsCommand.php';
require_once __DIR__ . '/HistoryCommand.php';
require_once __DIR__ . '/PrecisionCommand.php';
require_once __DIR__ . '/AngleCommand.php';
require_once __DIR__ . '/QuitCommand.php';

class CommandRouter
{
    public static function dispatch(string $line, ReplContext $context): string
    {
        $parts = explode(' ', ltrim($line, ':'));
        return match ($parts[0]) {
            'help' => HelpCommand::run($context, $parts),
            'vars' => VarsCommand::run($context, $parts),
            'history' => HistoryCommand::run($context, $parts),
            'precision' => PrecisionCommand::run($context, $parts),
            'angle' => AngleCommand::run($context, $parts),
            'quit' => QuitCommand::run($context, $parts),
            default => 'unknown command :' . $parts[0],
        };
    }
}
