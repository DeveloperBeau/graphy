<?php

namespace Calc\Ast;

// Common interface implemented by every expression tree node produced
// by the parser and consumed by the evaluator.
interface Node
{
    // Renders the node back to a source-like fragment; used for
    // history logging and error messages.
    public function describe(): string;
}
