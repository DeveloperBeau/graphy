<?php

namespace Calc\Ast;

class FunctionCall implements Node
{
    /** @param Node[] $arguments */
    public function __construct(public string $name, public array $arguments)
    {
    }

    public function describe(): string
    {
        $parts = array_map(fn (Node $n) => $n->describe(), $this->arguments);
        return $this->name . '(' . implode(', ', $parts) . ')';
    }
}
