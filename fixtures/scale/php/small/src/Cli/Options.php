<?php

namespace TextPrint\Cli;

class Options
{
    public int $width = 60;
    public string $align = 'left';
    public string $borderStyle = 'single';
    public string $themeName = 'plain';
    public bool $showHelp = false;

    public static function defaults(): self
    {
        return new self();
    }
}
