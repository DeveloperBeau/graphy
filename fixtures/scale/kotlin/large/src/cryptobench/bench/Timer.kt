package cryptobench.bench

class Timer {
    private var startedAt = 0L

    fun start() {
        startedAt = System.nanoTime()
    }

    fun stop(): Long = System.nanoTime() - startedAt

    companion object {
        fun toMillis(nanos: Long): Double = nanos / 1_000_000.0
    }
}
