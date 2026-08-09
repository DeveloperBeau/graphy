<?php

namespace CipherLab\Families\Rot13;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the rot13 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class Rot13Bench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new Rot13Cipher(), Rot13Vectors::all(), $iterations);
    }
}
