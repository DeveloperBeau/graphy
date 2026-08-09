package cryptobench.ciphers.feistel

class FeistelKey {
    final long master

    FeistelKey(long master) {
        this.master = master
    }

    int subKey(int round) {
        long mixed = master ^ (0x1E3779B9 * (round + 1))
        return (mixed ^ (mixed >>> 32)) as int
    }

    static FeistelKey defaultKey() {
        return new FeistelKey(0x0F1E2D3C)
    }
}
