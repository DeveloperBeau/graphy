<?php

namespace Calc\Functions;

class HyperbolicFunctions
{
    public static function install(FunctionRegistry $registry): void
    {
        $registry->define('sinh', fn ($x) => sinh($x));
        $registry->define('cosh', fn ($x) => cosh($x));
        $registry->define('tanh', fn ($x) => tanh($x));
    }
}
