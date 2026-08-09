<?php

namespace Calc\Ast;

class UnaryOp implements Node
{
    public function __construct(public string $op, public Node $operand)
    {
    }

    public function describe(): string
    {
        return $this->op . $this->operand->describe();
    }
}
