<?php

namespace CipherLab\Families\Sdbm;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the sdbm family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class SdbmRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new SdbmCipher(), SdbmVectors::all());
    }
}
