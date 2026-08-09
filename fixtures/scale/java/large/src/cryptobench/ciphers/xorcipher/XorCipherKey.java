package cryptobench.ciphers.xorcipher;

public class XorCipherKey {
    private final String phrase;

    public XorCipherKey(String phrase) {
        this.phrase = phrase;
    }

    public String getPhrase() {
        return phrase;
    }

    public static XorCipherKey defaultKey() {
        return new XorCipherKey("drift-anchor-22");
    }
}
