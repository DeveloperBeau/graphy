<?php

namespace CipherLab\Families\Polybius;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the polybius family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class PolybiusRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new PolybiusCipher(), PolybiusVectors::all());
    }
}
