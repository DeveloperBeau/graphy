package calc.history

import java.time.Instant

final case class HistoryEntry(input: String, result: Double, at: Instant) {

  def summary: String = input + " = " + result
}

object HistoryEntry {
  def now(input: String, result: Double): HistoryEntry =
    HistoryEntry(input, result, Instant.now())
}
