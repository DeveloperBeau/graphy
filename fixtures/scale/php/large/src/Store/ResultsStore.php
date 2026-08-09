<?php

namespace CipherLab\Store;

class ResultsStore
{
    /** @return ResultRecord[] */
    public function priorRuns(): array
    {
        if (!file_exists(StorePaths::resultsFile())) {
            return [];
        }
        $lines = file(StorePaths::resultsFile(), FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        return array_map(fn (string $line) => ResultRecord::fromLine($line), $lines);
    }

    public function persist(array $records): void
    {
        StorePaths::ensureDir();
        $lines = array_map(fn (ResultRecord $r) => $r->toLine(), $records);
        file_put_contents(StorePaths::resultsFile(), implode("\n", $lines) . "\n", FILE_APPEND);
    }
}
