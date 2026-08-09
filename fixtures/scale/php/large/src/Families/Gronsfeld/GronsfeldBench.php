<?php

namespace CipherLab\Families\Gronsfeld;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the gronsfeld family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class GronsfeldBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new GronsfeldCipher(), GronsfeldVectors::all(), $iterations);
    }
}
