package calc.parser

import calc.ast.BinaryExpr
import calc.ast.Expr
import calc.lexer.Token
import calc.lexer.TokenType

class Parser {
    final TokenCursor cursor

    Parser(List<Token> tokens) {
        this.cursor = new TokenCursor(tokens)
    }

    Expr parseExpression() {
        Expr root = parseBinary(Precedence.LOWEST)
        cursor.expect(TokenType.END)
        return root
    }

    Expr parseBinary(int minPrecedence) {
        Expr left = Operands.parsePrimary(this)
        while (Precedence.of(cursor.peek().type) > minPrecedence) {
            Token op = cursor.advance()
            left = new BinaryExpr(op.text.charAt(0), left, parseBinary(Precedence.nextFor(op.type)))
        }
        return left
    }
}
