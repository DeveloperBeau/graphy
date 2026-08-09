package cryptobench.ciphers.feistel

final case class FeistelKey(master: Long) {

  def subKey(round: Int): Int = {
    val mixed = master ^ (-0x61c8864680b583ebL * (round + 1))
    (mixed ^ (mixed >>> 32)).toInt
  }
}

object FeistelKey {
  def default(): FeistelKey = FeistelKey(0x0F1E2D3C4B5A6978L)
}
