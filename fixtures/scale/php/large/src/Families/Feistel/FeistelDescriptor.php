<?php

namespace CipherLab\Families\Feistel;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together FeistelCipher and
// FeistelVectors under the "block" suite.
class FeistelDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'feistel';
    }

    public function suite(): string
    {
        return 'block';
    }

    public function cipher(): Cipher
    {
        return new FeistelCipher();
    }

    public function vectors(): array
    {
        return FeistelVectors::all();
    }
}
