<?php

namespace CipherLab\Families\Rc4;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the rc4 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class Rc4Runner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new Rc4Cipher(), Rc4Vectors::all());
    }
}
