<?php

namespace CipherLab\Families\Polybius;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the polybius family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class PolybiusBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new PolybiusCipher(), PolybiusVectors::all(), $iterations);
    }
}
