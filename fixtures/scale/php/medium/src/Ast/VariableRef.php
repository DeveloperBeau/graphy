<?php

namespace Calc\Ast;

class VariableRef implements Node
{
    public function __construct(public string $name)
    {
    }

    public function describe(): string
    {
        return $this->name;
    }
}
