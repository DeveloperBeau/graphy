<?php

namespace CipherLab\Families\Fnv1a32;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the fnv1a32 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class Fnv1a32Runner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new Fnv1a32Cipher(), Fnv1a32Vectors::all());
    }
}
