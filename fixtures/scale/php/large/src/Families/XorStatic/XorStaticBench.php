<?php

namespace CipherLab\Families\XorStatic;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the xorstatic family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class XorStaticBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new XorStaticCipher(), XorStaticVectors::all(), $iterations);
    }
}
