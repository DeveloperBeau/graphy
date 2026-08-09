<?php

namespace CipherLab\Families\XorRolling;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together XorRollingCipher and
// XorRollingVectors under the "stream" suite.
class XorRollingDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'xorrolling';
    }

    public function suite(): string
    {
        return 'stream';
    }

    public function cipher(): Cipher
    {
        return new XorRollingCipher();
    }

    public function vectors(): array
    {
        return XorRollingVectors::all();
    }
}
