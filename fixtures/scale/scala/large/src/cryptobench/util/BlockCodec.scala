package cryptobench.util

/** Big-endian 64-bit block packing shared by the block ciphers. */
object BlockCodec {
  def read(data: Array[Byte], at: Int): Long = {
    var value = 0L
    for (i <- 0 until 8) {
      value = (value << 8) | (data(at + i).toLong & 0xFF)
    }
    value
  }

  def write(data: Array[Byte], at: Int, value: Long): Unit = {
    var v = value
    for (i <- 7 to 0 by -1) {
      data(at + i) = v.toByte
      v = v >>> 8
    }
  }
}
