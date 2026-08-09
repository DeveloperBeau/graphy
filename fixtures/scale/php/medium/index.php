<?php

require_once __DIR__ . '/src/Settings.php';
require_once __DIR__ . '/src/Version.php';
require_once __DIR__ . '/src/Repl/ReplContext.php';
require_once __DIR__ . '/src/Repl/Repl.php';

use Calc\Repl\Repl;
use Calc\Repl\ReplContext;
use Calc\Settings;
use Calc\Version;

echo Version::banner() . "\n";
$settings = Settings::interactive();
$context = new ReplContext($settings);
(new Repl($context))->run();
