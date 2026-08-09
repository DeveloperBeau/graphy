package cryptobench.ciphers.beaufort

/** Parameters for the beaufort cipher. */
final case class BeaufortKey(keyword: String) {
  def keyCharAt(position: Int): Char = keyword.charAt(position % keyword.length)
}

object BeaufortKey {
  def default(): BeaufortKey = BeaufortKey("GRANITE")
}
