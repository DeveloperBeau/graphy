package calc.history

private const val DEFAULT_COUNT = 10

fun formatHistory(history: History): String =
    formatRecent(history, DEFAULT_COUNT)

fun formatRecent(history: History, count: Int): String {
    val lines = history.recent(count).map { it.summary() }
    return if (lines.isEmpty()) "(empty)" else lines.joinToString("\n")
}
