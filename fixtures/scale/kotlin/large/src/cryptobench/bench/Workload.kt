package cryptobench.bench

import cryptobench.util.Rng

/** Deterministic plaintext payloads used to size benchmark iterations. */
object Workload {
    fun payloads(count: Int): List<String> {
        val rng = Rng(0x5EED)
        return (0 until count).map { randomSentence(rng, 8 + (it % 24)) }
    }

    internal fun randomSentence(rng: Rng, words: Int): String {
        val sb = StringBuilder()
        for (w in 0 until words) {
            if (w > 0) sb.append(' ')
            val len = 3 + rng.nextInt(7)
            repeat(len) { sb.append('A' + rng.nextInt(26)) }
        }
        return sb.toString()
    }
}
