<?php

namespace Calc\Output;

class TablePrinter
{
    private array $rows = [];

    public function __construct(private array $headers)
    {
    }

    public function addRow(array $cells): void
    {
        $this->rows[] = $cells;
    }

    public function render(): string
    {
        $lines = [implode(' | ', $this->headers)];
        foreach ($this->rows as $row) {
            $lines[] = implode(' | ', $row);
        }
        return implode("\n", $lines);
    }
}
