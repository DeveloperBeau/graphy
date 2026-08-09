<?php

namespace CipherLab\Families\Scytale;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together ScytaleCipher and
// ScytaleVectors under the "transposition" suite.
class ScytaleDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'scytale';
    }

    public function suite(): string
    {
        return 'transposition';
    }

    public function cipher(): Cipher
    {
        return new ScytaleCipher();
    }

    public function vectors(): array
    {
        return ScytaleVectors::all();
    }
}
