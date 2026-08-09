package cryptobench.ciphers.speck

/** Speck64-style ARX rounds: rotate, add, xor. */
private[speck] object SpeckRounds {
  def encryptBlock(block: Long, key: SpeckKey): Long = {
    var v0 = (block >>> 32).toInt
    var v1 = block.toInt
    for (r <- 0 until 27) {
      v0 = (Integer.rotateRight(v0, 8) + v1) ^ key.k(r & 3)
      v1 = Integer.rotateLeft(v1, 3) ^ v0
    }
    pack(v0, v1)
  }

  def decryptBlock(block: Long, key: SpeckKey): Long = {
    var v0 = (block >>> 32).toInt
    var v1 = block.toInt
    for (r <- 27 - 1 to 0 by -1) {
      v1 = Integer.rotateRight(v1 ^ v0, 3)
      v0 = Integer.rotateLeft((v0 ^ key.k(r & 3)) - v1, 8)
    }
    pack(v0, v1)
  }

  private def pack(v0: Int, v1: Int): Long =
    (v0.toLong << 32) | (v1.toLong & 0xFFFFFFFFL)
}
