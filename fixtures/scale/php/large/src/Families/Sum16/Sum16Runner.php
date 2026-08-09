<?php

namespace CipherLab\Families\Sum16;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the sum16 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class Sum16Runner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new Sum16Cipher(), Sum16Vectors::all());
    }
}
