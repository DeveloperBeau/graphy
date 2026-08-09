package calc.lexer

object Symbols {
  def typeOf(c: Char): Option[TokenType] = c match {
    case '+' => Some(TokenType.Plus)
    case '-' => Some(TokenType.Minus)
    case '*' => Some(TokenType.Star)
    case '/' => Some(TokenType.Slash)
    case '^' => Some(TokenType.Caret)
    case '%' => Some(TokenType.Percent)
    case '(' => Some(TokenType.LParen)
    case ')' => Some(TokenType.RParen)
    case ',' => Some(TokenType.Comma)
    case '=' => Some(TokenType.Equals)
    case _   => None
  }
}
