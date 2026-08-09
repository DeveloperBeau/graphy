package cryptobench.ciphers.djb2

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** Bernstein's hash: state * 33 + byte. */
class Djb2Hash implements HashFunction {
    String name() {
        return "djb2"
    }

    long digest(String input) {
        long state = 5381
        Bytes.of(input).each { b ->
            state = ((state << 5) + state) + (b & 0xFF)
        }
        return state
    }
}
