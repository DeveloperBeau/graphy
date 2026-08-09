<?php

namespace CipherLab\Families\Caesar;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from CaesarCipher's own encode().
class CaesarVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "DXYGJSJDOMJB"),
            new TestVector("THEQUICKBROWNFOX", "WLJWBQLUMDBKCVFP"),
            new TestVector("DEFENDTHEEASTWALL", "GIKKULCRPQNGIMRDE"),
        ];
    }
}
