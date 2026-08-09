package cryptobench.ciphers.keywordsub

final case class KeywordSubKey(keyword: String) {

  /** Keyword first (duplicates dropped), then the remaining letters in order. */
  def mixedAlphabet: String = {
    val sb = new StringBuilder
    for (c <- keyword.toUpperCase + "ABCDEFGHIJKLMNOPQRSTUVWXYZ") {
      if (c >= 'A' && c <= 'Z' && sb.indexOf(c.toString) < 0) sb.append(c)
    }
    sb.toString
  }
}

object KeywordSubKey {
  def default(): KeywordSubKey = KeywordSubKey("OBSIDIAN")
}
