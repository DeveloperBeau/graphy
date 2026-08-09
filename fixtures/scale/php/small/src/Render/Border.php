<?php

namespace TextPrint\Render;

class Border
{
    private string $horizontal;

    public function __construct(string $style)
    {
        $this->horizontal = $style === 'double' ? '=' : '-';
    }

    public function frame(array $lines, int $width): array
    {
        $rule = '+' . str_repeat($this->horizontal, $width + 2) . '+';
        $framed = [$rule];
        foreach ($lines as $line) {
            $framed[] = '| ' . $line . ' |';
        }
        $framed[] = $rule;
        return $framed;
    }
}
