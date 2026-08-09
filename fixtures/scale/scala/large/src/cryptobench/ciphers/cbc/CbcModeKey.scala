package cryptobench.ciphers.cbc

final case class CbcModeKey(blockKey: Long) {

  def iv: Array[Byte] = {
    val out = new Array[Byte](8)
    var v = blockKey * -0x61c8864680b583ebL
    for (i <- 7 to 0 by -1) {
      out(i) = v.toByte
      v = v >>> 8
    }
    out
  }
}

object CbcModeKey {
  def default(): CbcModeKey = CbcModeKey(0x5115ABEDCAFED00DL)
}
