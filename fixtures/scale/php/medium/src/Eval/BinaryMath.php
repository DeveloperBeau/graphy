<?php

namespace Calc\Eval;

require_once __DIR__ . '/EvalError.php';

class BinaryMath
{
    public static function apply(string $op, float $left, float $right): float
    {
        return match ($op) {
            '+' => $left + $right,
            '-' => $left - $right,
            '*' => $left * $right,
            '/' => $right === 0.0 ? throw new EvalError('division by zero', $op) : $left / $right,
            '%' => fmod($left, $right),
            '^' => $left ** $right,
            default => throw new EvalError('unknown operator', $op),
        };
    }
}
