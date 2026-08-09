package cryptobench.ciphers.affine

class AffineKey {
    final int a
    final int b

    AffineKey(int a, int b) {
        this.a = a
        this.b = b
    }

    int inverseOfA() {
        for (int candidate = 1; candidate < 26; candidate++) {
            if ((a * candidate) % 26 == 1) return candidate
        }
        throw new IllegalStateException("a is not coprime with 26")
    }

    static AffineKey defaultKey() {
        return new AffineKey(5, 8)
    }
}
