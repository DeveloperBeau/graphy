package calc.parser

import calc.errors.ParseException
import calc.lexer.Token
import calc.lexer.TokenType

final class TokenCursor(tokens: List[Token]) {
  private var index = 0

  def peek: Token = tokens(index)

  def advance(): Token = { val t = tokens(index); index += 1; t }

  def atType(tokenType: TokenType): Boolean = peek.tokenType == tokenType

  def accept(tokenType: TokenType): Boolean =
    if (atType(tokenType)) { index += 1; true } else false

  def expect(tokenType: TokenType): Unit =
    if (advance().tokenType != tokenType)
      throw new ParseException("expected " + tokenType)
}
