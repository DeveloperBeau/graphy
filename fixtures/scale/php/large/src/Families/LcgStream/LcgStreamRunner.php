<?php

namespace CipherLab\Families\LcgStream;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the lcgstream family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class LcgStreamRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new LcgStreamCipher(), LcgStreamVectors::all());
    }
}
