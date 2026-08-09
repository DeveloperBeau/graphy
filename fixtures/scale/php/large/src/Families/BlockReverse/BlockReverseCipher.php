<?php

namespace CipherLab\Families\BlockReverse;

use CipherLab\Abstractions\Cipher;

class BlockReverseCipher implements Cipher
{
    private int $rounds;

    public function __construct()
    {
        $this->rounds = 2;
    }

    public function name(): string
    {
        return 'blockreverse';
    }

    public function encode(string $plaintext): string
    {
        $out = '';
        foreach (array_values(unpack('C*', $plaintext)) as $b) {
            $rotated = (($b << $this->rounds) | ($b >> (8 - $this->rounds))) & 0xFF;
            $out .= str_pad(dechex($rotated), 2, '0', STR_PAD_LEFT);
        }
        return $out;
    }

    public function decode(string $ciphertext): string
    {
        $out = '';
        for ($i = 0; $i < strlen($ciphertext); $i += 2) {
            $value = hexdec(substr($ciphertext, $i, 2));
            $out .= chr((($value >> $this->rounds) | ($value << (8 - $this->rounds))) & 0xFF);
        }
        return $out;
    }
}
