package cryptobench.ciphers.crc32

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** Bitwise CRC-32 with the reflected polynomial, no lookup table. */
class Crc32Hash : HashFunction {

    override fun name(): String = "crc32"

    override fun digest(input: String): Long {
        var state = 0xFFFFFFFFL
        for (b in Bytes.of(input)) {
            state = state xor (b.toLong() and 0xFF)
            repeat(8) {
                state = (state ushr 1) xor (0xEDB88320L and -(state and 1L))
            }
        }
        return state xor 0xFFFFFFFFL
    }
}
