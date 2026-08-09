package calc.parser;

import calc.ast.Expr;
import calc.ast.NumberExpr;
import calc.ast.UnaryExpr;
import calc.errors.ParseException;
import calc.lexer.Token;
import calc.lexer.TokenType;

/** Parses operands: literals, negation, grouped expressions and names. */
class PrimaryParser {
    static Expr parse(Parser parser) {
        TokenCursor cursor = parser.cursor;
        Token token = cursor.advance();
        switch (token.getType()) {
            case NUMBER:
                return new NumberExpr(token.numberValue());
            case MINUS:
                return new UnaryExpr('-', parse(parser));
            case LPAREN:
                Expr inner = parser.parseBinary(Precedence.LOWEST);
                cursor.expect(TokenType.RPAREN);
                return inner;
            case IDENTIFIER:
                return NameParser.parse(parser, token);
            default:
                throw new ParseException("unexpected token '" + token.getText() + "'");
        }
    }
}
