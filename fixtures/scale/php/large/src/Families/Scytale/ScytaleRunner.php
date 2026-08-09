<?php

namespace CipherLab\Families\Scytale;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the scytale family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class ScytaleRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new ScytaleCipher(), ScytaleVectors::all());
    }
}
