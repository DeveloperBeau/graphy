<?php

namespace Calc\Functions;

class TrigFunctions
{
    public static function install(FunctionRegistry $registry): void
    {
        $registry->define('sin', fn ($x) => sin($x));
        $registry->define('cos', fn ($x) => cos($x));
        $registry->define('tan', fn ($x) => tan($x));
        $registry->define('asin', fn ($x) => asin($x));
        $registry->define('acos', fn ($x) => acos($x));
        $registry->define('atan', fn ($x) => atan($x));
    }
}
