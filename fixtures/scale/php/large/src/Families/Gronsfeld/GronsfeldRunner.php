<?php

namespace CipherLab\Families\Gronsfeld;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the gronsfeld family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class GronsfeldRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new GronsfeldCipher(), GronsfeldVectors::all());
    }
}
