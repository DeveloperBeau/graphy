package cryptobench.ciphers.caesar

/** Parameters for the caesar cipher. */
final case class CaesarKey(shift: Int) {
  def normalized: CaesarKey = CaesarKey(((shift % 26) + 26) % 26)
}

object CaesarKey {
  def default(): CaesarKey = CaesarKey(7)
}
