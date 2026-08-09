<?php

namespace CipherLab\Families\Gronsfeld;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together GronsfeldCipher and
// GronsfeldVectors under the "polyalphabetic" suite.
class GronsfeldDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'gronsfeld';
    }

    public function suite(): string
    {
        return 'polyalphabetic';
    }

    public function cipher(): Cipher
    {
        return new GronsfeldCipher();
    }

    public function vectors(): array
    {
        return GronsfeldVectors::all();
    }
}
