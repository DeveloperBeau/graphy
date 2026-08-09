package calc.history

object HistoryFormatter {
  private val DefaultCount = 10

  def format(history: History): String = formatRecent(history, DefaultCount)

  def formatRecent(history: History, count: Int): String = {
    val lines = history.recent(count).map(_.summary)
    if (lines.isEmpty) "(empty)" else lines.mkString("\n")
  }
}
