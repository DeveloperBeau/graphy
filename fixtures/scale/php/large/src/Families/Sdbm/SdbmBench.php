<?php

namespace CipherLab\Families\Sdbm;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the sdbm family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class SdbmBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new SdbmCipher(), SdbmVectors::all(), $iterations);
    }
}
