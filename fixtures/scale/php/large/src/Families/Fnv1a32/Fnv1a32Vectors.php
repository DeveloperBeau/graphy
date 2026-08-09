<?php

namespace CipherLab\Families\Fnv1a32;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from Fnv1a32Cipher's own encode().
class Fnv1a32Vectors
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
