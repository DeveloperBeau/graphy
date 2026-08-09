<?php

namespace CipherLab\Families\Substitution;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together SubstitutionCipher and
// SubstitutionVectors under the "classical" suite.
class SubstitutionDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'substitution';
    }

    public function suite(): string
    {
        return 'classical';
    }

    public function cipher(): Cipher
    {
        return new SubstitutionCipher();
    }

    public function vectors(): array
    {
        return SubstitutionVectors::all();
    }
}
