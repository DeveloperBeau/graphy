<?php

namespace Calc\Repl;

use Calc\Output\NumberFormat;
use Calc\Output\TablePrinter;

require_once __DIR__ . '/../Output/TablePrinter.php';
require_once __DIR__ . '/../Output/NumberFormat.php';

class VarsCommand
{
    public static function run(ReplContext $context, array $parts): string
    {
        $table = new TablePrinter(['name', 'value']);
        foreach ($context->environment->names() as $name) {
            $value = $context->environment->resolve($name);
            $table->addRow([$name, NumberFormat::format($value, $context->settings->precision)]);
        }
        return $table->render();
    }
}
