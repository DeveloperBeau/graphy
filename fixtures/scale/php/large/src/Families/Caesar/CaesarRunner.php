<?php

namespace CipherLab\Families\Caesar;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the caesar family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class CaesarRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new CaesarCipher(), CaesarVectors::all());
    }
}
