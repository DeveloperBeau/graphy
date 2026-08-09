<?php

namespace CipherLab\Families\Polybius;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together PolybiusCipher and
// PolybiusVectors under the "classical" suite.
class PolybiusDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'polybius';
    }

    public function suite(): string
    {
        return 'classical';
    }

    public function cipher(): Cipher
    {
        return new PolybiusCipher();
    }

    public function vectors(): array
    {
        return PolybiusVectors::all();
    }
}
