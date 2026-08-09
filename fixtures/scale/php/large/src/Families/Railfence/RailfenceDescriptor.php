<?php

namespace CipherLab\Families\Railfence;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together RailfenceCipher and
// RailfenceVectors under the "transposition" suite.
class RailfenceDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'railfence';
    }

    public function suite(): string
    {
        return 'transposition';
    }

    public function cipher(): Cipher
    {
        return new RailfenceCipher();
    }

    public function vectors(): array
    {
        return RailfenceVectors::all();
    }
}
