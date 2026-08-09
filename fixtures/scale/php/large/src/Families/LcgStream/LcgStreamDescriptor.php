<?php

namespace CipherLab\Families\LcgStream;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\FamilyDescriptor;

// Registered once in FamilyCatalog; ties together LcgStreamCipher and
// LcgStreamVectors under the "stream" suite.
class LcgStreamDescriptor implements FamilyDescriptor
{
    public function family(): string
    {
        return 'lcgstream';
    }

    public function suite(): string
    {
        return 'stream';
    }

    public function cipher(): Cipher
    {
        return new LcgStreamCipher();
    }

    public function vectors(): array
    {
        return LcgStreamVectors::all();
    }
}
