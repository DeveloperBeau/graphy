<?php

namespace Calc\Parsing;

use Calc\Lexing\Lexer;
use Calc\Lexing\Token;
use Calc\Lexing\TokenKind;

require_once __DIR__ . '/../Lexing/Lexer.php';

class TokenStream
{
    /** @var Token[] */
    private array $tokens = [];
    private int $index = 0;

    public function __construct(string $source)
    {
        $lexer = new Lexer($source);
        do { $this->tokens[] = $token = $lexer->nextToken(); } while ($token->kind !== TokenKind::End);
    }

    public function current(): Token
    {
        return $this->tokens[min($this->index, count($this->tokens) - 1)];
    }

    public function advance(): Token
    {
        $token = $this->current();
        $this->index++;
        return $token;
    }

    public function looksLikeAssignment(): bool
    {
        return count($this->tokens) > 2 && $this->tokens[0]->kind === TokenKind::Identifier
            && $this->tokens[1]->kind === TokenKind::Equals;
    }
}
