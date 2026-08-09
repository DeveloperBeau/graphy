<?php

namespace CipherLab\Families\Adler32;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the adler32 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class Adler32Runner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new Adler32Cipher(), Adler32Vectors::all());
    }
}
