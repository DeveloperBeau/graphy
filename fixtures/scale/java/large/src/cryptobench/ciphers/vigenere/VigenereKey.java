package cryptobench.ciphers.vigenere;

public class VigenereKey {
    private final String keyword;

    public VigenereKey(String keyword) {
        this.keyword = keyword.toUpperCase();
    }

    public String getKeyword() {
        return keyword;
    }

    public char keyCharAt(int position) {
        return keyword.charAt(position % keyword.length());
    }

    public static VigenereKey defaultKey() {
        return new VigenereKey("LANTERN");
    }
}
