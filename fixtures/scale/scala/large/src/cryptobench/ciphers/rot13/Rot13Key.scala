package cryptobench.ciphers.rot13

/** Parameters for the rot13 cipher. */
final case class Rot13Key(rounds: Int) {
  def isIdentity: Boolean = rounds % 2 == 0
}

object Rot13Key {
  def default(): Rot13Key = Rot13Key(1)
}
