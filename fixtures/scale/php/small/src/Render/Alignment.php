<?php

namespace TextPrint\Render;

class Alignment
{
    public static function alignLine(string $line, int $width, string $mode): string
    {
        $slack = $width - strlen($line);
        if ($slack <= 0) {
            return $line;
        }
        if ($mode === 'right') {
            return str_repeat(' ', $slack) . $line;
        }
        if ($mode === 'center') {
            $left = intdiv($slack, 2);
            return str_repeat(' ', $left) . $line . str_repeat(' ', $slack - $left);
        }
        return $line . str_repeat(' ', $slack);
    }
}
