<?php

namespace CipherLab\Families\Vigenere;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together VigenereCipher and
// VigenereVectors under the "polyalphabetic" suite.
class VigenereDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'vigenere';
    }

    public function suite(): string
    {
        return 'polyalphabetic';
    }

    public function cipher(): Cipher
    {
        return new VigenereCipher();
    }

    public function vectors(): array
    {
        return VigenereVectors::all();
    }
}
