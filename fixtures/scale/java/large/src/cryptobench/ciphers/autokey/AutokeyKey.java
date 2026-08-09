package cryptobench.ciphers.autokey;

public class AutokeyKey {
    private final String primer;

    public AutokeyKey(String primer) {
        this.primer = primer.toUpperCase();
    }

    public String getPrimer() {
        return primer;
    }

    public static AutokeyKey defaultKey() {
        return new AutokeyKey("EMBER");
    }
}
