package calc.lexer

final case class Token(tokenType: TokenType, text: String, position: Int) {

  def numberValue: Double = text.toDouble

  def is(expected: TokenType): Boolean = tokenType == expected

  override def toString: String = tokenType.toString + "(" + text + ")"
}
