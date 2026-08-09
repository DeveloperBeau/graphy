<?php

namespace CipherLab\Families\Sum16;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the sum16 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class Sum16Bench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new Sum16Cipher(), Sum16Vectors::all(), $iterations);
    }
}
