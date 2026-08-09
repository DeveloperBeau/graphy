<?php

namespace CipherLab\Families\Rc4;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the rc4 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class Rc4Bench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new Rc4Cipher(), Rc4Vectors::all(), $iterations);
    }
}
