<?php

namespace CipherLab\Families\Rot13;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from Rot13Cipher's own encode().
class Rot13Vectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "EZBKOYQLXWUN"),
            new TestVector("THEQUICKBROWNFOX", "XNMAGWSCVNMWPJUF"),
            new TestVector("DEFENDTHEEASTWALL", "HKNOZRJZYAYSVAGTV"),
        ];
    }
}
