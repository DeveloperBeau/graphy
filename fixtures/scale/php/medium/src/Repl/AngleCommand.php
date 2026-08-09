<?php

namespace Calc\Repl;

use Calc\Eval\AngleMode;

class AngleCommand
{
    public static function run(ReplContext $context, array $parts): string
    {
        if (count($parts) < 2) {
            return 'angle mode is ' . $context->settings->angle->name;
        }
        $context->settings->angle = $parts[1] === 'degrees' ? AngleMode::Degrees : AngleMode::Radians;
        return 'angle mode set to ' . $context->settings->angle->name;
    }
}
