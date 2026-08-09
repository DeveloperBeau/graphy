<?php

namespace CipherLab\Families\Affine;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the affine family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class AffineBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new AffineCipher(), AffineVectors::all(), $iterations);
    }
}
