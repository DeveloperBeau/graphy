package cryptobench.ciphers.sdbm

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** sdbm hash as used by the old sdbm database library. */
final class SdbmHash extends HashFunction {

  override def name: String = "sdbm"

  override def digest(input: String): Long = {
    var state = 0L
    for (b <- Bytes.of(input)) {
      state = (b.toLong & 0xFF) + (state << 6) + (state << 16) - state
    }
    state
  }
}
