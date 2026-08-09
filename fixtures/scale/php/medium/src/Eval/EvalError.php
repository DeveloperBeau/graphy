<?php

namespace Calc\Eval;

class EvalError extends \Exception
{
    public function __construct(string $message, public string $subject)
    {
        parent::__construct($message);
    }

    public function pretty(): string
    {
        return $this->getMessage() . ': ' . $this->subject;
    }
}
