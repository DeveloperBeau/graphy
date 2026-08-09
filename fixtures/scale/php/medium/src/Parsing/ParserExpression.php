<?php

namespace Calc\Parsing;

use Calc\Ast\BinaryOp;
use Calc\Ast\Node;
use Calc\Lexing\TokenKind;

trait ParserExpression
{
    public function parseExpression(int $minPrecedence): Node
    {
        $left = $this->parsePrimary();
        while ($this->stream->current()->kind === TokenKind::Operator
            && Precedence::of($this->stream->current()->text) >= $minPrecedence) {
            $op = $this->stream->advance()->text;
            $next = Precedence::rightAssociative($op) ? Precedence::of($op) : Precedence::of($op) + 1;
            $left = new BinaryOp($op, $left, $this->parseExpression($next));
        }
        return $left;
    }
}
