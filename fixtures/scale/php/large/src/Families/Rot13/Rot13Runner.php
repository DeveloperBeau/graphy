<?php

namespace CipherLab\Families\Rot13;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the rot13 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class Rot13Runner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new Rot13Cipher(), Rot13Vectors::all());
    }
}
