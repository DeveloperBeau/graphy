package cryptobench.ciphers.playfair

final case class PlayfairKey(keyword: String) {

  def square: String = {
    val sb = new StringBuilder
    for (c <- keyword.toUpperCase.replace("J", "I") + "ABCDEFGHIKLMNOPQRSTUVWXYZ") {
      if (c >= 'A' && c <= 'Z' && c != 'J' && sb.indexOf(c.toString) < 0) sb.append(c)
    }
    sb.toString
  }
}

object PlayfairKey {
  def default(): PlayfairKey = PlayfairKey("MONARCHY")
}
