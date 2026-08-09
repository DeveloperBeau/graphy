package cryptobench.ciphers.bifid;

public class BifidKey {
    private final String seedWord;

    public BifidKey(String seedWord) {
        this.seedWord = seedWord;
    }

    public String getSeedWord() {
        return seedWord;
    }

    public static BifidKey defaultKey() {
        return new BifidKey("CIPHER");
    }
}
