using System.Collections.Generic;
using Calc.Lexing;

namespace Calc.Parsing
{
    public class TokenStream
    {
        private readonly List<Token> _tokens = new List<Token>();
        private int _index;

        public TokenStream(string source)
        {
            var lexer = new Lexer(source);
            Token token;
            do
            {
                token = lexer.NextToken();
                _tokens.Add(token);
            } while (token.Kind != TokenKind.End);
        }

        public Token Current()
        {
            return _tokens[_index < _tokens.Count ? _index : _tokens.Count - 1];
        }

        public Token Advance()
        {
            var token = Current();
            _index++;
            return token;
        }

        public bool LooksLikeAssignment()
        {
            return _tokens.Count > 2 && _tokens[0].Kind == TokenKind.Identifier
                && _tokens[1].Kind == TokenKind.Equals;
        }
    }
}
