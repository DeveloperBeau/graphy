package cryptobench.ciphers.lcg

/** Parameters for the lcg cipher. */
final case class LcgKey(seed: Long) {
  def withStride(stride: Long): LcgKey = LcgKey(seed + stride)
}

object LcgKey {
  def default(): LcgKey = LcgKey(0x0DDC0FFEEL)
}
