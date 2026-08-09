<?php

namespace CipherLab\Families\Substitution;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the substitution family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class SubstitutionBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new SubstitutionCipher(), SubstitutionVectors::all(), $iterations);
    }
}
