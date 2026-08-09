<?php

namespace CipherLab\Families\Feistel;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the feistel family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class FeistelRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new FeistelCipher(), FeistelVectors::all());
    }
}
