<?php

namespace CipherLab\Families\BlockReverse;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the blockreverse family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class BlockReverseRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new BlockReverseCipher(), BlockReverseVectors::all());
    }
}
