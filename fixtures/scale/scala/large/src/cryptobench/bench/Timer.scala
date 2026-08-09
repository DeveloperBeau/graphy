package cryptobench.bench

final class Timer {
  private var startedAt = 0L

  def start(): Unit = startedAt = System.nanoTime()

  def stop(): Long = System.nanoTime() - startedAt
}

object Timer {
  def toMillis(nanos: Long): Double = nanos / 1000000.0
}
