package cryptobench.core

/**
 * A one-way digest under test. Hash suites verify determinism and check
 * for collisions across the sample corpus instead of round-tripping.
 */
interface HashFunction {
    fun name(): String

    fun digest(input: String): Long
}
