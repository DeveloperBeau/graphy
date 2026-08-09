<?php

namespace CipherLab\Families\Keyword;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the keyword family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class KeywordRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new KeywordCipher(), KeywordVectors::all());
    }
}
