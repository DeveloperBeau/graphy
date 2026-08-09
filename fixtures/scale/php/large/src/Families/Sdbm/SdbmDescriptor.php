<?php

namespace CipherLab\Families\Sdbm;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together SdbmCipher and
// SdbmVectors under the "hash" suite.
class SdbmDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'sdbm';
    }

    public function suite(): string
    {
        return 'hash';
    }

    public function cipher(): Cipher
    {
        return new SdbmCipher();
    }

    public function vectors(): array
    {
        return SdbmVectors::all();
    }
}
