<?php

namespace CipherLab\Families\Railfence;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from RailfenceCipher's own encode().
class RailfenceVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "HDGQVGZVIIHB"),
            new TestVector("THEQUICKBROWNFOX", "ARRGNEBMGZZKEZLX"),
            new TestVector("DEFENDTHEEASTWALL", "KOSUGZSJJMLGKQXLO"),
        ];
    }
}
