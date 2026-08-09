<?php

namespace CipherLab\Families\Columnar;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the columnar family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class ColumnarRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new ColumnarCipher(), ColumnarVectors::all());
    }
}
