<?php

namespace Calc\Repl;

use Calc\Eval\Evaluator;
use Calc\Output\ResultFormatter;
use Calc\Parsing\Parser;

require_once __DIR__ . '/../Parsing/Parser.php';
require_once __DIR__ . '/../Eval/Evaluator.php';
require_once __DIR__ . '/../Output/ResultFormatter.php';
require_once __DIR__ . '/CommandRouter.php';

class Repl
{
    private InputReader $reader;

    public function __construct(private ReplContext $context)
    {
        $this->reader = new InputReader('calc> ');
    }

    public function run(): void
    {
        $evaluator = new Evaluator($this->context->environment, $this->context->functions);
        while ($this->context->settings->running && ($line = $this->reader->nextLine()) !== false) {
            $line = trim($line);
            if ($line === '') { continue; }
            if (str_starts_with($line, ':')) {
                echo CommandRouter::dispatch($line, $this->context) . "\n";
                continue;
            }
            $value = $evaluator->eval((new Parser($line))->parseStatement());
            $this->context->history->append($line, $value);
            echo ResultFormatter::formatResult($value, $this->context->settings) . "\n";
        }
    }
}
