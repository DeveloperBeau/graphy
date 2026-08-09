<?php

namespace Calc;

use Calc\Eval\AngleMode;

class Settings
{
    public int $precision = 6;
    public AngleMode $angle = AngleMode::Radians;
    public bool $running = true;

    public static function interactive(): self
    {
        return new self();
    }
}
