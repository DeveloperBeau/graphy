<?php

namespace CipherLab\Families\Rc4;

use CipherLab\Abstractions\Cipher;

class Rc4Cipher implements Cipher
{
    private int $mask;

    public function __construct()
    {
        $this->mask = 7;
    }

    public function name(): string
    {
        return 'rc4';
    }

    public function encode(string $plaintext): string
    {
        $out = '';
        $bytes = array_values(unpack('C*', $plaintext));
        foreach ($bytes as $i => $b) {
            $out .= str_pad(dechex(($b ^ ($this->mask + $i)) & 0xFF), 2, '0', STR_PAD_LEFT);
        }
        return $out;
    }

    public function decode(string $ciphertext): string
    {
        $out = '';
        for ($i = 0; $i < strlen($ciphertext); $i += 2) {
            $value = hexdec(substr($ciphertext, $i, 2));
            $out .= chr(($value ^ ($this->mask + intdiv($i, 2))) & 0xFF);
        }
        return $out;
    }
}
