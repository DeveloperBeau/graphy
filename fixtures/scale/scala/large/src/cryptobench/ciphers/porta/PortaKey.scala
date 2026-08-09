package cryptobench.ciphers.porta

/** Parameters for the porta cipher. */
final case class PortaKey(keyword: String) {
  def keyCharAt(position: Int): Char = keyword.charAt(position % keyword.length)
}

object PortaKey {
  def default(): PortaKey = PortaKey("MERIDIAN")
}
