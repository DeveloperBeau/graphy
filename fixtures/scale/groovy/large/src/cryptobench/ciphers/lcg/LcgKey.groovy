package cryptobench.ciphers.lcg

class LcgKey {
    final long seed
    LcgKey(long seed) {
        this.seed = seed
    }

    LcgKey withStride(long stride) {
        return new LcgKey(seed + stride)
    }

    static LcgKey defaultKey() {
        return new LcgKey(0x0DDC0FFE)
    }
}
