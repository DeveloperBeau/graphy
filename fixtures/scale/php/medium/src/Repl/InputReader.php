<?php

namespace Calc\Repl;

class InputReader
{
    public function __construct(private string $prompt)
    {
    }

    public function nextLine(): string|false
    {
        echo $this->prompt;
        return fgets(STDIN);
    }
}
