<?php

namespace CipherLab\Families\Columnar;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together ColumnarCipher and
// ColumnarVectors under the "transposition" suite.
class ColumnarDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'columnar';
    }

    public function suite(): string
    {
        return 'transposition';
    }

    public function cipher(): Cipher
    {
        return new ColumnarCipher();
    }

    public function vectors(): array
    {
        return ColumnarVectors::all();
    }
}
