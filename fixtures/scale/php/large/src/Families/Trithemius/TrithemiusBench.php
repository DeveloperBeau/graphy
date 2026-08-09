<?php

namespace CipherLab\Families\Trithemius;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the trithemius family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class TrithemiusBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new TrithemiusCipher(), TrithemiusVectors::all(), $iterations);
    }
}
