<?php

namespace Calc\Repl;

use Calc\Eval\Environment;
use Calc\Functions\FunctionRegistry;
use Calc\Functions\StandardLibrary;
use Calc\Memory\HistoryLog;
use Calc\Settings;

require_once __DIR__ . '/../Functions/StandardLibrary.php';
require_once __DIR__ . '/../Memory/HistoryLog.php';

class ReplContext
{
    public Environment $environment;
    public FunctionRegistry $functions;
    public HistoryLog $history;

    public function __construct(public Settings $settings)
    {
        $this->environment = new Environment();
        $this->functions = StandardLibrary::buildRegistry();
        $this->history = new HistoryLog();
    }
}
