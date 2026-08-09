<?php

namespace Calc\Parsing;

use Calc\Ast\Assignment;
use Calc\Ast\Node;
use Calc\Lexing\TokenKind;

require_once __DIR__ . '/TokenStream.php';
require_once __DIR__ . '/Precedence.php';
require_once __DIR__ . '/ParserPrimary.php';
require_once __DIR__ . '/ParserExpression.php';

class Parser
{
    use ParserPrimary;
    use ParserExpression;

    private TokenStream $stream;

    public function __construct(string $source)
    {
        $this->stream = new TokenStream($source);
    }

    public function parseStatement(): Node
    {
        if ($this->stream->looksLikeAssignment()) {
            $name = $this->stream->advance()->text;
            $this->stream->advance();
            return new Assignment($name, $this->parseExpression(1));
        }
        return $this->parseExpression(1);
    }
}
