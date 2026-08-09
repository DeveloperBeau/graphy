package cryptobench.ciphers.autokey

/** Parameters for the autokey cipher. */
final case class AutokeyKey(primer: String) {
  def primerLength: Int = primer.length
}

object AutokeyKey {
  def default(): AutokeyKey = AutokeyKey("EMBER")
}
