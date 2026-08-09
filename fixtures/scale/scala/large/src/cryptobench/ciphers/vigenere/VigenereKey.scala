package cryptobench.ciphers.vigenere

/** Parameters for the vigenere cipher. */
final case class VigenereKey(keyword: String) {
  def keyCharAt(position: Int): Char = keyword.charAt(position % keyword.length)
}

object VigenereKey {
  def default(): VigenereKey = VigenereKey("LANTERN")
}
