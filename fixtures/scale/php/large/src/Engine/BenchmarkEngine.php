<?php

namespace CipherLab\Engine;

use CipherLab\Abstractions\BenchSample;
use CipherLab\Abstractions\Cipher;

class BenchmarkEngine
{
    public function sample(Cipher $cipher, array $vectors, int $iterations): BenchSample
    {
        $start = hrtime(true);
        for ($i = 0; $i < $iterations; $i++) {
            foreach ($vectors as $vector) {
                $cipher->encode($vector->plaintext);
            }
        }
        $elapsed = hrtime(true) - $start;
        return new BenchSample($cipher->name(), (float) $elapsed, $iterations * count($vectors));
    }
}
