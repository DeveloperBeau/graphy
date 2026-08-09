<?php

namespace CipherLab\Families\NibbleSwap;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the nibbleswap family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class NibbleSwapRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new NibbleSwapCipher(), NibbleSwapVectors::all());
    }
}
