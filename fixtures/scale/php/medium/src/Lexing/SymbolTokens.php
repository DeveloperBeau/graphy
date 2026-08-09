<?php

namespace Calc\Lexing;

// Maps single-character punctuation to its token kind; kept apart
// from Lexer so the scanning loop stays focused on cursor state.
class SymbolTokens
{
    public static function tokenFor(string $ch): Token
    {
        return match ($ch) {
            '(' => new Token(TokenKind::LeftParen, $ch),
            ')' => new Token(TokenKind::RightParen, $ch),
            ',' => new Token(TokenKind::Comma, $ch),
            '=' => new Token(TokenKind::Equals, $ch),
            default => new Token(TokenKind::Operator, $ch),
        };
    }
}
