<?php

namespace CipherLab\Families\Trithemius;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from TrithemiusCipher's own encode().
class TrithemiusVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "EADNSDWSFFEY"),
            new TestVector("THEQUICKBROWNFOX", "XOODKBYJDWWHBWIU"),
            new TestVector("DEFENDTHEEASTWALL", "HLPRDWPGGJIDHNUIL"),
        ];
    }
}
