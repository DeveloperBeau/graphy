<?php

namespace CipherLab\Store;

class StorePaths
{
    public static function storeDir(): string
    {
        return getcwd() . '/.cipherlab';
    }

    public static function resultsFile(): string
    {
        return self::storeDir() . '/results.jsonl';
    }

    public static function ensureDir(): void
    {
        if (!is_dir(self::storeDir())) {
            mkdir(self::storeDir(), 0777, true);
        }
    }
}
