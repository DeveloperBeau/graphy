<?php

namespace CipherLab\Families\Crc32;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together Crc32Cipher and
// Crc32Vectors under the "hash" suite.
class Crc32Descriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'crc32';
    }

    public function suite(): string
    {
        return 'hash';
    }

    public function cipher(): Cipher
    {
        return new Crc32Cipher();
    }

    public function vectors(): array
    {
        return Crc32Vectors::all();
    }
}
