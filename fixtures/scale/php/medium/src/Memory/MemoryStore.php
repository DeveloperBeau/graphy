<?php

namespace Calc\Memory;

class MemoryStore
{
    private float $slot = 0.0;

    public function store(float $value): void
    {
        $this->slot = $value;
    }

    public function recall(): float
    {
        return $this->slot;
    }

    public function accumulate(float $value): void
    {
        $this->slot += $value;
    }

    public function clear(): void
    {
        $this->slot = 0.0;
    }
}
