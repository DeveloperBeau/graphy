<?php

namespace CipherLab\Families\Bacon;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the bacon family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class BaconBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new BaconCipher(), BaconVectors::all(), $iterations);
    }
}
