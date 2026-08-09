<?php

namespace CipherLab\Families\NibbleSwap;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the nibbleswap family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class NibbleSwapBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new NibbleSwapCipher(), NibbleSwapVectors::all(), $iterations);
    }
}
