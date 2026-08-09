package calc.parser

import calc.ast.BinaryExpr
import calc.ast.Expr
import calc.lexer.Token
import calc.lexer.TokenType

class Parser(tokens: List<Token>) {
    internal val cursor = TokenCursor(tokens)

    fun parseExpression(): Expr {
        val root = parseBinary(LOWEST)
        cursor.expect(TokenType.END)
        return root
    }

    internal fun parseBinary(minPrecedence: Int): Expr {
        var left = parsePrimary(this)
        while (precedenceOf(cursor.peek().type) > minPrecedence) {
            val op = cursor.advance()
            left = BinaryExpr(op.text[0], left, parseBinary(nextLevelFor(op.type)))
        }
        return left
    }
}
