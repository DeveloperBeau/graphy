package cryptobench.ciphers.crc32

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** Bitwise CRC-32 with the reflected polynomial, no lookup table. */
final class Crc32Hash extends HashFunction {

  override def name: String = "crc32"

  override def digest(input: String): Long = {
    var state = 0xFFFFFFFFL
    for (b <- Bytes.of(input)) {
      state ^= (b.toLong & 0xFF)
      for (_ <- 0 until 8) {
        state = (state >>> 1) ^ (0xEDB88320L & -(state & 1L))
      }
    }
    state ^ 0xFFFFFFFFL
  }
}
