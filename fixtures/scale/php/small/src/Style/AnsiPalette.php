<?php

namespace TextPrint\Style;

class AnsiPalette
{
    public const RESET = "\033[0m";
    public const BOLD = "\033[1m";
    public const DIM = "\033[2m";

    public static function colored(string $body, int $code): string
    {
        return "\033[" . $code . 'm' . $body . self::RESET;
    }
}
