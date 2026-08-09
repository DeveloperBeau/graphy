<?php

namespace CipherLab\Families\Keyword;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from KeywordCipher's own encode().
class KeywordVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "FZAILULFQOLD"),
            new TestVector("THEQUICKBROWNFOX", "YNLYDSNWOFDMEXHR"),
            new TestVector("DEFENDTHEEASTWALL", "IKMMWNETRSPIKOTFG"),
        ];
    }
}
