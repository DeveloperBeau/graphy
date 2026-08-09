<?php

namespace Calc\Functions;

class RoundingFunctions
{
    public static function install(FunctionRegistry $registry): void
    {
        $registry->define('round', fn ($x) => round($x));
        $registry->define('floor', fn ($x) => floor($x));
        $registry->define('ceil', fn ($x) => ceil($x));
        $registry->define('trunc', fn ($x) => (float) (int) $x);
    }
}
