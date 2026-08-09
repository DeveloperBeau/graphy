<?php

namespace CipherLab\Families\Crc32;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the crc32 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class Crc32Runner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new Crc32Cipher(), Crc32Vectors::all());
    }
}
