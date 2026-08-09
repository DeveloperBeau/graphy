<?php

namespace CipherLab\Engine;

use CipherLab\Registry\FamilyCatalog;

class Harness
{
    private CorrectnessEngine $correctness;

    public function __construct()
    {
        $this->correctness = new CorrectnessEngine();
    }

    /** @return \CipherLab\Abstractions\VectorOutcome[] */
    public function runAll(ProgressReporter $reporter): array
    {
        $outcomes = [];
        foreach (FamilyCatalog::all() as $descriptor) {
            $outcome = $this->correctness->verify($descriptor->cipher(), $descriptor->vectors());
            $reporter->step($descriptor->family(), $outcome->passed);
            $outcomes[] = $outcome;
        }
        return $outcomes;
    }
}
