package cryptobench.ciphers.railfence

/** Maps character positions onto rails of the zigzag fence. */
private[railfence] final class RailPattern(rails: Int) {

  def railCount: Int = rails

  def railFor(index: Int): Int = {
    val cycle = 2 * (rails - 1)
    val pos = index % cycle
    if (pos < rails) pos else cycle - pos
  }
}
