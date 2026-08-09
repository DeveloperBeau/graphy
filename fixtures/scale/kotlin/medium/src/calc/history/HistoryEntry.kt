package calc.history

import java.time.Instant

data class HistoryEntry(
    val input: String,
    val result: Double,
    val at: Instant = Instant.now(),
) {
    fun summary(): String = input + " = " + result
}
