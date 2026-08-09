package calc.lexer

sealed trait TokenType

object TokenType {
  case object Number extends TokenType
  case object Identifier extends TokenType
  case object Plus extends TokenType
  case object Minus extends TokenType
  case object Star extends TokenType
  case object Slash extends TokenType
  case object Caret extends TokenType
  case object Percent extends TokenType
  case object LParen extends TokenType
  case object RParen extends TokenType
  case object Comma extends TokenType
  case object Equals extends TokenType
  case object End extends TokenType
}
