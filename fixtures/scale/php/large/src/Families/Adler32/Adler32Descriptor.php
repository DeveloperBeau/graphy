<?php

namespace CipherLab\Families\Adler32;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together Adler32Cipher and
// Adler32Vectors under the "hash" suite.
class Adler32Descriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'adler32';
    }

    public function suite(): string
    {
        return 'hash';
    }

    public function cipher(): Cipher
    {
        return new Adler32Cipher();
    }

    public function vectors(): array
    {
        return Adler32Vectors::all();
    }
}
