<?php

namespace CipherLab\Families\Sum16;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together Sum16Cipher and
// Sum16Vectors under the "hash" suite.
class Sum16Descriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'sum16';
    }

    public function suite(): string
    {
        return 'hash';
    }

    public function cipher(): Cipher
    {
        return new Sum16Cipher();
    }

    public function vectors(): array
    {
        return Sum16Vectors::all();
    }
}
