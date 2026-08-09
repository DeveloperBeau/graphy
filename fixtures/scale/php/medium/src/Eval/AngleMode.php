<?php

namespace Calc\Eval;

enum AngleMode
{
    case Radians;
    case Degrees;

    public static function toRadians(float $value, self $mode): float
    {
        return $mode === self::Degrees ? $value * M_PI / 180.0 : $value;
    }
}
