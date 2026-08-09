<?php

namespace Calc\Functions;

class PowerFunctions
{
    public static function install(FunctionRegistry $registry): void
    {
        $registry->define('sqrt', fn ($x) => sqrt($x));
        $registry->define('cbrt', fn ($x) => $x ** (1 / 3));
        $registry->define('pow', fn ($x, $y) => $x ** $y);
        $registry->define('hypot', fn ($x, $y) => hypot($x, $y));
    }
}
