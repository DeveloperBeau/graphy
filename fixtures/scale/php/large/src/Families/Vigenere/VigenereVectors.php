<?php

namespace CipherLab\Families\Vigenere;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from VigenereCipher's own encode().
class VigenereVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "HCENRBTOAZXQ"),
            new TestVector("THEQUICKBROWNFOX", "AQPDJZVFYQPZSMXI"),
            new TestVector("DEFENDTHEEASTWALL", "KNQRCUMCBDBVYDJWY"),
        ];
    }
}
