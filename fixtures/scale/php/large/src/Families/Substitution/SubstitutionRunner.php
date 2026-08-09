<?php

namespace CipherLab\Families\Substitution;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the substitution family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class SubstitutionRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new SubstitutionCipher(), SubstitutionVectors::all());
    }
}
