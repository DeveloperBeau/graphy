<?php

namespace CipherLab\Report;

class DurationFormat
{
    public static function perOp(float $nanos): string
    {
        if ($nanos < 1000) {
            return number_format($nanos, 1) . 'ns';
        }
        return number_format($nanos / 1000, 1) . 'us';
    }
}
