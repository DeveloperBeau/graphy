<?php

namespace CipherLab\Families\Djb2;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the djb2 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class Djb2Runner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new Djb2Cipher(), Djb2Vectors::all());
    }
}
