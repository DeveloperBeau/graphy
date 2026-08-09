<?php

namespace Calc\Functions;

use Calc\Eval\EvalError;

class FunctionRegistry
{
    /** @var array<string, callable> */
    private array $table = [];

    public function define(string $name, callable $body): void
    {
        $this->table[$name] = $body;
    }

    public function invoke(string $name, array $arguments): float
    {
        if (!isset($this->table[$name])) {
            throw new EvalError('unknown function', $name);
        }
        return ($this->table[$name])(...$arguments);
    }

    public function names(): array
    {
        $names = array_keys($this->table);
        sort($names);
        return $names;
    }
}
