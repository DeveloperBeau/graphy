<?php

namespace Calc\Ast;

class NumberLiteral implements Node
{
    public function __construct(public float $value)
    {
    }

    public function describe(): string
    {
        return (string) $this->value;
    }
}
