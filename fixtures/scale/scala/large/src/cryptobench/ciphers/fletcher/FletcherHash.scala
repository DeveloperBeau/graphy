package cryptobench.ciphers.fletcher

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** Fletcher-16 style checksum widened to fit the interface. */
final class FletcherHash extends HashFunction {

  override def name: String = "fletcher"

  override def digest(input: String): Long = {
    var state = 0L
    for (b <- Bytes.of(input)) {
      val sum1 = ((state & 0xFFFF) + (b.toLong & 0xFF)) % 255
      val sum2 = ((state >>> 16) + sum1) % 255
      state = (sum2 << 16) | sum1
    }
    state
  }
}
