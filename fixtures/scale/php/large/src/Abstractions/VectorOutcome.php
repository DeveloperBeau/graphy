<?php

namespace CipherLab\Abstractions;

class VectorOutcome
{
    public function __construct(public string $family, public bool $passed, public string $detail)
    {
    }
}
