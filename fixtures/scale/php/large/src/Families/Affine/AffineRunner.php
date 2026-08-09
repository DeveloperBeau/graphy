<?php

namespace CipherLab\Families\Affine;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the affine family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class AffineRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new AffineCipher(), AffineVectors::all());
    }
}
