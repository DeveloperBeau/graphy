package cryptobench.ciphers.fnv1a

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** FNV-1a 64-bit: xor the byte, multiply by the prime. */
final class Fnv1aHash extends HashFunction {

  override def name: String = "fnv1a"

  override def digest(input: String): Long = {
    var state = -0x340d631b7bdddcdbL
    for (b <- Bytes.of(input)) {
      state ^= (b.toLong & 0xFF)
      state *= 0x100000001B3L
    }
    state
  }
}
