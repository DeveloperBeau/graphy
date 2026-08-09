<?php

namespace Calc\Eval;

require_once __DIR__ . '/EvalError.php';

class Environment
{
    /** @var array<string, float> */
    private array $variables = [];

    public function assign(string $name, float $value): void
    {
        $this->variables[$name] = $value;
    }

    public function resolve(string $name): float
    {
        if (!array_key_exists($name, $this->variables)) {
            throw new EvalError('unknown variable', $name);
        }
        return $this->variables[$name];
    }

    public function names(): array
    {
        $names = array_keys($this->variables);
        sort($names);
        return $names;
    }
}
