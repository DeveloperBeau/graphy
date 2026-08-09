<?php

namespace Calc\Functions;

class LogFunctions
{
    public static function install(FunctionRegistry $registry): void
    {
        $registry->define('ln', fn ($x) => log($x));
        $registry->define('log10', fn ($x) => log10($x));
        $registry->define('log2', fn ($x) => log($x, 2));
        $registry->define('exp', fn ($x) => exp($x));
    }
}
