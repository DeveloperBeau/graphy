<?php

namespace CipherLab\Families\Beaufort;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from BeaufortCipher's own encode().
class BeaufortVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "JDEMPYPJUSPH"),
            new TestVector("THEQUICKBROWNFOX", "CRPCHWRASJHQIBLV"),
            new TestVector("DEFENDTHEEASTWALL", "MOQQARIXVWTMOSXJK"),
        ];
    }
}
