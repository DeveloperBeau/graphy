package cryptobench.ciphers.cbc

import cryptobench.ciphers.feistel.FeistelNetwork

/** Applies CBC chaining around the Feistel block permutation. */
private[cbc] object CbcChain {
  def encrypt(network: FeistelNetwork, data: Array[Byte], chain: Array[Byte]): Unit = {
    var off = 0
    while (off < data.length) {
      for (i <- 0 until 8) data(off + i) = (data(off + i) ^ chain(i)).toByte
      network.block(data, off, reverse = false)
      System.arraycopy(data, off, chain, 0, 8)
      off += 8
    }
  }

  def decrypt(network: FeistelNetwork, data: Array[Byte], chain: Array[Byte]): Unit = {
    var off = 0
    while (off < data.length) {
      val next = java.util.Arrays.copyOfRange(data, off, off + 8)
      network.block(data, off, reverse = true)
      for (i <- 0 until 8) data(off + i) = (data(off + i) ^ chain(i)).toByte
      System.arraycopy(next, 0, chain, 0, 8)
      off += 8
    }
  }
}
