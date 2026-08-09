package cryptobench.ciphers.adfgvx

final case class AdfgvxKey(seedWord: String, transpositionWord: String) {

  /** 36-cell grid of letters and digits, seed word first. */
  def grid: String = {
    val sb = new StringBuilder
    for (c <- seedWord.toUpperCase + "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") {
      if (sb.indexOf(c.toString) < 0) sb.append(c)
    }
    sb.toString
  }
}

object AdfgvxKey {
  def default(): AdfgvxKey = AdfgvxKey("NIGHTMARE", "GERMAN")
}
