<?php

namespace CipherLab\Families\Keyword;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together KeywordCipher and
// KeywordVectors under the "classical" suite.
class KeywordDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'keyword';
    }

    public function suite(): string
    {
        return 'classical';
    }

    public function cipher(): Cipher
    {
        return new KeywordCipher();
    }

    public function vectors(): array
    {
        return KeywordVectors::all();
    }
}
