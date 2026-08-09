<?php

namespace CipherLab\Families\Substitution;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from SubstitutionCipher's own encode().
class SubstitutionVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "GBDMQASNZYWP"),
            new TestVector("THEQUICKBROWNFOX", "ZPOCIYUEXPOYRLWH"),
            new TestVector("DEFENDTHEEASTWALL", "JMPQBTLBACAUXCIVX"),
        ];
    }
}
