<?php

namespace Calc\Lexing;

enum TokenKind
{
    case Number;
    case Identifier;
    case Operator;
    case LeftParen;
    case RightParen;
    case Comma;
    case Equals;
    case End;
}
