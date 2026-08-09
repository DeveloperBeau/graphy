<?php

namespace CipherLab\Families\Djb2;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from Djb2Cipher's own encode().
class Djb2Vectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("abc", "1a47e90b"),
            new TestVector("hello world", "d58b3fa7"),
            new TestVector("The quick brown fox jumps over the lazy dog", "048fff90"),
        ];
    }
}
