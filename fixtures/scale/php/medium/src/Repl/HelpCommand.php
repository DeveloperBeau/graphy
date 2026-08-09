<?php

namespace Calc\Repl;

class HelpCommand
{
    public static function run(ReplContext $context, array $parts): string
    {
        $names = implode(', ', $context->functions->names());
        return implode("\n", [
            'commands: :help :vars :history :precision N :angle MODE :quit',
            'functions: ' . $names,
            'assign with  name = expression',
        ]);
    }
}
