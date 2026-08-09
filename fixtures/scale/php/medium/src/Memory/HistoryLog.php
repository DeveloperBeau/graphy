<?php

namespace Calc\Memory;

require_once __DIR__ . '/HistoryEntry.php';

class HistoryLog
{
    /** @var HistoryEntry[] */
    private array $entries = [];

    public function append(string $expression, float $value): HistoryEntry
    {
        $entry = new HistoryEntry($expression, $value);
        $this->entries[] = $entry;
        return $entry;
    }

    public function recent(int $count): array
    {
        return array_slice($this->entries, -$count);
    }

    public function count(): int
    {
        return count($this->entries);
    }
}
