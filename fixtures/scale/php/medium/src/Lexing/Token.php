<?php

namespace Calc\Lexing;

class Token
{
    public function __construct(public TokenKind $kind, public string $text)
    {
    }

    public function numberValue(): float
    {
        return (float) $this->text;
    }
}
