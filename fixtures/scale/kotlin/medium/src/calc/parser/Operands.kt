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
internal fun parsePrimary(parser: Parser): Expr {
    val token = parser.cursor.advance()
    return when (token.type) {
        TokenType.NUMBER -> NumberExpr(token.numberValue())
        TokenType.MINUS -> UnaryExpr('-', parsePrimary(parser))
        TokenType.LPAREN -> parser.parseBinary(LOWEST).also { parser.cursor.expect(TokenType.RPAREN) }
        TokenType.IDENTIFIER -> parseName(parser, token)
        else -> throw ParseException("unexpected token '" + token.text + "'")
    }
}

internal fun parseName(parser: Parser, name: Token): Expr {
    val cursor = parser.cursor
    if (cursor.accept(TokenType.LPAREN)) {
        val args = mutableListOf<Expr>()
        while (!cursor.atType(TokenType.RPAREN)) {
            args.add(parser.parseBinary(LOWEST))
            cursor.accept(TokenType.COMMA)
        }
        cursor.advance()
        return CallExpr(name.text, args)
    }
    if (cursor.accept(TokenType.EQUALS)) {
        return AssignExpr(name.text, parser.parseBinary(LOWEST))
    }
    return VariableExpr(name.text)
}
