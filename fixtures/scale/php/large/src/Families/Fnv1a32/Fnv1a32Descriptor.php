<?php

namespace CipherLab\Families\Fnv1a32;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together Fnv1a32Cipher and
// Fnv1a32Vectors under the "hash" suite.
class Fnv1a32Descriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'fnv1a32';
    }

    public function suite(): string
    {
        return 'hash';
    }

    public function cipher(): Cipher
    {
        return new Fnv1a32Cipher();
    }

    public function vectors(): array
    {
        return Fnv1a32Vectors::all();
    }
}
