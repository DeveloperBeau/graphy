<?php

namespace CipherLab\Families\Autokey;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the autokey family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class AutokeyRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new AutokeyCipher(), AutokeyVectors::all());
    }
}
