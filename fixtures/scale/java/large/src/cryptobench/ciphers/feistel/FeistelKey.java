package cryptobench.ciphers.feistel;

public class FeistelKey {
    private final long master;

    public FeistelKey(long master) {
        this.master = master;
    }

    public int subKey(int round) {
        long mixed = master ^ (0x9E3779B97F4A7C15L * (round + 1));
        return (int) (mixed ^ (mixed >>> 32));
    }

    public static FeistelKey defaultKey() {
        return new FeistelKey(0x0F1E2D3C4B5A6978L);
    }
}
