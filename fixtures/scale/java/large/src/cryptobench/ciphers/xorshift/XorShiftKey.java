package cryptobench.ciphers.xorshift;

public class XorShiftKey {
    private final long seed;

    public XorShiftKey(long seed) {
        this.seed = seed;
    }

    public long getSeed() {
        return seed;
    }

    public static XorShiftKey defaultKey() {
        return new XorShiftKey(0x1A2B3C4D5E6FL);
    }
}
