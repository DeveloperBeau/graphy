package cryptobench.ciphers.tea;

public class TeaKey {
    private final int[] words;

    public TeaKey(int k0, int k1, int k2, int k3) {
        this.words = new int[] { k0, k1, k2, k3 };
    }

    public int k(int index) {
        return words[index & 3];
    }

    public static TeaKey defaultKey() {
        return new TeaKey(0x0123_4567, 0x89AB_CDEF, 0xFEDC_BA98, 0x7654_3210);
    }
}
