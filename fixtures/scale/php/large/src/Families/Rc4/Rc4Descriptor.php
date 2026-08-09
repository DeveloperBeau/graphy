<?php

namespace CipherLab\Families\Rc4;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together Rc4Cipher and
// Rc4Vectors under the "stream" suite.
class Rc4Descriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'rc4';
    }

    public function suite(): string
    {
        return 'stream';
    }

    public function cipher(): Cipher
    {
        return new Rc4Cipher();
    }

    public function vectors(): array
    {
        return Rc4Vectors::all();
    }
}
