<?php

namespace Calc\Parsing;

use Calc\Ast\FunctionCall;
use Calc\Ast\Node;
use Calc\Ast\NumberLiteral;
use Calc\Ast\VariableRef;
use Calc\Lexing\TokenKind;

trait ParserPrimary
{
    private function parsePrimary(): Node
    {
        $token = $this->stream->advance();
        if ($token->kind === TokenKind::Number) {
            return new NumberLiteral($token->numberValue());
        }
        if ($token->kind === TokenKind::LeftParen) {
            $inner = $this->parseExpression(1);
            $this->stream->advance();
            return $inner;
        }
        if ($token->kind === TokenKind::Identifier && $this->stream->current()->kind === TokenKind::LeftParen) {
            $this->stream->advance();
            $arguments = [$this->parseExpression(1)];
            while ($this->stream->current()->kind === TokenKind::Comma) {
                $this->stream->advance();
                $arguments[] = $this->parseExpression(1);
            }
            $this->stream->advance();
            return new FunctionCall($token->text, $arguments);
        }
        return new VariableRef($token->text);
    }
}
