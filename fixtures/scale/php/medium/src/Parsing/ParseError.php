<?php

namespace Calc\Parsing;

class ParseError extends \Exception
{
    public function __construct(string $message, public string $fragment)
    {
        parent::__construct($message);
    }

    public function pretty(): string
    {
        return $this->getMessage() . " near '" . $this->fragment . "'";
    }
}
