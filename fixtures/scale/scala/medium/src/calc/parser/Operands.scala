package calc.parser

import scala.collection.mutable.ListBuffer

import calc.ast._
import calc.errors.ParseException
import calc.lexer.Token
import calc.lexer.TokenType

/** Parses operands: literals, negation, grouping, calls, assignments, names. */
private[parser] object Operands {
  def parsePrimary(parser: Parser): Expr = {
    val token = parser.cursor.advance()
    token.tokenType match {
      case TokenType.Number => NumberExpr(token.numberValue)
      case TokenType.Minus  => UnaryExpr('-', parsePrimary(parser))
      case TokenType.LParen =>
        val inner = parser.parseBinary(Precedence.Lowest)
        parser.cursor.expect(TokenType.RParen)
        inner
      case TokenType.Identifier => parseName(parser, token)
      case _ => throw new ParseException("unexpected token '" + token.text + "'")
    }
  }

  def parseName(parser: Parser, name: Token): Expr = {
    val cursor = parser.cursor
    if (cursor.accept(TokenType.LParen)) {
      val args = ListBuffer.empty[Expr]
      while (!cursor.atType(TokenType.RParen)) {
        args += parser.parseBinary(Precedence.Lowest)
        cursor.accept(TokenType.Comma)
      }
      cursor.advance()
      CallExpr(name.text, args.toList)
    } else if (cursor.accept(TokenType.Equals)) {
      AssignExpr(name.text, parser.parseBinary(Precedence.Lowest))
    } else VariableExpr(name.text)
  }
}
