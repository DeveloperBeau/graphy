<?php

namespace CipherLab\Cli;

class Config
{
    public int $iterations = 2000;
    public string $suiteFilter = 'all';
    public bool $persist = true;

    public static function defaults(): self
    {
        return new self();
    }
}
