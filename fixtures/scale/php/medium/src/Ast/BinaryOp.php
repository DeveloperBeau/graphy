<?php

namespace Calc\Ast;

class BinaryOp implements Node
{
    public function __construct(public string $op, public Node $left, public Node $right)
    {
    }

    public function describe(): string
    {
        return '(' . $this->left->describe() . ' ' . $this->op . ' ' . $this->right->describe() . ')';
    }
}
