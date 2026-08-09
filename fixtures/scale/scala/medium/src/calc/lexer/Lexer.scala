package calc.lexer

import scala.collection.mutable.ListBuffer

import calc.errors.LexException

final class Lexer(source: String) {
  private val stream = new CharStream(source)

  def tokenize(): List[Token] = {
    val tokens = ListBuffer.empty[Token]
    stream.skipWhitespace()
    while (stream.hasNext) {
      val at = stream.position
      val c = stream.peek
      if (c.isDigit || c == '.') {
        tokens += Token(TokenType.Number, stream.takeWhile(x => x.isDigit || x == '.'), at)
      } else if (c.isLetter) {
        tokens += Token(TokenType.Identifier, stream.takeWhile(_.isLetterOrDigit), at)
      } else {
        Symbols.typeOf(stream.next()) match {
          case Some(tokenType) => tokens += Token(tokenType, c.toString, at)
          case None => throw new LexException("unexpected character '" + c + "' at " + at)
        }
      }
      stream.skipWhitespace()
    }
    tokens += Token(TokenType.End, "", stream.position)
    tokens.toList
  }
}
