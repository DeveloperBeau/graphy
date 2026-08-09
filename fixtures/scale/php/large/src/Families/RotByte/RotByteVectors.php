<?php

namespace CipherLab\Families\RotByte;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from RotByteCipher's own encode().
class RotByteVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("The quick brown fox jumps ov", "576c6026767d6069602c6f7c60677f32757b6d367d6d746a683c7268"),
            new TestVector("cipher test corpus", "606d756e627a297e6e7f792e6c7f63626667"),
            new TestVector("0123456789abcdef", "33353735333d3f3d33356c6c6c747474"),
        ];
    }
}
