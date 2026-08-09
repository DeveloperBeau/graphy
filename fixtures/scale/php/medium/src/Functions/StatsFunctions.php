<?php

namespace Calc\Functions;

class StatsFunctions
{
    public static function install(FunctionRegistry $registry): void
    {
        $registry->define('min', fn (...$xs) => min($xs));
        $registry->define('max', fn (...$xs) => max($xs));
        $registry->define('sum', fn (...$xs) => array_sum($xs));
        $registry->define('mean', fn (...$xs) => array_sum($xs) / count($xs));
        $registry->define('range', fn (...$xs) => max($xs) - min($xs));
    }
}
