<?php

namespace Calc\Ast;

class Assignment implements Node
{
    public function __construct(public string $name, public Node $value)
    {
    }

    public function describe(): string
    {
        return $this->name . ' = ' . $this->value->describe();
    }
}
