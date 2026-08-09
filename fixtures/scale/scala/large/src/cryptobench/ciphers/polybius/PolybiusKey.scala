package cryptobench.ciphers.polybius

final case class PolybiusKey(seedWord: String) {

  /** 25-letter square: seed word first, then the rest of the alphabet minus J. */
  def square: String = {
    val sb = new StringBuilder
    for (c <- seedWord.toUpperCase.replace("J", "I") + "ABCDEFGHIKLMNOPQRSTUVWXYZ") {
      if (c >= 'A' && c <= 'Z' && c != 'J' && sb.indexOf(c.toString) < 0) sb.append(c)
    }
    sb.toString
  }
}

object PolybiusKey {
  def default(): PolybiusKey = PolybiusKey("HARBOR")
}
