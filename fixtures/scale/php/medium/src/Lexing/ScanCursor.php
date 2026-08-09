<?php

namespace Calc\Lexing;

class ScanCursor
{
    private int $position = 0;

    public function __construct(private string $source)
    {
    }

    public function atEnd(): bool
    {
        return $this->position >= strlen($this->source);
    }

    public function peek(): string
    {
        return $this->atEnd() ? "\0" : $this->source[$this->position];
    }

    public function advance(): string
    {
        return $this->source[$this->position++];
    }
}
