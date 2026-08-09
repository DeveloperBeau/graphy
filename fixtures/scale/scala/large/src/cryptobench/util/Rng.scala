package cryptobench.util

/** xorshift64* generator; deterministic so runs are reproducible. */
final class Rng(seed: Long) {
  private var state: Long = if (seed == 0L) 0x9E3779B97F4A7C15L else seed

  def nextLong(): Long = {
    var x = state
    x ^= x >>> 12
    x ^= x << 25
    x ^= x >>> 27
    state = x
    x * 0x2545F4914F6CDD1DL
  }

  def nextInt(bound: Int): Int = Math.floorMod(nextLong(), bound.toLong).toInt
}
