package cryptobench.ciphers.djb2

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** Bernstein's hash: state * 33 + byte. */
class Djb2Hash : HashFunction {

    override fun name(): String = "djb2"

    override fun digest(input: String): Long {
        var state = 5381L
        for (b in Bytes.of(input)) {
            state = ((state shl 5) + state) + (b.toLong() and 0xFF)
        }
        return state
    }
}
