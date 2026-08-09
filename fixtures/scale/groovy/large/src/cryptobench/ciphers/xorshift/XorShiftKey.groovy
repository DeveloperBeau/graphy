package cryptobench.ciphers.xorshift

class XorShiftKey {
    final long seed
    XorShiftKey(long seed) {
        this.seed = seed
    }

    boolean isZeroSeed() {
        return seed == 0
    }

    static XorShiftKey defaultKey() {
        return new XorShiftKey(0x1A2B3C4D)
    }
}
