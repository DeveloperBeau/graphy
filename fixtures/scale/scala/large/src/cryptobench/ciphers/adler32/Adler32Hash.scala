package cryptobench.ciphers.adler32

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** Adler-32 checksum: parallel sums mod 65521. */
final class Adler32Hash extends HashFunction {

  override def name: String = "adler32"

  override def digest(input: String): Long = {
    var state = 1L
    for (b <- Bytes.of(input)) {
      val high = state >>> 32
      val low = ((state & 0xFFFFFFFFL) + (b.toLong & 0xFF)) % 65521
      state = (((high + low) % 65521) << 32) | low
    }
    ((state >>> 32) << 16) | (state & 0xFFFF)
  }
}
