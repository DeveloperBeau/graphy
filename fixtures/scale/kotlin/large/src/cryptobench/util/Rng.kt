package cryptobench.util

/** xorshift64* generator; deterministic so runs are reproducible. */
class Rng(seed: Long) {
    private var state: Long = if (seed == 0L) 0x9E3779B97F4A7C15UL.toLong() else seed

    fun nextLong(): Long {
        var x = state
        x = x xor (x ushr 12)
        x = x xor (x shl 25)
        x = x xor (x ushr 27)
        state = x
        return x * 0x2545F4914F6CDD1DUL.toLong()
    }

    fun nextInt(bound: Int): Int = Math.floorMod(nextLong(), bound.toLong()).toInt()
}
