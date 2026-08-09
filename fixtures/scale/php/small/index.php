<?php

require_once __DIR__ . '/src/Cli/ArgParser.php';
require_once __DIR__ . '/src/Render/Renderer.php';
require_once __DIR__ . '/src/Util/InputReader.php';

use TextPrint\Cli\ArgParser;
use TextPrint\Render\Renderer;
use TextPrint\Util\InputReader;

$options = ArgParser::parse(array_slice($argv, 1));
if ($options->showHelp) {
    echo "textprint [options] < input.txt\n";
} else {
    $text = InputReader::readAll() ?: 'a small text printer demo for testing wrap and borders';
    $renderer = new Renderer($options);
    echo $renderer->render($text) . "\n";
}
