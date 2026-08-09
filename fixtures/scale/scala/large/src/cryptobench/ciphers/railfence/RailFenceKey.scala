package cryptobench.ciphers.railfence

/** Parameters for the railfence cipher. */
final case class RailFenceKey(rails: Int) {
  def cycleLength: Int = 2 * (rails - 1)
}

object RailFenceKey {
  def default(): RailFenceKey = RailFenceKey(3)
}
