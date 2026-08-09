<?php

namespace CipherLab\Abstractions;

class BenchSample
{
    public function __construct(public string $family, public float $nanoseconds, public int $iterations)
    {
    }

    public function perOp(): float
    {
        return $this->iterations === 0 ? 0.0 : $this->nanoseconds / $this->iterations;
    }
}
