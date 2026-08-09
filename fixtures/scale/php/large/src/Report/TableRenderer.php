<?php

namespace CipherLab\Report;

class TableRenderer
{
    private array $rows = [];

    public function row(array $cells): void
    {
        $this->rows[] = $cells;
    }

    public function render(): string
    {
        return implode("\n", array_map(fn (array $r) => implode('  ', $r), $this->rows));
    }
}
