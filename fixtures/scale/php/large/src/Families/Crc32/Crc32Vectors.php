<?php

namespace CipherLab\Families\Crc32;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from Crc32Cipher's own encode().
class Crc32Vectors
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
