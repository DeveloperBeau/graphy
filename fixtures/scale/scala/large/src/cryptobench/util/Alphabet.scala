package cryptobench.util

object Alphabet {
  val Size = 26

  def isUpper(c: Char): Boolean = c >= 'A' && c <= 'Z'

  def indexOf(c: Char): Int = c - 'A'

  def charAt(index: Int): Char = ('A' + Math.floorMod(index, Size)).toChar

  def clean(text: String): String =
    text.toUpperCase.filter(isUpper)
}
