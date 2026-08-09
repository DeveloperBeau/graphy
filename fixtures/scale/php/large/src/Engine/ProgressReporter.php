<?php

namespace CipherLab\Engine;

class ProgressReporter
{
    private int $done = 0;

    public function __construct(private int $total)
    {
    }

    public function step(string $family, bool $passed): void
    {
        $this->done++;
        $flag = $passed ? 'ok ' : 'BAD';
        fwrite(STDERR, "\r[{$this->done}/{$this->total}] {$flag} {$family}        ");
        if ($this->done === $this->total) {
            fwrite(STDERR, "\n");
        }
    }
}
