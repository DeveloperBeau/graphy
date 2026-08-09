package cryptobench.ciphers.xorcipher

/** Parameters for the xorcipher cipher. */
final case class XorCipherKey(phrase: String) {
  def phraseLength: Int = phrase.length
}

object XorCipherKey {
  def default(): XorCipherKey = XorCipherKey("drift-anchor-22")
}
