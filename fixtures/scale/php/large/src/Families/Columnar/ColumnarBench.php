<?php

namespace CipherLab\Families\Columnar;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the columnar family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class ColumnarBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new ColumnarCipher(), ColumnarVectors::all(), $iterations);
    }
}
