package cryptobench.ciphers.simon

/** Simon64-style Feistel rounds built from AND, rotate and xor. */
private[simon] object SimonRounds {
  def encryptBlock(block: Long, key: SimonKey): Long = {
    var v0 = (block >>> 32).toInt
    var v1 = block.toInt
    for (r <- 0 until 32) {
      val tmp = v0
      v0 = v1 ^ (Integer.rotateLeft(v0, 1) & Integer.rotateLeft(v0, 8)) ^ Integer.rotateLeft(v0, 2) ^ key.k(r & 3)
      v1 = tmp
    }
    pack(v0, v1)
  }

  def decryptBlock(block: Long, key: SimonKey): Long = {
    var v0 = (block >>> 32).toInt
    var v1 = block.toInt
    for (r <- 32 - 1 to 0 by -1) {
      val tmp = v1
      v1 = v0 ^ (Integer.rotateLeft(v1, 1) & Integer.rotateLeft(v1, 8)) ^ Integer.rotateLeft(v1, 2) ^ key.k(r & 3)
      v0 = tmp
    }
    pack(v0, v1)
  }

  private def pack(v0: Int, v1: Int): Long =
    (v0.toLong << 32) | (v1.toLong & 0xFFFFFFFFL)
}
