<?php

namespace CipherLab\Families\Fnv1a32;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the fnv1a32 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class Fnv1a32Bench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new Fnv1a32Cipher(), Fnv1a32Vectors::all(), $iterations);
    }
}
