<?php

namespace CipherLab\Families\Tea;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the tea family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class TeaRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new TeaCipher(), TeaVectors::all());
    }
}
