<?php

namespace CipherLab\Families\XorRolling;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the xorrolling family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class XorRollingRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new XorRollingCipher(), XorRollingVectors::all());
    }
}
