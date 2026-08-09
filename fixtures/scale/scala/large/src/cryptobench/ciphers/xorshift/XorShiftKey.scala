package cryptobench.ciphers.xorshift

/** Parameters for the xorshift cipher. */
final case class XorShiftKey(seed: Long) {
  def isZeroSeed: Boolean = seed == 0L
}

object XorShiftKey {
  def default(): XorShiftKey = XorShiftKey(0x1A2B3C4D5E6FL)
}
