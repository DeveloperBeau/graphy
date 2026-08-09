<?php

namespace CipherLab\Families\Caesar;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the caesar family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class CaesarBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new CaesarCipher(), CaesarVectors::all(), $iterations);
    }
}
