package cryptobench.core

/**
 * A one-way digest under test. Hash suites verify determinism and check
 * for collisions across the sample corpus instead of round-tripping.
 */
trait HashFunction {
  def name: String

  def digest(input: String): Long
}
