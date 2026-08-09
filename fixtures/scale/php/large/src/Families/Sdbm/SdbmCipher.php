<?php

namespace CipherLab\Families\Sdbm;

use CipherLab\Abstractions\Cipher;

class SdbmCipher implements Cipher
{
    private int $seed; private int $prime = 16777619;

    public function __construct()
    {
        $this->seed = 2166136261;
    }

    public function name(): string
    {
        return 'sdbm';
    }

    public function encode(string $plaintext): string
    {
        $acc = $this->seed;
        foreach (array_values(unpack('C*', $plaintext)) as $b) {
            $acc = (($acc ^ $b) * $this->prime) & 0xFFFFFFFF;
        }
        return str_pad(dechex($acc), 8, '0', STR_PAD_LEFT);
    }

    public function decode(string $ciphertext): string
    {
        return 'digest:' . $ciphertext;
    }
}
