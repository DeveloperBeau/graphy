package cryptobench.ciphers.affine;

public class AffineKey {
    private final int a;
    private final int b;

    public AffineKey(int a, int b) {
        this.a = a;
        this.b = b;
    }

    public int getA() { return a; }

    public int getB() { return b; }

    public int inverseOfA() {
        for (int candidate = 1; candidate < 26; candidate++) {
            if ((a * candidate) % 26 == 1) {
                return candidate;
            }
        }
        throw new IllegalStateException("a is not coprime with 26");
    }

    public static AffineKey defaultKey() {
        return new AffineKey(5, 8);
    }
}
