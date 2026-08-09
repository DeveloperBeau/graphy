package cryptobench.util;

/** xorshift64* generator; deterministic so runs are reproducible. */
public class Rng {
    private long state;

    public Rng(long seed) {
        this.state = seed == 0 ? 0x9E3779B97F4A7C15L : seed;
    }

    public long nextLong() {
        long x = state;
        x ^= x >>> 12;
        x ^= x << 25;
        x ^= x >>> 27;
        state = x;
        return x * 0x2545F4914F6CDD1DL;
    }

    public int nextInt(int bound) {
        return (int) Math.floorMod(nextLong(), bound);
    }
}
