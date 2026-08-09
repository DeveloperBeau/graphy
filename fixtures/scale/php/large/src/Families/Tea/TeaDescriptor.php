<?php

namespace CipherLab\Families\Tea;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together TeaCipher and
// TeaVectors under the "block" suite.
class TeaDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'tea';
    }

    public function suite(): string
    {
        return 'block';
    }

    public function cipher(): Cipher
    {
        return new TeaCipher();
    }

    public function vectors(): array
    {
        return TeaVectors::all();
    }
}
