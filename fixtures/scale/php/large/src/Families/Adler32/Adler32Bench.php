<?php

namespace CipherLab\Families\Adler32;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the adler32 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class Adler32Bench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new Adler32Cipher(), Adler32Vectors::all(), $iterations);
    }
}
