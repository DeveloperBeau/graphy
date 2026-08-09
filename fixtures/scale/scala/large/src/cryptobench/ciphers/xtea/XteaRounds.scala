package cryptobench.ciphers.xtea

/** XTEA: TEA with a corrected key schedule mixing. */
private[xtea] object XteaRounds {
  def encryptBlock(block: Long, key: XteaKey): Long = {
    var v0 = (block >>> 32).toInt
    var v1 = block.toInt
    for (r <- 0 until 32) {
      var sum = -0x61c88647 * r
      v0 += (((v1 << 4) ^ (v1 >>> 5)) + v1) ^ (sum + key.k(sum & 3))
      sum += -0x61c88647
      v1 += (((v0 << 4) ^ (v0 >>> 5)) + v0) ^ (sum + key.k((sum >>> 11) & 3))
    }
    pack(v0, v1)
  }

  def decryptBlock(block: Long, key: XteaKey): Long = {
    var v0 = (block >>> 32).toInt
    var v1 = block.toInt
    for (r <- 32 - 1 to 0 by -1) {
      var sum = -0x61c88647 * (r + 1)
      v1 -= (((v0 << 4) ^ (v0 >>> 5)) + v0) ^ (sum + key.k((sum >>> 11) & 3))
      sum -= -0x61c88647
      v0 -= (((v1 << 4) ^ (v1 >>> 5)) + v1) ^ (sum + key.k(sum & 3))
    }
    pack(v0, v1)
  }

  private def pack(v0: Int, v1: Int): Long =
    (v0.toLong << 32) | (v1.toLong & 0xFFFFFFFFL)
}
