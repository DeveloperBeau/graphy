<?php

namespace CipherLab\Families\BlockReverse;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the blockreverse family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class BlockReverseBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new BlockReverseCipher(), BlockReverseVectors::all(), $iterations);
    }
}
