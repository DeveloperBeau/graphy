<?php

namespace CipherLab\Families\Atbash;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from AtbashCipher's own encode().
class AtbashVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "FBEOTEXTGGFZ"),
            new TestVector("THEQUICKBROWNFOX", "YPPELCZKEXXICXJV"),
            new TestVector("DEFENDTHEEASTWALL", "IMQSEXQHHKJEIOVJM"),
        ];
    }
}
