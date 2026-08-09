<?php

namespace CipherLab\Families\Beaufort;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the beaufort family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class BeaufortRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new BeaufortCipher(), BeaufortVectors::all());
    }
}
