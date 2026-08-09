<?php

namespace CipherLab\Abstractions;

// Implemented once per cipher family under Families/<Name>/<Name>Cipher.php.
interface Cipher
{
    public function name(): string;
    public function encode(string $plaintext): string;
    public function decode(string $ciphertext): string;
}
