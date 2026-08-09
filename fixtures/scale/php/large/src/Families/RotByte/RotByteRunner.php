<?php

namespace CipherLab\Families\RotByte;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the rotbyte family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class RotByteRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new RotByteCipher(), RotByteVectors::all());
    }
}
