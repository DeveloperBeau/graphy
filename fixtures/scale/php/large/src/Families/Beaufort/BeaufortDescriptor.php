<?php

namespace CipherLab\Families\Beaufort;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together BeaufortCipher and
// BeaufortVectors under the "polyalphabetic" suite.
class BeaufortDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'beaufort';
    }

    public function suite(): string
    {
        return 'polyalphabetic';
    }

    public function cipher(): Cipher
    {
        return new BeaufortCipher();
    }

    public function vectors(): array
    {
        return BeaufortVectors::all();
    }
}
