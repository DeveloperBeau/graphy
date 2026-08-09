<?php

namespace CipherLab\Families\Bacon;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together BaconCipher and
// BaconVectors under the "classical" suite.
class BaconDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'bacon';
    }

    public function suite(): string
    {
        return 'classical';
    }

    public function cipher(): Cipher
    {
        return new BaconCipher();
    }

    public function vectors(): array
    {
        return BaconVectors::all();
    }
}
