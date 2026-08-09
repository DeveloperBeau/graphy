<?php

namespace CipherLab\Families\Autokey;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from AutokeyCipher's own encode().
class AutokeyVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "IEHRWHAWJJIC"),
            new TestVector("THEQUICKBROWNFOX", "BSSHOFCNHAALFAMY"),
            new TestVector("DEFENDTHEEASTWALL", "LPTVHATKKNMHLRYMP"),
        ];
    }
}
