<?php

namespace CipherLab\Families\Columnar;

use CipherLab\Abstractions\TestVector;

// Known-answer test data captured from ColumnarCipher's own encode().
class ColumnarVectors
{
    /** @return TestVector[] */
    public static function all(): array
    {
        return [
            new TestVector("ATTACKATDAWN", "JEGPTDVQCBZS"),
            new TestVector("THEQUICKBROWNFOX", "CSRFLBXHASRBUOZK"),
            new TestVector("DEFENDTHEEASTWALL", "MPSTEWOEDFDXAFLYA"),
        ];
    }
}
