using System.Collections.Generic;
using Calc.Ast;
using Calc.Lexing;

namespace Calc.Parsing
{
    public partial class Parser
    {
        private Node ParsePrimary()
        {
            var token = _stream.Advance();
            if (token.Kind == TokenKind.Number) return new NumberLiteral(token.NumberValue());
            if (token.Kind == TokenKind.Operator && token.Text == "-") return new UnaryOp("-", ParsePrimary());
            if (token.Kind == TokenKind.LeftParen)
            {
                var inner = ParseExpression(1);
                _stream.Advance();
                return inner;
            }
            if (token.Kind == TokenKind.Identifier && _stream.Current().Kind == TokenKind.LeftParen)
            {
                return new FunctionCall(token.Text, ParseArguments());
            }
            return new VariableRef(token.Text);
        }

        private List<Node> ParseArguments()
        {
            _stream.Advance();
            var arguments = new List<Node> { ParseExpression(1) };
            while (_stream.Current().Kind == TokenKind.Comma)
            {
                _stream.Advance();
                arguments.Add(ParseExpression(1));
            }
            _stream.Advance();
            return arguments;
        }
    }
}
