package cryptobench.bench

class Timer {
    private long startedAt

    void start() {
        startedAt = System.nanoTime()
    }

    long stop() {
        return System.nanoTime() - startedAt
    }

    static double toMillis(long nanos) {
        return nanos / 1000000.0
    }
}
