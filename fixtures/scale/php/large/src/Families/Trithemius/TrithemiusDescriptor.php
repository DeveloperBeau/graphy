<?php

namespace CipherLab\Families\Trithemius;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together TrithemiusCipher and
// TrithemiusVectors under the "polyalphabetic" suite.
class TrithemiusDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'trithemius';
    }

    public function suite(): string
    {
        return 'polyalphabetic';
    }

    public function cipher(): Cipher
    {
        return new TrithemiusCipher();
    }

    public function vectors(): array
    {
        return TrithemiusVectors::all();
    }
}
