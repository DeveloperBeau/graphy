<?php

namespace CipherLab\Families\XorRolling;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the xorrolling family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class XorRollingBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new XorRollingCipher(), XorRollingVectors::all(), $iterations);
    }
}
