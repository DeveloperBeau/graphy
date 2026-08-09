<?php

namespace CipherLab\Families\Affine;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together AffineCipher and
// AffineVectors under the "classical" suite.
class AffineDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'affine';
    }

    public function suite(): string
    {
        return 'classical';
    }

    public function cipher(): Cipher
    {
        return new AffineCipher();
    }

    public function vectors(): array
    {
        return AffineVectors::all();
    }
}
