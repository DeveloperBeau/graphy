package calc.history

import scala.collection.mutable.ArrayDeque

final class History(capacity: Int) {
  private val entries = ArrayDeque.empty[HistoryEntry]

  def record(input: String, result: Double): Unit = {
    if (entries.size == capacity) entries.removeHead()
    entries.append(HistoryEntry.now(input, result))
  }

  def recent(count: Int): List[HistoryEntry] =
    entries.takeRight(count).toList

  def size: Int = entries.size
}
