<?php

namespace CipherLab\Abstractions;

class TestVector
{
    public function __construct(public string $plaintext, public string $expected)
    {
    }
}
