package cryptobench.ciphers.railfence

/** Maps character positions onto rails of the zigzag fence. */
internal class RailPattern(private val rails: Int) {

    fun railCount(): Int = rails

    fun railFor(index: Int): Int {
        val cycle = 2 * (rails - 1)
        val pos = index % cycle
        return if (pos < rails) pos else cycle - pos
    }
}
