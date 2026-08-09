<?php

namespace Calc\Repl;

use Calc\Output\NumberFormat;
use Calc\Output\TablePrinter;

class HistoryCommand
{
    public static function run(ReplContext $context, array $parts): string
    {
        $table = new TablePrinter(['expression', 'value']);
        foreach ($context->history->recent(10) as $entry) {
            $table->addRow([$entry->expression, NumberFormat::format($entry->value, $context->settings->precision)]);
        }
        return $table->render();
    }
}
