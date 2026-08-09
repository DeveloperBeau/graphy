<?php

namespace CipherLab\Families\XorStatic;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together XorStaticCipher and
// XorStaticVectors under the "stream" suite.
class XorStaticDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'xorstatic';
    }

    public function suite(): string
    {
        return 'stream';
    }

    public function cipher(): Cipher
    {
        return new XorStaticCipher();
    }

    public function vectors(): array
    {
        return XorStaticVectors::all();
    }
}
