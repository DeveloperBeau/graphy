<?php

namespace CipherLab\Families\Bacon;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the bacon family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class BaconRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new BaconCipher(), BaconVectors::all());
    }
}
