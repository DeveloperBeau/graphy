<?php

namespace CipherLab\Families\Atbash;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the atbash family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class AtbashRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new AtbashCipher(), AtbashVectors::all());
    }
}
