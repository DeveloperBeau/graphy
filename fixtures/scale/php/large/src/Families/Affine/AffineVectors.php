<?php

namespace CipherLab\Families\Affine;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from AffineCipher's own encode().
class AffineVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "GABJMVMGRPME"),
            new TestVector("THEQUICKBROWNFOX", "ZOMZETOXPGENFYIS"),
            new TestVector("DEFENDTHEEASTWALL", "JLNNXOFUSTQJLPUGH"),
        ];
    }
}
