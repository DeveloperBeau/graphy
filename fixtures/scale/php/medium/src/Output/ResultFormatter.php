<?php

namespace Calc\Output;

use Calc\Settings;

class ResultFormatter
{
    public static function formatResult(float $value, Settings $settings): string
    {
        return '= ' . NumberFormat::format($value, $settings->precision);
    }

    public static function formatError(string $kind, string $detail): string
    {
        return '! ' . $kind . ': ' . $detail;
    }
}
