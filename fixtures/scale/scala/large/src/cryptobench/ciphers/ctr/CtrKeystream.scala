package cryptobench.ciphers.ctr

import cryptobench.ciphers.feistel.FeistelNetwork
import cryptobench.util.BlockCodec

/** Generates the counter keystream and xors it over the data. */
private[ctr] object CtrKeystream {
  def mask(network: FeistelNetwork, nonce: Long, data: Array[Byte]): Array[Byte] = {
    val out = new Array[Byte](data.length)
    var off = 0
    while (off < data.length) {
      val counter = new Array[Byte](8)
      BlockCodec.write(counter, 0, nonce + off / 8)
      network.block(counter, 0, reverse = false)
      var i = 0
      while (i < 8 && off + i < data.length) {
        out(off + i) = (data(off + i) ^ counter(i)).toByte
        i += 1
      }
      off += 8
    }
    out
  }
}
