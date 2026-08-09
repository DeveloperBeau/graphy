<?php

namespace TextPrint\Cli;

require_once __DIR__ . '/Options.php';

class ArgParser
{
    public static function parse(array $args): Options
    {
        $options = Options::defaults();
        for ($i = 0; $i < count($args); $i++) {
            match ($args[$i]) {
                '--width' => $options->width = (int) $args[++$i],
                '--align' => $options->align = $args[++$i],
                '--border' => $options->borderStyle = $args[++$i],
                '--theme' => $options->themeName = $args[++$i],
                '--help' => $options->showHelp = true,
                default => null,
            };
        }
        return $options;
    }
}
