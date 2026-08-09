package cryptobench.ciphers.lcg;

public class LcgKey {
    private final long seed;

    public LcgKey(long seed) {
        this.seed = seed;
    }

    public long getSeed() {
        return seed;
    }

    public static LcgKey defaultKey() {
        return new LcgKey(0x0DDC0FFEEL);
    }
}
