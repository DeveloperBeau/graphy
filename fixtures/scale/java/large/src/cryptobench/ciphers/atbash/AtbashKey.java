package cryptobench.ciphers.atbash;

public class AtbashKey {
    private final int unused;

    public AtbashKey(int unused) {
        this.unused = unused;
    }

    public int getUnused() {
        return unused;
    }

    public static AtbashKey defaultKey() {
        return new AtbashKey(0);
    }
}
