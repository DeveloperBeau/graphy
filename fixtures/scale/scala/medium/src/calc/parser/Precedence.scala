package calc.parser

import calc.lexer.TokenType

object Precedence {
  val Lowest = 0

  def of(tokenType: TokenType): Int = tokenType match {
    case TokenType.Plus | TokenType.Minus                    => 10
    case TokenType.Star | TokenType.Slash | TokenType.Percent => 20
    case TokenType.Caret                                     => 30
    case _                                                   => Lowest
  }

  def rightAssociative(tokenType: TokenType): Boolean =
    tokenType == TokenType.Caret

  /** The minimum precedence for the right-hand side of the given operator. */
  def nextFor(tokenType: TokenType): Int =
    if (rightAssociative(tokenType)) of(tokenType) - 1 else of(tokenType)
}
