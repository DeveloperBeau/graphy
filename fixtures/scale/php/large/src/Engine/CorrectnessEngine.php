<?php

namespace CipherLab\Engine;

use CipherLab\Abstractions\Cipher;
use CipherLab\Abstractions\VectorOutcome;

class CorrectnessEngine
{
    public function verify(Cipher $cipher, array $vectors): VectorOutcome
    {
        foreach ($vectors as $vector) {
            $encoded = $cipher->encode($vector->plaintext);
            if ($encoded !== $vector->expected) {
                return new VectorOutcome($cipher->name(), false, 'encode mismatch for ' . $vector->plaintext);
            }
            $decoded = $cipher->decode($encoded);
            if ($decoded === '' && $vector->plaintext !== '') {
                return new VectorOutcome($cipher->name(), false, 'empty decode');
            }
        }
        return new VectorOutcome($cipher->name(), true, 'ok');
    }
}
