package cryptobench.ciphers.adfgvx

/** Substitution between grid cells and ADFGVX symbol pairs. */
private[adfgvx] object AdfgvxSymbols {
  val Symbols = "ADFGVX"

  def substitute(grid: String, text: String): String = {
    val sb = new StringBuilder
    for (c <- text) {
      val at = grid.indexOf(c)
      if (at >= 0) sb.append(Symbols.charAt(at / 6)).append(Symbols.charAt(at % 6))
    }
    sb.toString
  }

  def unsubstitute(grid: String, symbols: String): String = {
    val sb = new StringBuilder
    var i = 0
    while (i + 1 < symbols.length) {
      val row = Symbols.indexOf(symbols.charAt(i))
      val col = Symbols.indexOf(symbols.charAt(i + 1))
      if (row >= 0 && col >= 0) sb.append(grid.charAt(row * 6 + col))
      i += 2
    }
    sb.toString
  }
}
