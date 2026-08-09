<?php

namespace CipherLab\Families\XorStatic;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the xorstatic family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class XorStaticRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new XorStaticCipher(), XorStaticVectors::all());
    }
}
