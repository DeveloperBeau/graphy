package cryptobench.ciphers.djb2

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** Bernstein's hash: state * 33 + byte. */
final class Djb2Hash extends HashFunction {

  override def name: String = "djb2"

  override def digest(input: String): Long = {
    var state = 5381L
    for (b <- Bytes.of(input)) {
      state = ((state << 5) + state) + (b.toLong & 0xFF)
    }
    state
  }
}
