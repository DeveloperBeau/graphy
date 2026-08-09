package cryptobench.ciphers.pearson

import cryptobench.core.HashFunction
import cryptobench.util.Bytes
import cryptobench.util.Rng

/** Pearson hashing over a shuffled permutation table. */
class PearsonHash : HashFunction {
    private val table = buildTable()

    override fun name(): String = "pearson"

    override fun digest(input: String): Long {
        var out = 0L
        for (lane in 0 until 8) {
            var h = lane
            for (b in Bytes.of(input)) {
                h = table[(h xor (b.toInt() and 0xFF)) and 0xFF]
            }
            out = (out shl 8) or h.toLong()
        }
        return out
    }

    private fun buildTable(): IntArray {
        val t = IntArray(256) { it }
        val rng = Rng(0xBADC0DE)
        for (i in 255 downTo 1) {
            val j = rng.nextInt(i + 1)
            t[i] = t[j].also { t[j] = t[i] }
        }
        return t
    }
}
