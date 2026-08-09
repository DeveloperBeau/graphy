<?php

namespace CipherLab\Families\Scytale;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the scytale family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class ScytaleBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new ScytaleCipher(), ScytaleVectors::all(), $iterations);
    }
}
