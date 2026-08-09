package cryptobench.ciphers.fletcher

import cryptobench.core.HashFunction
import cryptobench.util.Bytes

/** Fletcher-16 style checksum widened to fit the interface. */
class FletcherHash : HashFunction {

    override fun name(): String = "fletcher"

    override fun digest(input: String): Long {
        var state = 0L
        for (b in Bytes.of(input)) {
            val sum1 = ((state and 0xFFFF) + (b.toLong() and 0xFF)) % 255
            val sum2 = ((state ushr 16) + sum1) % 255
            state = (sum2 shl 16) or sum1
        }
        return state
    }
}
