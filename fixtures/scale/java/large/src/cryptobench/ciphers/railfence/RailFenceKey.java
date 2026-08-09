package cryptobench.ciphers.railfence;

public class RailFenceKey {
    private final int rails;

    public RailFenceKey(int rails) {
        this.rails = rails;
    }

    public int getRails() {
        return rails;
    }

    public static RailFenceKey defaultKey() {
        return new RailFenceKey(3);
    }
}
