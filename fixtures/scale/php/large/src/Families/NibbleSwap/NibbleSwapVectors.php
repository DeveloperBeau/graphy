<?php

namespace CipherLab\Families\NibbleSwap;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from NibbleSwapCipher's own encode().
class NibbleSwapVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("The quick brown fox jumps ov", "5d626e2c7c7b66737a3271667a6179387f75633c776b725052024c52"),
            new TestVector("cipher test corpus", "6a637b64687c2f6474616734767965686c69"),
            new TestVector("0123456789abcdef", "393b393f393b3927292b72767672727e"),
        ];
    }
}
