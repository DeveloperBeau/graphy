<?php

namespace CipherLab\Families\Caesar;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together CaesarCipher and
// CaesarVectors under the "classical" suite.
class CaesarDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'caesar';
    }

    public function suite(): string
    {
        return 'classical';
    }

    public function cipher(): Cipher
    {
        return new CaesarCipher();
    }

    public function vectors(): array
    {
        return CaesarVectors::all();
    }
}
