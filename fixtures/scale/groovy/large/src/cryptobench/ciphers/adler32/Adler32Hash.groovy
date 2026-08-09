package cryptobench.ciphers.adler32

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** Adler-32 checksum: parallel sums mod 65521. */
class Adler32Hash implements HashFunction {
    String name() {
        return "adler32"
    }

    long digest(String input) {
        long state = 1
        Bytes.of(input).each { b ->
            long high = state >>> 32
            long low = ((state & 0xFFFFFFFF) + (b & 0xFF)) % 65521
            state = (((high + low) % 65521) << 32) | low
        }
        return ((state >>> 32) << 16) | (state & 0xFFFF)
    }
}
