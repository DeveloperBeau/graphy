<?php

namespace Calc\Functions;

class SequenceFunctions
{
    public static function install(FunctionRegistry $registry): void
    {
        $registry->define('fact', fn ($n) => self::factorial((int) $n));
        $registry->define('fib', fn ($n) => self::fibonacci((int) $n));
    }

    private static function factorial(int $n): float
    {
        $result = 1.0;
        for ($i = 2; $i <= $n; $i++) {
            $result *= $i;
        }
        return $result;
    }

    private static function fibonacci(int $n): float
    {
        [$a, $b] = [0.0, 1.0];
        for ($i = 0; $i < $n; $i++) {
            [$a, $b] = [$b, $a + $b];
        }
        return $a;
    }
}
