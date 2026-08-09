<?php

namespace CipherLab\Families\Atbash;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the atbash family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class AtbashBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new AtbashCipher(), AtbashVectors::all(), $iterations);
    }
}
