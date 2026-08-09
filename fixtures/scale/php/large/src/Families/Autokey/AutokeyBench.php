<?php

namespace CipherLab\Families\Autokey;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the autokey family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class AutokeyBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new AutokeyCipher(), AutokeyVectors::all(), $iterations);
    }
}
