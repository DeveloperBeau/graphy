<?php

namespace CipherLab\Families\Tea;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the tea family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class TeaBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new TeaCipher(), TeaVectors::all(), $iterations);
    }
}
