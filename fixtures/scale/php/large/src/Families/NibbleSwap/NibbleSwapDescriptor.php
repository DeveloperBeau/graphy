<?php

namespace CipherLab\Families\NibbleSwap;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together NibbleSwapCipher and
// NibbleSwapVectors under the "stream" suite.
class NibbleSwapDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'nibbleswap';
    }

    public function suite(): string
    {
        return 'stream';
    }

    public function cipher(): Cipher
    {
        return new NibbleSwapCipher();
    }

    public function vectors(): array
    {
        return NibbleSwapVectors::all();
    }
}
