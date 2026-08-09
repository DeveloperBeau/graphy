<?php

namespace CipherLab\Families\Autokey;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together AutokeyCipher and
// AutokeyVectors under the "polyalphabetic" suite.
class AutokeyDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'autokey';
    }

    public function suite(): string
    {
        return 'polyalphabetic';
    }

    public function cipher(): Cipher
    {
        return new AutokeyCipher();
    }

    public function vectors(): array
    {
        return AutokeyVectors::all();
    }
}
