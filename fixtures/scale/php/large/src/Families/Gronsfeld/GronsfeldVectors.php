<?php

namespace CipherLab\Families\Gronsfeld;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from GronsfeldCipher's own encode().
class GronsfeldVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "DYAJNXPKWVTM"),
            new TestVector("THEQUICKBROWNFOX", "WMLZFVRBUMLVOITE"),
            new TestVector("DEFENDTHEEASTWALL", "GJMNYQIYXZXRUZFSU"),
        ];
    }
}
