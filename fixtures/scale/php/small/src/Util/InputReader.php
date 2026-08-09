<?php

namespace TextPrint\Util;

class InputReader
{
    public static function readAll(): string
    {
        $lines = [];
        while (($line = fgets(STDIN)) !== false) {
            $lines[] = trim($line);
        }
        return implode(' ', $lines);
    }
}
