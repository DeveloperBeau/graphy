package cryptobench.ciphers.caesar;

public class CaesarKey {
    private final int shift;

    public CaesarKey(int shift) {
        this.shift = shift;
    }

    public int getShift() {
        return shift;
    }

    public static CaesarKey defaultKey() {
        return new CaesarKey(7);
    }
}
