<?php

namespace CipherLab\Families\RotByte;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together RotByteCipher and
// RotByteVectors under the "stream" suite.
class RotByteDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'rotbyte';
    }

    public function suite(): string
    {
        return 'stream';
    }

    public function cipher(): Cipher
    {
        return new RotByteCipher();
    }

    public function vectors(): array
    {
        return RotByteVectors::all();
    }
}
