package calc.lexer

final class CharStream(source: String) {
  private var index = 0

  def hasNext: Boolean = index < source.length

  def peek: Char = source.charAt(index)

  def next(): Char = { val c = source.charAt(index); index += 1; c }

  def position: Int = index

  def skipWhitespace(): Unit =
    while (hasNext && peek.isWhitespace) index += 1

  def takeWhile(accept: Char => Boolean): String = {
    val sb = new StringBuilder
    while (hasNext && accept(peek)) sb.append(next())
    sb.toString
  }
}
