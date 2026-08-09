using Calc.Ast;
using Calc.Lexing;

namespace Calc.Parsing
{
    public partial class Parser
    {
        private readonly TokenStream _stream;

        public Parser(string source)
        {
            _stream = new TokenStream(source);
        }

        public Node ParseStatement()
        {
            if (_stream.LooksLikeAssignment())
            {
                var name = _stream.Advance().Text;
                _stream.Advance();
                return new Assignment(name, ParseExpression(1));
            }
            return ParseExpression(1);
        }

        private Node ParseExpression(int minPrecedence)
        {
            var left = ParsePrimary();
            while (_stream.Current().Kind == TokenKind.Operator
                   && Precedence.Of(_stream.Current().Text) >= minPrecedence)
            {
                var op = _stream.Advance().Text;
                var next = Precedence.RightAssociative(op) ? Precedence.Of(op) : Precedence.Of(op) + 1;
                left = new BinaryOp(op, left, ParseExpression(next));
            }
            return left;
        }
    }
}
