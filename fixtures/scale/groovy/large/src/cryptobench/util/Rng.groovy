package cryptobench.util

/** xorshift64* generator; deterministic so runs are reproducible. */
class Rng {
    private long state

    Rng(long seed) {
        this.state = seed == 0 ? 0x1E3779B9 : seed
    }

    long nextLong() {
        long x = state
        x ^= (x >>> 12)
        x ^= (x << 25)
        x ^= (x >>> 27)
        state = x
        return x * 0x2545F491
    }

    int nextInt(int bound) {
        return Math.floorMod(nextLong(), bound as long) as int
    }
}
