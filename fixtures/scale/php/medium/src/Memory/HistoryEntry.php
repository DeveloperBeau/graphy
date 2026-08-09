<?php

namespace Calc\Memory;

class HistoryEntry
{
    public \DateTimeImmutable $stamp;

    public function __construct(public string $expression, public float $value)
    {
        $this->stamp = new \DateTimeImmutable();
    }

    public function format(): string
    {
        return $this->expression . ' => ' . $this->value;
    }
}
