package cryptobench.ciphers.playfair

/** The three Playfair digraph rules: same row, same column, rectangle. */
private[playfair] object PlayfairRules {
  def transform(square: String, pairs: String, step: Int): String = {
    val sb = new StringBuilder
    var i = 0
    while (i + 1 < pairs.length) {
      val a = square.indexOf(pairs.charAt(i))
      val b = square.indexOf(pairs.charAt(i + 1))
      if (a / 5 == b / 5) {
        sb.append(square.charAt(a / 5 * 5 + (a + step) % 5))
        sb.append(square.charAt(b / 5 * 5 + (b + step) % 5))
      } else if (a % 5 == b % 5) {
        sb.append(square.charAt((a + step * 5) % 25 / 5 * 5 + a % 5))
        sb.append(square.charAt((b + step * 5) % 25 / 5 * 5 + b % 5))
      } else {
        sb.append(square.charAt(a / 5 * 5 + b % 5))
        sb.append(square.charAt(b / 5 * 5 + a % 5))
      }
      i += 2
    }
    sb.toString
  }
}
