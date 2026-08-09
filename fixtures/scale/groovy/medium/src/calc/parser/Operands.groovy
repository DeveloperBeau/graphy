package calc.parser

import calc.ast.AssignExpr
import calc.ast.CallExpr
import calc.ast.Expr
import calc.ast.NumberExpr
import calc.ast.UnaryExpr
import calc.ast.VariableExpr
import calc.errors.ParseException
import calc.lexer.Token
import calc.lexer.TokenType

/** Parses operands: literals, negation, grouping, calls, assignments, names. */
class Operands {
    static Expr parsePrimary(Parser parser) {
        TokenCursor cursor = parser.cursor
        Token token = cursor.advance()
        switch (token.type) {
            case TokenType.NUMBER: return new NumberExpr(token.numberValue())
            case TokenType.MINUS: return new UnaryExpr('-' as char, parsePrimary(parser))
            case TokenType.LPAREN:
                Expr inner = parser.parseBinary(Precedence.LOWEST)
                cursor.expect(TokenType.RPAREN)
                return inner
            case TokenType.IDENTIFIER: return parseName(parser, token)
            default: throw new ParseException("unexpected token '" + token.text + "'")
        }
    }
    static Expr parseName(Parser parser, Token name) {
        TokenCursor cursor = parser.cursor
        if (!cursor.accept(TokenType.LPAREN)) {
            return cursor.accept(TokenType.EQUALS) ? new AssignExpr(name.text, parser.parseBinary(Precedence.LOWEST)) : new VariableExpr(name.text)
        }
        List<Expr> args = []
        while (!cursor.atType(TokenType.RPAREN)) { args << parser.parseBinary(Precedence.LOWEST); cursor.accept(TokenType.COMMA) }
        cursor.advance()
        return new CallExpr(name.text, args)
    }
}
