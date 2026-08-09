package calc.parser

import calc.ast.BinaryExpr
import calc.ast.Expr
import calc.lexer.Token
import calc.lexer.TokenType

final class Parser(tokens: List[Token]) {
  private[parser] val cursor = new TokenCursor(tokens)

  def parseExpression(): Expr = {
    val root = parseBinary(Precedence.Lowest)
    cursor.expect(TokenType.End)
    root
  }

  private[parser] def parseBinary(minPrecedence: Int): Expr = {
    var left = Operands.parsePrimary(this)
    while (Precedence.of(cursor.peek.tokenType) > minPrecedence) {
      val op = cursor.advance()
      left = BinaryExpr(op.text.charAt(0), left, parseBinary(Precedence.nextFor(op.tokenType)))
    }
    left
  }
}
