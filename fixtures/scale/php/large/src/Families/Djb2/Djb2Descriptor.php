<?php

namespace CipherLab\Families\Djb2;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together Djb2Cipher and
// Djb2Vectors under the "hash" suite.
class Djb2Descriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'djb2';
    }

    public function suite(): string
    {
        return 'hash';
    }

    public function cipher(): Cipher
    {
        return new Djb2Cipher();
    }

    public function vectors(): array
    {
        return Djb2Vectors::all();
    }
}
