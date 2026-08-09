<?php

namespace CipherLab\Families\Feistel;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from FeistelCipher's own encode().
class FeistelVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("The quick brown!", "a2432b018bab4b1b5b0113937bbb7309"),
            new TestVector("0123456789abcdef", "81899199a1a9b1b9c1c90b131b232b33"),
            new TestVector("silver marble owl padloc", "9b4b63b32b93016b0b9313632b017bbb6301830b23637b1b"),
        ];
    }
}
