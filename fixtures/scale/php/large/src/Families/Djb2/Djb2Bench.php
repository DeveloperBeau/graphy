<?php

namespace CipherLab\Families\Djb2;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the djb2 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class Djb2Bench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new Djb2Cipher(), Djb2Vectors::all(), $iterations);
    }
}
