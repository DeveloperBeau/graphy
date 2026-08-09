<?php

namespace TextPrint\Render;

require_once __DIR__ . '/Wrapper.php';
require_once __DIR__ . '/Alignment.php';
require_once __DIR__ . '/Border.php';
require_once __DIR__ . '/../Style/Theme.php';
require_once __DIR__ . '/../Cli/Options.php';

use TextPrint\Cli\Options;
use TextPrint\Style\Theme;

class Renderer
{
    private Options $options;
    private Theme $theme;

    public function __construct(Options $options)
    {
        $this->options = $options;
        $this->theme = Theme::named($options->themeName);
    }

    public function render(string $text): string
    {
        $lines = Wrapper::wrap($text, $this->options->width);
        $aligned = array_map(fn ($line) => Alignment::alignLine($line, $this->options->width, $this->options->align), $lines);
        if ($this->options->borderStyle !== 'none') {
            $aligned = (new Border($this->options->borderStyle))->frame($aligned, $this->options->width);
        }
        return $this->theme->apply(implode("\n", $aligned));
    }
}
