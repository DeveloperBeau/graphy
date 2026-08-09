<?php

namespace Calc\Parsing;

class Precedence
{
    public static function of(string $op): int
    {
        return match ($op) {
            '+', '-' => 1,
            '*', '/', '%' => 2,
            '^' => 3,
            default => 0,
        };
    }

    public static function rightAssociative(string $op): bool
    {
        return $op === '^';
    }
}
