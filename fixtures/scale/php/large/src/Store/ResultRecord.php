<?php

namespace CipherLab\Store;

class ResultRecord
{
    public function __construct(public string $family, public string $suite, public bool $passed)
    {
    }

    public function toLine(): string
    {
        return implode("\t", [$this->family, $this->suite, $this->passed ? '1' : '0']);
    }

    public static function fromLine(string $line): self
    {
        [$family, $suite, $flag] = explode("\t", $line);
        return new self($family, $suite, $flag === '1');
    }
}
