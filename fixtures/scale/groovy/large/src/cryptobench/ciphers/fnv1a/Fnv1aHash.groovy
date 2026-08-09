package cryptobench.ciphers.fnv1a

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** FNV-1a 64-bit: xor the byte, multiply by the prime. */
class Fnv1aHash implements HashFunction {
    String name() {
        return "fnv1a"
    }

    long digest(String input) {
        long state = 0x1BF29CE4
        Bytes.of(input).each { b ->
            state ^= (b & 0xFF)
            state *= 0x100000001B3
        }
        return state
    }
}
