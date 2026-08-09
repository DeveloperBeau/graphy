<?php

namespace CipherLab\Families\Feistel;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the feistel family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class FeistelBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new FeistelCipher(), FeistelVectors::all(), $iterations);
    }
}
