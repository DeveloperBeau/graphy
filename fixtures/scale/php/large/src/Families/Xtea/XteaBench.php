<?php

namespace CipherLab\Families\Xtea;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the xtea family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class XteaBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new XteaCipher(), XteaVectors::all(), $iterations);
    }
}
