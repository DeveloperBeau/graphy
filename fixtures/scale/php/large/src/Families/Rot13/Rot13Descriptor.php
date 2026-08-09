<?php

namespace CipherLab\Families\Rot13;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together Rot13Cipher and
// Rot13Vectors under the "classical" suite.
class Rot13Descriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'rot13';
    }

    public function suite(): string
    {
        return 'classical';
    }

    public function cipher(): Cipher
    {
        return new Rot13Cipher();
    }

    public function vectors(): array
    {
        return Rot13Vectors::all();
    }
}
