<?php

namespace CipherLab\Families\Atbash;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together AtbashCipher and
// AtbashVectors under the "classical" suite.
class AtbashDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'atbash';
    }

    public function suite(): string
    {
        return 'classical';
    }

    public function cipher(): Cipher
    {
        return new AtbashCipher();
    }

    public function vectors(): array
    {
        return AtbashVectors::all();
    }
}
