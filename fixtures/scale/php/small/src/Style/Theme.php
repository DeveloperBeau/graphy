<?php

namespace TextPrint\Style;

require_once __DIR__ . '/AnsiPalette.php';

class Theme
{
    public string $name;
    public string $prefix;

    public static function named(string $name): self
    {
        $theme = new self();
        $theme->name = $name;
        $theme->prefix = match ($name) {
            'bright' => AnsiPalette::BOLD,
            'mono' => AnsiPalette::DIM,
            default => '',
        };
        return $theme;
    }

    public function apply(string $body): string
    {
        return $this->prefix === '' ? $body : $this->prefix . $body . AnsiPalette::RESET;
    }
}
