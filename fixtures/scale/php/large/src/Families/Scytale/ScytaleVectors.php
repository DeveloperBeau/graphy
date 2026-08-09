<?php

namespace CipherLab\Families\Scytale;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from ScytaleCipher's own encode().
class ScytaleVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "ICDLOXOITROG"),
            new TestVector("THEQUICKBROWNFOX", "BQOBGVQZRIGPHAKU"),
            new TestVector("DEFENDTHEEASTWALL", "LNPPZQHWUVSLNRWIJ"),
        ];
    }
}
