<?php

namespace CipherLab\Families\RotByte;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the rotbyte family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class RotByteBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new RotByteCipher(), RotByteVectors::all(), $iterations);
    }
}
