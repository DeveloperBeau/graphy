<?php

namespace Calc\Repl;

class PrecisionCommand
{
    public static function run(ReplContext $context, array $parts): string
    {
        if (count($parts) < 2 || !is_numeric($parts[1])) {
            return 'precision is ' . $context->settings->precision;
        }
        $context->settings->precision = (int) $parts[1];
        return 'precision set to ' . $parts[1];
    }
}
