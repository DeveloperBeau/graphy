package cryptobench.ciphers.xtea

class XteaKey {
    final int k0
    final int k1
    final int k2
    final int k3

    XteaKey(int k0, int k1, int k2, int k3) {
        this.k0 = k0
        this.k1 = k1
        this.k2 = k2
        this.k3 = k3
    }

    int k(int index) {
        switch (index & 3) {
            case 0: return k0
            case 1: return k1
            case 2: return k2
            default: return k3
        }
    }

    static XteaKey defaultKey() {
        return new XteaKey(0x01234567, 0x1A2B3C4D, 0x1234568, 0x76543210)
    }
}
