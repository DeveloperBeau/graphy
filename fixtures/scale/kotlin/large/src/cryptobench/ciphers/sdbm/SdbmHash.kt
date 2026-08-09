package cryptobench.ciphers.sdbm

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** sdbm hash as used by the old sdbm database library. */
class SdbmHash : HashFunction {

    override fun name(): String = "sdbm"

    override fun digest(input: String): Long {
        var state = 0L
        for (b in Bytes.of(input)) {
            state = (b.toLong() and 0xFF) + (state shl 6) + (state shl 16) - state
        }
        return state
    }
}
