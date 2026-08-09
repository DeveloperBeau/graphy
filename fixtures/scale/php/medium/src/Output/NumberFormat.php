<?php

namespace Calc\Output;

class NumberFormat
{
    public static function format(float $value, int $precision): string
    {
        if (is_nan($value) || is_infinite($value)) {
            return (string) $value;
        }
        return number_format($value, $precision, '.', '');
    }
}
