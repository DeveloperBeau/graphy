package cryptobench.ciphers.adler32

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** Adler-32 checksum: parallel sums mod 65521. */
class Adler32Hash : HashFunction {

    override fun name(): String = "adler32"

    override fun digest(input: String): Long {
        var state = 1L
        for (b in Bytes.of(input)) {
            val high = state ushr 32
            val low = ((state and 0xFFFFFFFFL) + (b.toLong() and 0xFF)) % 65521
            state = (((high + low) % 65521) shl 32) or low
        }
        return ((state ushr 32) shl 16) or (state and 0xFFFF)
    }
}
