package cryptobench.ciphers.speck;

public class SpeckKey {
    private final int[] words;

    public SpeckKey(int k0, int k1, int k2, int k3) {
        this.words = new int[] { k0, k1, k2, k3 };
    }

    public int k(int index) {
        return words[index & 3];
    }

    public static SpeckKey defaultKey() {
        return new SpeckKey(0x0123_4567, 0x89AB_CDEF, 0xFEDC_BA98, 0x7654_3210);
    }
}
