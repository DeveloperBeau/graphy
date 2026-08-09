<?php

namespace Calc\Functions;

class NumberFunctions
{
    public static function install(FunctionRegistry $registry): void
    {
        $registry->define('abs', fn ($x) => abs($x));
        $registry->define('sign', fn ($x) => $x <=> 0.0);
        $registry->define('clamp', fn ($x, $lo, $hi) => min(max($x, $lo), $hi));
    }
}
