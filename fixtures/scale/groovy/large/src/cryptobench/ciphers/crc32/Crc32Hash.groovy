package cryptobench.ciphers.crc32

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** Bitwise CRC-32 with the reflected polynomial, no lookup table. */
class Crc32Hash implements HashFunction {
    String name() {
        return "crc32"
    }

    long digest(String input) {
        long state = 0xFFFFFFFF
        Bytes.of(input).each { b ->
            state ^= (b & 0xFF)
            for (int bit = 0; bit < 8; bit++) {
                state = (state >>> 1) ^ (0xEDB88320 & -(state & 1))
            }
        }
        return state ^ 0xFFFFFFFF
    }
}
