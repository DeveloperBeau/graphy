package cryptobench.ciphers.playfair

/** Splits cleaned text into Playfair digraphs, breaking doubles with X. */
object PlayfairDigraphs {
  def split(text: String): String = {
    val folded = text.replace('J', 'I')
    val sb = new StringBuilder
    var i = 0
    while (i < folded.length) {
      val first = folded.charAt(i)
      sb.append(first)
      if (i + 1 < folded.length && folded.charAt(i + 1) != first) {
        sb.append(folded.charAt(i + 1))
        i += 2
      } else {
        sb.append(if (first == 'X') 'Q' else 'X')
        i += 1
      }
    }
    sb.toString
  }
}
