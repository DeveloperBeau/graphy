<?php

namespace CipherLab\Families\Railfence;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the railfence family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class RailfenceRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new RailfenceCipher(), RailfenceVectors::all());
    }
}
