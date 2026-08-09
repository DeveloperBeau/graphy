<?php

namespace CipherLab\Families\Vigenere;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Engine\BenchmarkEngine;

// Benchmark entry point for the vigenere family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
class VigenereBench
{
    private BenchmarkEngine $engine;

    public function __construct()
    {
        $this->engine = new BenchmarkEngine();
    }

    public function measure(int $iterations): BenchSample
    {
        return $this->engine->sample(new VigenereCipher(), VigenereVectors::all(), $iterations);
    }
}
