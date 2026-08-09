<?php

namespace CipherLab\Families\Vigenere;

use CipherLab\Abstractions\VectorOutcome;
use CipherLab\Engine\CorrectnessEngine;

// Correctness entry point for the vigenere family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
class VigenereRunner
{
    private CorrectnessEngine $engine;

    public function __construct()
    {
        $this->engine = new CorrectnessEngine();
    }

    public function check(): VectorOutcome
    {
        return $this->engine->verify(new VigenereCipher(), VigenereVectors::all());
    }
}
