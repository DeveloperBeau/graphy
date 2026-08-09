package cryptobench.ciphers.fnv1a

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** FNV-1a 64-bit: xor the byte, multiply by the prime. */
class Fnv1aHash : HashFunction {

    override fun name(): String = "fnv1a"

    override fun digest(input: String): Long {
        var state = -0x340d631b7bdddcdbL
        for (b in Bytes.of(input)) {
            state = state xor (b.toLong() and 0xFF)
            state *= 0x100000001B3L
        }
        return state
    }
}
