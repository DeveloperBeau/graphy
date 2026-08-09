<?php

namespace TextPrint\Render;

class Wrapper
{
    public static function wrap(string $text, int $width): array
    {
        $lines = [];
        $current = '';
        foreach (explode(' ', $text) as $word) {
            if ($current !== '' && strlen($current) + strlen($word) + 1 > $width) {
                $lines[] = $current;
                $current = $word;
            } else {
                $current = $current === '' ? $word : $current . ' ' . $word;
            }
        }
        if ($current !== '') {
            $lines[] = $current;
        }
        return $lines;
    }
}
