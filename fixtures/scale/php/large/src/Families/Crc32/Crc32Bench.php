<?php

namespace CipherLab\Families\Crc32;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the crc32 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class Crc32Bench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new Crc32Cipher(), Crc32Vectors::all(), $iterations);
    }
}
