package cryptobench.ciphers.feistel

import cryptobench.util.BlockCodec

/** Balanced 16-round Feistel permutation over 8-byte blocks. */
final class FeistelNetwork(key: FeistelKey) {

  def block(data: Array[Byte], off: Int, reverse: Boolean): Unit = {
    val packed = BlockCodec.read(data, off)
    var left = (packed >>> 32).toInt
    var right = packed.toInt
    for (r <- 0 until 16) {
      val round = if (reverse) 15 - r else r
      val tmp = right
      right = left ^ roundFn(right, key.subKey(round))
      left = tmp
    }
    BlockCodec.write(data, off, (right.toLong << 32) | (left.toLong & 0xFFFFFFFFL))
  }

  private def roundFn(half: Int, subKey: Int): Int = {
    val mixed = Integer.rotateLeft(half ^ subKey, 5)
    mixed * -0x61c88647 + subKey
  }
}
