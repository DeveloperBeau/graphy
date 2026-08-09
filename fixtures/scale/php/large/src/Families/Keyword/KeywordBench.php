<?php

namespace CipherLab\Families\Keyword;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the keyword family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class KeywordBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new KeywordCipher(), KeywordVectors::all(), $iterations);
    }
}
