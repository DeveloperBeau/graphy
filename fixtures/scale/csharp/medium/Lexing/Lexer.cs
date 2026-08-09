using System.Text;

namespace Calc.Lexing
{
    public class Lexer
    {
        private readonly ScanCursor _cursor;

        public Lexer(string source)
        {
            _cursor = new ScanCursor(source);
        }

        public Token NextToken()
        {
            while (!_cursor.AtEnd() && char.IsWhiteSpace(_cursor.Peek()))
            {
                _cursor.Advance();
            }
            if (_cursor.AtEnd()) return new Token(TokenKind.End, "");
            var ch = _cursor.Peek();
            if (char.IsDigit(ch)) return ReadWhile(TokenKind.Number, c => char.IsDigit(c) || c == '.');
            if (char.IsLetter(ch)) return ReadWhile(TokenKind.Identifier, char.IsLetter);
            _cursor.Advance();
            if (ch == '(') return new Token(TokenKind.LeftParen, "(");
            if (ch == ')') return new Token(TokenKind.RightParen, ")");
            if (ch == ',') return new Token(TokenKind.Comma, ",");
            if (ch == '=') return new Token(TokenKind.Equals, "=");
            return new Token(TokenKind.Operator, ch.ToString());
        }

        private Token ReadWhile(TokenKind kind, System.Func<char, bool> keep)
        {
            var sb = new StringBuilder();
            while (!_cursor.AtEnd() && keep(_cursor.Peek())) sb.Append(_cursor.Advance());
            return new Token(kind, sb.ToString());
        }
    }
}
