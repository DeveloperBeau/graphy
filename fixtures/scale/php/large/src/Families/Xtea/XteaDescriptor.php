<?php

namespace CipherLab\Families\Xtea;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together XteaCipher and
// XteaVectors under the "block" suite.
class XteaDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'xtea';
    }

    public function suite(): string
    {
        return 'block';
    }

    public function cipher(): Cipher
    {
        return new XteaCipher();
    }

    public function vectors(): array
    {
        return XteaVectors::all();
    }
}
