package cryptobench.ciphers.tea

/** Tiny Encryption Algorithm with the classic 32-cycle schedule. */
private[tea] object TeaRounds {
  def encryptBlock(block: Long, key: TeaKey): Long = {
    var v0 = (block >>> 32).toInt
    var v1 = block.toInt
    for (r <- 0 until 32) {
      val sum = -0x61c88647 * (r + 1)
      v0 += ((v1 << 4) + key.k0) ^ (v1 + sum) ^ ((v1 >>> 5) + key.k1)
      v1 += ((v0 << 4) + key.k2) ^ (v0 + sum) ^ ((v0 >>> 5) + key.k3)
    }
    pack(v0, v1)
  }

  def decryptBlock(block: Long, key: TeaKey): Long = {
    var v0 = (block >>> 32).toInt
    var v1 = block.toInt
    for (r <- 32 - 1 to 0 by -1) {
      val sum = -0x61c88647 * (r + 1)
      v1 -= ((v0 << 4) + key.k2) ^ (v0 + sum) ^ ((v0 >>> 5) + key.k3)
      v0 -= ((v1 << 4) + key.k0) ^ (v1 + sum) ^ ((v1 >>> 5) + key.k1)
    }
    pack(v0, v1)
  }

  private def pack(v0: Int, v1: Int): Long =
    (v0.toLong << 32) | (v1.toLong & 0xFFFFFFFFL)
}
