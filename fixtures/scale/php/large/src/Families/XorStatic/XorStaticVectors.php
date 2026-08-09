<?php

namespace CipherLab\Families\XorStatic;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from XorStaticCipher's own encode().
class XorStaticVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("The quick brown fox jumps ov", "516e6228787f626f662e6d627e657d3473796f38736f766c6e3e7056"),
            new TestVector("cipher test corpus", "666f77606c782b78687d7b30727d61646065"),
            new TestVector("0123456789abcdef", "3537353b3d3f3d3b35376e7272767672"),
        ];
    }
}
