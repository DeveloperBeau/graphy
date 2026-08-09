<?php

namespace CipherLab\Families\Bacon;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from BaconCipher's own encode().
class BaconVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "EYZHKTKEPNKC"),
            new TestVector("THEQUICKBROWNFOX", "XMKXCRMVNECLDWGQ"),
            new TestVector("DEFENDTHEEASTWALL", "HJLLVMDSQROHJNSEF"),
        ];
    }
}
