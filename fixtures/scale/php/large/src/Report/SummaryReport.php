<?php

namespace CipherLab\Report;

use CipherLab\Abstractions\VectorOutcome;

class SummaryReport
{
    public function build(array $outcomes, int $priorSessions): string
    {
        $passed = count(array_filter($outcomes, fn (VectorOutcome $o) => $o->passed));
        $table = new TableRenderer();
        $table->row(['metric', 'value']);
        $table->row(['families', (string) count($outcomes)]);
        $table->row(['passed', (string) $passed]);
        $table->row(['prior sessions', (string) $priorSessions]);
        return $table->render();
    }
}
