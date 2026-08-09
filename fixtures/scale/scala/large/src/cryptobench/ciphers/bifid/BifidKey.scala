package cryptobench.ciphers.bifid

/** Parameters for the bifid cipher. */
final case class BifidKey(seedWord: String) {
  def seedLength: Int = seedWord.length
}

object BifidKey {
  def default(): BifidKey = BifidKey("CIPHER")
}
