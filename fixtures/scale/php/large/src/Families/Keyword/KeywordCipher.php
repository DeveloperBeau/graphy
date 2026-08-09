<?php

namespace CipherLab\Families\Keyword;

use CipherLab\Abstractions\Cipher;

class KeywordCipher implements Cipher
{
    private int $shift; private int $step;

    public function __construct()
    {
        $this->shift = 5; $this->step = 1;
    }

    public function name(): string
    {
        return 'keyword';
    }

    public function encode(string $plaintext): string
    {
        $chars = str_split($plaintext);
        foreach ($chars as $i => $ch) {
            if ($ch < 'A' || $ch > 'Z') { continue; }
            $chars[$i] = chr(65 + (ord($ch) - 65 + $this->shift + $i * $this->step) % 26);
        }
        return implode('', $chars);
    }

    public function decode(string $ciphertext): string
    {
        $chars = str_split($ciphertext);
        foreach ($chars as $i => $ch) {
            if ($ch < 'A' || $ch > 'Z') { continue; }
            $chars[$i] = chr(65 + ((ord($ch) - 65 - $this->shift - $i * $this->step) % 26 + 2600) % 26);
        }
        return implode('', $chars);
    }
}
