package cryptobench.bench;

public class Timer {
    private long startedAt;

    public void start() {
        startedAt = System.nanoTime();
    }

    public long stop() {
        return System.nanoTime() - startedAt;
    }

    public static double toMillis(long nanos) {
        return nanos / 1_000_000.0;
    }
}
