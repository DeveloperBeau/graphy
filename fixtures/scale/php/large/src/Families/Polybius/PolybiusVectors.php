<?php

namespace CipherLab\Families\Polybius;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from PolybiusCipher's own encode().
class PolybiusVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "DZCMRCVREEDX"),
            new TestVector("THEQUICKBROWNFOX", "WNNCJAXICVVGAVHT"),
            new TestVector("DEFENDTHEEASTWALL", "GKOQCVOFFIHCGMTHK"),
        ];
    }
}
