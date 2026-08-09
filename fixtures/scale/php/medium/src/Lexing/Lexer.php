<?php

namespace Calc\Lexing;

require_once __DIR__ . '/ScanCursor.php';
require_once __DIR__ . '/Token.php';
require_once __DIR__ . '/TokenKind.php';
require_once __DIR__ . '/SymbolTokens.php';

class Lexer
{
    private ScanCursor $cursor;

    public function __construct(string $source)
    {
        $this->cursor = new ScanCursor($source);
    }

    public function nextToken(): Token
    {
        while (!$this->cursor->atEnd() && ctype_space($this->cursor->peek())) { $this->cursor->advance(); }
        if ($this->cursor->atEnd()) { return new Token(TokenKind::End, ''); }
        $ch = $this->cursor->peek();
        if (ctype_digit($ch)) { return $this->readWhile(TokenKind::Number, fn ($c) => ctype_digit($c) || $c === '.'); }
        if (ctype_alpha($ch)) { return $this->readWhile(TokenKind::Identifier, fn ($c) => ctype_alpha($c)); }
        $this->cursor->advance();
        return SymbolTokens::tokenFor($ch);
    }

    private function readWhile(TokenKind $kind, callable $keep): Token
    {
        $text = '';
        while (!$this->cursor->atEnd() && $keep($this->cursor->peek())) { $text .= $this->cursor->advance(); }
        return new Token($kind, $text);
    }
}
