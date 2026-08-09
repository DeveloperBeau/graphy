<?php

namespace CipherLab\Families\BlockReverse;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together BlockReverseCipher and
// BlockReverseVectors under the "block" suite.
class BlockReverseDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'blockreverse';
    }

    public function suite(): string
    {
        return 'block';
    }

    public function cipher(): Cipher
    {
        return new BlockReverseCipher();
    }

    public function vectors(): array
    {
        return BlockReverseVectors::all();
    }
}
