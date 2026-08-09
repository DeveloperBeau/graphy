<?php

namespace CipherLab\Families\Trithemius;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the trithemius family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class TrithemiusRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new TrithemiusCipher(), TrithemiusVectors::all());
    }
}
